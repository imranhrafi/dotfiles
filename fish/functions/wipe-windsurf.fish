function wipe-windsurf
    # ----- 0.  Pre-flight sudo (so we get the password once) -----
    if not sudo -n true 2>/dev/null
        echo "Enter your password to regenerate /etc/machine-id:"
        sudo -v || echo "No sudo – system machine-id will stay unchanged."
    end

    # ----- 1.  Kill Windsurf & friends -----
    pkill -f '[Ww]indsurf'; or true
    sleep 0.5

    # ----- 2.  Remove every user-data directory -----
    set -l dirs \
          $HOME/.config/Windsurf \
          $HOME/.config/windsurf \
          $HOME/.config/Windsurf-Editor \
          $HOME/.cache/Windsurf \
          $HOME/.cache/windsurf \
          $HOME/.cache/Windsurf-Editor \
          $HOME/.local/share/Windsurf \
          $HOME/.local/share/windsurf \
          $HOME/.local/share/Windsurf-Editor \
          $HOME/.windsurf \
          $HOME/.codeium

    for d in $dirs
        test -d $d; and echo "Removing $d"; rm -rf $d
    end

    # ----- 3.  VS-Code extension leftovers -----
    for glob in $HOME/.vscode*/extensions/windsurf*
        for d in (printf '%s\n' $glob 2>/dev/null)
            test -d $d; and echo "Removing $d"; rm -rf $d
        end
    end

    # ----- 4.  Chrome IDB / desktop files / yay cache -----
    set -l chrome_idb $HOME/.config/google-chrome/Default/IndexedDB/https_windsurf.com_0.indexeddb.leveldb
    test -d $chrome_idb; and rm -rf $chrome_idb

    test -f $HOME/.local/share/applications/windsurf.desktop;   and rm -f $_
    test -f $HOME/.local/share/applications/Windsurf-Editor.desktop; and rm -f $_
    test -d $HOME/.cache/yay/windsurf; and rm -rf $_

    # ----- 5.  SYSTEM machine-id -----
    if sudo -n true 2>/dev/null
        echo "Regenerating /etc/machine-id"
        sudo rm -f /etc/machine-id
        sudo systemd-machine-id-setup
    else
        echo "No sudo rights – /etc/machine-id left untouched."
    end

    # ----- 6.  NEW random IDs -----
    # 6a. user-level machine-id (Codeium)
    mkdir -p $HOME/.codeium
    # pick one of the following generators:
    if type -q uuidgen          # util-linux
        uuidgen > $HOME/.codeium/machine_id
    else if type -q python      # python3 everywhere
        python -c "import uuid,sys; sys.stdout.write(str(uuid.uuid4()))" > $HOME/.codeium/machine_id
    else if type -q openssl
        openssl rand -hex 16 > $HOME/.codeium/machine_id
    else                        # last resort: /proc/sys/kernel/random/uuid
        cat /proc/sys/kernel/random/uuid > $HOME/.codeium/machine_id
    end
    chmod 600 $HOME/.codeium/machine_id

    # 6b. environment override (Electron picks this up sometimes)
    set -gx MACHINE_ID (cat $HOME/.codeium/machine_id)

    echo "All IDs wiped & regenerated.  Launch Windsurf – it will see a NEW machine + NEW user."
end