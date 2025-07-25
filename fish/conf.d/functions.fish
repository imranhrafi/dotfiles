function create-convex
    if test (count $argv) -eq 0
        echo "Usage: create-convex <project-name> [shadcn-components...]"
        return 1
    end

    set project $argv[1]
    set components $argv[2..-1]

    echo "🔧 Creating Convex project..."
    npm create convex@latest $project -- \
        --use-pnpm \
        --client nextjs-app-router \
        --auth convex

    or begin
        echo "❌ Convex project creation failed."
        return 1
    end

    cd $project

    echo "🎨 Initializing shadcn/ui..."
    pnpm dlx shadcn@latest init --yes --base-color neutral
    or begin
        echo "❌ shadcn init failed."
        return 1
    end

    if test (count $components) -gt 0
        echo "📦 Adding: $components"
        pnpm dlx shadcn@latest add $components
    else
        echo "📦 Adding default components..."
        pnpm dlx shadcn@latest add --all
    end

    echo "🔧 Initializing Git repository..."
    pnpm install convex-ents convex-helpers @convex-dev/auth @auth/core
    git init
    git add .
    git commit -m "Initial commit: Convex + Next.js + shadcn/ui setup"
    git branch -M main

    echo "✅ Project '$project' ready! Starting development server..."
    pnpm dev
end

# Clean all development files
function clean-dev
    echo "🧹 Cleaning node_modules and .next..."
    if test -d node_modules
        rm -rf node_modules
        echo "✅ Removed node_modules"
    end
    if test -d .next
        rm -rf .next
        echo "✅ Removed .next"
    end
    echo "🔄 Reinstalling node_modules with pnpm..."
    pnpm install
    if test $status -eq 0
        echo "🚀 Starting development server with pnpm dev..."
        pnpm dev
    else
        echo "❌ pnpm install failed. Not starting dev server."
        return 1
    end
end

# Enhanced reload function
function reload
    echo "🔄 Reloading Fish shell (full session)..."
    exec fish
end

# Updated history function (more useful)
function fish-history
    if test (count $argv) -eq 0
        builtin history --show-time='%F %T ' | head -50
    else
        builtin history --show-time='%F %T ' | grep -i $argv[1]
    end
end

function resetcursor --description "Advanced Cursor reset to avoid device fingerprinting"
    echo "🔄 Starting advanced Cursor reset..."

    # Kill all cursor processes
    killall cursor &>/dev/null
    pkill -f cursor &>/dev/null
    sleep 2

    # Remove machine ID and regenerate
    sudo rm -f /etc/machine-id
    sudo systemd-machine-id-setup

    # Remove all Cursor user data
    rm -rf ~/.config/Cursor ~/.cache/Cursor ~/.local/share/Cursor ~/.local/state/Cursor

    # Remove any desktop entries
    rm -f ~/.local/share/applications/cursor*.desktop &>/dev/null

    # Clear system logs that might contain Cursor activity
    sudo journalctl --vacuum-time=1s &>/dev/null

    # Optional: Generate new MAC address (requires network restart)
    echo "🔧 Consider changing MAC address:"
    echo "   sudo macchanger -r $(ip route | grep default | awk '{print $5}' | head -1)"

    # Optional: Clear browser-like data that Cursor might store
    rm -rf ~/.config/Cursor* ~/.cache/Cursor* ~/.local/share/Cursor* &>/dev/null

    # Clear any potential temp files
    find /tmp -name "*cursor*" -type f -delete &>/dev/null
    find /var/tmp -name "*cursor*" -type f -delete &>/dev/null

    echo "✅ Advanced Cursor reset complete!"
    echo "🔄 Reboot system and consider:"
    echo "   - Use different network/VPN"
    echo "   - Change MAC address"
    echo "   - Use different timezone"
    echo "   - Different screen resolution"
end

