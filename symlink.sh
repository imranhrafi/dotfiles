#!/usr/bin/env bash

# Get directory containing dotfiles
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

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

# Ensure local bin directory exists
echo "Ensuring local bin directory exists..."
mkdir -p "$HOME/.local/bin"

# Create all symlinks
echo "Setting up Alacritty configuration..."
create_symlink "$DOTFILES_DIR/alacritty" "$HOME/.config/alacritty"

echo "Setting up Tmux configuration..."
create_symlink "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

echo "Linking custom script to ~/.local/bin..."
create_symlink "$DOTFILES_DIR/scripts/t" "$HOME/.local/bin/t"

echo "Setting up Neovim configuration..."
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

echo "Setting up Hypr configuration..."
create_symlink "$DOTFILES_DIR/hypr" "$HOME/.config/hypr"

echo "Setting up Kitty configuration..."
create_symlink "$DOTFILES_DIR/kitty" "$HOME/.config/kitty"

echo "Setting up Yazi configuration..."
create_symlink "$DOTFILES_DIR/yazi" "$HOME/.config/yazi"

echo "Setting up Wezterm configuration..."
create_symlink "$DOTFILES_DIR/wezterm" "$HOME/.config/wezterm"

echo "Setting up Fish configuration..."
create_symlink "$DOTFILES_DIR/fish" "$HOME/.config/fish"

echo "Setting up Espanso configuration..."
create_symlink "$DOTFILES_DIR/espanso" "$HOME/.config/espanso"
echo "Symlink setup complete!"

