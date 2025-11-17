function wipe-warp
    # ----- 0.  grab sudo up-front -----
    if not sudo -n true 2>/dev/null
        echo "Enter password to regenerate /etc/machine-id (or Ctrl-C to skip):"
        sudo -v || echo "No sudo – system machine-id will stay unchanged."
    end

    # ----- 1.  kill Warp -----
    pkill -f '[Ww]arp'; or true
    sleep 0.5

    # ----- 2.  user-data folders (your find output) -----
    set -l dirs \
          $HOME/.config/warp-terminal \
          $HOME/.cache/warp-terminal \
          $HOME/.local/state/warp-terminal \
          $HOME/.local/share/warp-terminal

    for d in $dirs
        test -d $d; and echo "Removing $d"; rm -rf $d
    end

    # ----- 3.  login token & device ids -----
    # macOS style plist (Warp writes both paths on Linux too)
    set -l prefs_plist $HOME/Library/Preferences/dev.warp.Warp-Stable.plist
    test -f $prefs_plist; and rm -f $_

    # Electron config cache that keeps device UUID
    set -l electron_cfg $HOME/.config/Electron/config.json
    test -f $electron_cfg; and rm -f $_

    # ----- 4.  telemetry / analytics ids -----
    # Rudderstack anonymous-id
    set -l rudder_id $HOME/.warp/anonymous_id
    test -f $rudder_id; and rm -f $_

    # Sentry crash-id
    set -l sentry_cache $HOME/.cache/sentry
    test -d $sentry_cache; and rm -rf $_

    # ----- 5.  logs (so old ids aren’t on disk) -----
    set -l log_globs \
          $HOME/.local/state/warp-terminal/warp.log* \
          $HOME/Library/Logs/warp.log*
    for g in $log_globs
        for f in (printf '%s\n' $g 2>/dev/null)
            test -f $f; and rm -f $f
        end
    end

    # ----- 6.  system machine-id -----
    if sudo -n true 2>/dev/null
        echo "Regenerating /etc/machine-id"
        sudo rm -f /etc/machine-id
        sudo systemd-machine-id-setup
    else
        echo "No sudo – /etc/machine-id left untouched."
    end

    # ----- 7.  NEW random device ids (so Warp doesn’t reuse old ones) -----
    mkdir -p $HOME/.warp
    # anonymous_id used by Rudderstack
    if type -q uuidgen; uuidgen > $HOME/.warp/anonymous_id
    else if type -q python; python -c "import uuid,sys; sys.stdout.write(str(uuid.uuid4()))" > $HOME/.warp/anonymous_id
    else; cat /proc/sys/kernel/random/uuid > $HOME/.warp/anonymous_id
    end
    chmod 600 $HOME/.warp/anonymous_id

    echo "Warp reset complete – launch it and you’ll be treated as a brand-new user on a brand-new machine."
end