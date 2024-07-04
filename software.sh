#!/bin/bash

# Check if 'yay' (or your preferred AUR helper) is installed
if ! command -v yay &> /dev/null; then
  echo "AUR helper 'yay' not found. Installing..."

  # Update package lists (optional, but recommended for fresh installs)
  sudo pacman -Sy

  # Install base-devel package (needed for building yay)
  sudo pacman -S --needed base-devel git

  # Clone yay Git repository
  git clone https://aur.archlinux.org/yay.git

  # Build and install yay
  cd yay
  makepkg -si

  # Move back to the script directory
  cd ..

  echo "yay installed successfully."
fi

# Install desired software from official repositories and AUR
sudo pacman -S \
    google-chrome \
    visual-studio-code-bin \
    alacritty \
    fish \
    neovim \
    tmux \
    fastfetch \
    git \
    vlc \
    python \
    postgresql \
    nodejs

yay -S \
    nerd-fonts-noto-sans-mono \
    postman

echo "Software installation complete!"
