function warp-reset --description "Completely reset Warp Terminal to appear as a fresh new device"
    echo "🔄 Starting Warp Terminal complete reset..."

    # Step 1: Kill all Warp processes
    echo "⏹️  Stopping Warp Terminal processes..."
    pkill -f warp 2>/dev/null
    pkill -f Warp 2>/dev/null

    # Stop specific systemd user services
    systemctl --user stop "app-dev.warp.Warp@"* 2>/dev/null
    systemctl --user disable "app-dev.warp.Warp@"* 2>/dev/null
    systemctl --user stop warp-terminal 2>/dev/null
    systemctl --user disable warp-terminal 2>/dev/null

    sleep 2 # Give processes time to terminate

    # Step 2: Remove all Warp Terminal data
    echo "🗂️  Removing Warp Terminal configuration and cache..."
    rm -rf ~/.config/warp-terminal/ 2>/dev/null
    rm -rf ~/.cache/warp-terminal/ 2>/dev/null
    rm -rf ~/.local/state/warp-terminal/ 2>/dev/null

    # Step 3: Clear browser data
    echo "🌐 Clearing browser data for Warp..."
    rm -rf ~/.config/google-chrome/Default/IndexedDB/https_app.warp.dev_0.indexeddb.leveldb/ 2>/dev/null
    find ~/.config/google-chrome/Default/Local\ Storage/leveldb/ -name "*warp*" -delete 2>/dev/null
    find ~/.config/chromium/Default/Local\ Storage/leveldb/ -name "*warp*" -delete 2>/dev/null
    find ~/.mozilla/firefox/*/storage/default/ -name "*warp*" -exec rm -rf {} \; 2>/dev/null

    # Step 4: Clear temporary files
    echo "🧹 Cleaning temporary files..."
    find /tmp -name "*warp*" -exec rm -rf {} \; 2>/dev/null
    find /var/tmp -name "*warp*" -exec rm -rf {} \; 2>/dev/null
    rm -f ~/.local/state/nvim/undo/*warp* 2>/dev/null
    rm -f ~/.local/state/nvim/swap/*warp* 2>/dev/null

    # Step 5: Clear package manager cache (optional)
    echo "📦 Clearing package cache..."
    rm -rf ~/.cache/yay/warp-terminal-bin/ 2>/dev/null
    rm -rf ~/.cache/paru/warp-terminal-bin/ 2>/dev/null

    # Step 6: Regenerate machine ID
    echo "🆔 Regenerating machine ID..."
    set old_machine_id (cat /etc/machine-id 2>/dev/null)

    # Remove current machine IDs
    sudo rm /etc/machine-id 2>/dev/null
    sudo rm /var/lib/dbus/machine-id 2>/dev/null

    # Generate new machine ID
    sudo systemd-machine-id-setup >/dev/null 2>&1

    # Restart systemd services to pick up new machine ID (without full reboot)
    echo "🔄 Restarting system services with new machine ID..."
    sudo systemctl daemon-reload
    sudo systemctl restart systemd-journald
    sudo systemctl restart dbus 2>/dev/null
    systemctl --user daemon-reload

    # Get new machine ID
    set new_machine_id (cat /etc/machine-id 2>/dev/null)

    # Step 7: Final verification
    echo "✅ Verification:"
    if test "$old_machine_id" != "$new_machine_id"
        echo "   Machine ID changed: $old_machine_id → $new_machine_id"
    else
        echo "   ⚠️  Machine ID might not have changed properly"
    end

    # Check for remaining warp files
    set remaining_dirs (find ~ -name "*warp*" -type d 2>/dev/null | grep -v -E "(node_modules|\.bun|\.vscode|\.jd|Downloads|Archives)")
    set remaining_files (find ~ -name "*warp*" -type f 2>/dev/null | grep -v -E "(node_modules|\.bun|\.vscode|\.jd|Downloads|Archives|prism-warpscript|warpscript)" | head -5)

    if test (count $remaining_dirs) -eq 0 -a (count $remaining_files) -eq 0
        echo "   ✅ All Warp Terminal data successfully removed"
    else
        echo "   ⚠️  Some files may remain (likely unrelated to Warp Terminal)"
    end

    # Check if any warp processes are still running
    set warp_processes (ps aux | grep -i warp | grep -v grep | wc -l)
    if test $warp_processes -eq 0
        echo "   ✅ No Warp processes running"
    else
        echo "   ⚠️  Some Warp processes may still be running"
    end

    echo ""
    echo "🎉 Warp Terminal reset complete!"
    echo "   Your machine now appears as a completely new device to Warp Terminal."
    echo "   You can now launch Warp Terminal and sign in with any email address."
    echo ""
    echo "💡 To launch Warp Terminal: warp-terminal"
end
