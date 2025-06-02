function update
    echo "🔄 Updating system packages..."
    sudo pacman -Syu --noconfirm
    echo "📦 Updating AUR packages..."
    yay -Syu --noconfirm
    echo "🧹 Cleaning package cache..."
    sudo pacman -Sc --noconfirm
    yay -Sc --noconfirm
    echo "✨ System update complete!"
end 