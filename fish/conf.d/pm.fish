## Package Manager and System Cleanup
# Dynamic package manager aliases
if type pacman >/dev/null 2>&1
    alias p="sudo pacman -S"
    alias pr="sudo pacman -Rs"
else if type apt >/dev/null 2>&1
    alias p="sudo apt install"
    alias pr="sudo apt remove"
end

# Package manager cleanup (enhanced)
function cleanup
    echo "🧹 Cleaning up system..."
    set orphans (pacman -Qdtq 2>/dev/null)
    if test -n "$orphans"
        sudo pacman -R $orphans
        echo "✅ Removed orphaned packages"
    else
        echo "✅ No orphaned packages found"
    end
    sudo pacman -Sc --noconfirm
    echo "✅ Package cache cleaned"
    if command -v pnpm >/dev/null
        pnpm store prune
        echo "✅ pnpm cache cleaned"
    end
end