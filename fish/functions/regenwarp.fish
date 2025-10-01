function regenwarp -d "Completely reset Warp Terminal: remove all data and optionally reinstall"
    set -l RED (set_color red)
    set -l GREEN (set_color green)
    set -l BLUE (set_color blue)
    set -l NORMAL (set_color normal)

    echo "$BLUE🔁 Starting regenwarp: Full reset of Warp Terminal...$NORMAL"

    # Kill warp if running
    if pgrep -f "Warp\.app" >/dev/null
        echo "$BLUE🛑 Killing Warp Terminal process...$NORMAL"
        pkill -f "Warp\.app"
        sleep 2
        if pgrep -f "Warp\.app" >/dev/null
            echo "$RED⚠️  Warp still running, force killing...$NORMAL"
            pkill -9 -f "Warp\.app"
        end
    else
        echo "$GREEN✅ No running Warp process found.$NORMAL"
    end

    # Define core paths to remove (from original list)
    set -l core_paths \
        ~/.config/warp-terminal \
        ~/.cache/warp-terminal \
        ~/.local/state/warp-terminal \
        ~/.local/state/nvim/undo/%home%rafi%.config%warp-terminal%user_preferences.json \
        ~/.local/state/nvim/sessions/%home%rafi%.config%warp-terminal.vim \
        ~/.cache/yay/warp-terminal-bin \
        ~/.config/google-chrome/Default/IndexedDB/https_app.warp.dev_0.indexeddb.leveldb

    # Additional paths found in cross-match that are actually Warp-related
    set -l additional_paths \
        ~/.local/state/warp-terminal/warp.log \
        ~/.local/state/warp-terminal/warp.sqlite \
        ~/.local/state/warp-terminal/warp.sqlite-wal \
        ~/.local/state/warp-terminal/warp.sqlite-shm \
        ~/.local/state/warp-terminal/warp_network.log \
        ~/.local/state/warp-terminal/warp.log.old.*

    # Combine all paths
    set -l paths_to_remove $core_paths $additional_paths

    # Remove each path
    for path in $paths_to_remove
        if test -e "$path"
            echo "$BLUE🗑️  Removing: $path$NORMAL"
            rm -rf "$path"
            echo "$GREEN✅ Removed.$NORMAL"
        else
            echo "$GREEN✅ Already gone: $path$NORMAL"
        end
    end

    # Also clean up any empty warp-terminal directories that might remain
    for dir in ~/.config/warp-terminal ~/.cache/warp-terminal ~/.local/state/warp-terminal
        if test -d "$dir" -a (count (ls -A "$dir")) -eq 0
            echo "$BLUE🧹 Removing empty directory: $dir$NORMAL"
            rmdir "$dir"
        end
    end

    # Optional: Reinstall via yay? (set to 'no' by default)
    echo "$BLUE💡 Warp Terminal data wiped.$NORMAL"
    echo -n "$BLUE🔄 Do you want to reinstall warp-terminal-bin now? (y/N): $NORMAL"
    read -P "" -l choice

    if string match -q -i "y*" "$choice"
        echo "$BLUE📥 Reinstalling warp-terminal-bin...$NORMAL"
        if type -q yay
            yay -S warp-terminal-bin
        else if type -q paru
            paru -S warp-terminal-bin
        else
            echo "$RED❌ Neither yay nor paru found. Cannot reinstall.$NORMAL"
        end
    else
        echo "$GREEN✅ Done. Warp Terminal is fully removed. Use 'yay -S warp-terminal-bin' to reinstall later.$NORMAL"
    end
end
