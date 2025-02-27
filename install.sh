#!/usr/bin/env bash

# Get directory containing dotfiles
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# # Refresh mirrors for faster and more reliable downloads
# echo "Updating package mirrors for optimized download speeds..."
# sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist

# # Full system update
# echo "Updating system packages to avoid conflicts..."
# sudo pacman -Syu --noconfirm


# # Run software installation script
# echo "Running software installation script..."
# "$DOTFILES_DIR/software.sh"

# Function to create symlinks with error handling
create_symlink() {
    local target=$1
    local link_name=$2
    rm -rf "$link_name"
    ln -sT "$target" "$link_name"
    if [ $? -eq 0 ]; then
        echo "Linked $link_name -> $target"
    else
        echo "Failed to link $link_name"
    fi
}

# Alacritty configuration
echo "Setting up Alacritty configuration..."
create_symlink "$DOTFILES_DIR/alacritty" "$HOME/.config/alacritty"

# Tmux configuration
echo "Setting up Tmux configuration..."
create_symlink "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

# Ensure local bin directory exists
echo "Ensuring local bin directory exists..."
mkdir -p "$HOME/.local/bin"

# Script link
echo "Linking custom script to ~/.local/bin..."
create_symlink "$DOTFILES_DIR/scripts/t" "$HOME/.local/bin/t"

# Neovim configuration
echo "Setting up Neovim configuration..."
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Hypr configuration
echo "Setting up Hypr configuration..."
create_symlink "$DOTFILES_DIR/hypr" "$HOME/.config/hypr"

# Kitty configuration
echo "Setting up Kitty configuration..."
create_symlink "$DOTFILES_DIR/kitty" "$HOME/.config/kitty"

# Yazi configuration
echo "Setting up Yazi configuration..."
create_symlink "$DOTFILES_DIR/yazi" "$HOME/.config/yazi"

# Wezterm configuration
echo "Setting up Wezterm configuration..."
create_symlink "$DOTFILES_DIR/wezterm" "$HOME/.config/wezterm"

# Fish configuration
echo "Setting up Fish configuration..."
create_symlink "$DOTFILES_DIR/fish" "$HOME/.config/fish"

echo "Dotfiles setup complete!"
