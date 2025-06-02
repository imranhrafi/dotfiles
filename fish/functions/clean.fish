function clean
    echo "🧹 Cleaning temporary files..."
    rm -rf ~/.cache/*
    echo "🗑️  Cleaning trash..."
    rm -rf ~/.local/share/Trash/*
    echo "📦 Cleaning package cache..."
    sudo pacman -Sc --noconfirm
    echo "✨ Cleanup complete!"
end 