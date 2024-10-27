#!/bin/bash

# Define function to check for errors
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error occurred: $1"
        exit 1
    fi
}

# Function to install 'yay' if not already installed
install_yay() {
    echo "Checking for 'yay' (AUR helper)..."
    if ! command -v yay &> /dev/null; then
        echo "'yay' not found. Installing..."

        # Update package lists and install necessary packages
        sudo pacman -Sy --noconfirm
        check_success "Failed to update package lists."

        sudo pacman -S --needed --noconfirm base-devel git
        check_success "Failed to install base-devel and git."

        # Clone and install yay
        git clone https://aur.archlinux.org/yay.git
        check_success "Failed to clone yay repository."

        cd yay || { echo "Failed to enter yay directory."; exit 1; }
        makepkg -si --noconfirm
        check_success "Failed to build and install yay."

        cd .. && rm -rf yay
        echo "yay installed successfully."
    else
        echo "'yay' is already installed."
    fi
}

# Install yay if necessary
install_yay

# Install packages from official repositories
echo "Installing packages from official repositories..."
sudo pacman -S --noconfirm --needed \
    alacritty \
    wezterm \
    fish \
    neovim \
    tmux \
    fastfetch \
    git \
    vlc \
    python \
    postgresql \
    nodejs \
    npm \
    unzip \
check_success "Failed to install official repository packages."

# Install packages from AUR using yay
echo "Installing AUR packages..."
yay -S --noconfirm --needed \
    nerd-fonts-noto-sans-mono \
    postman \
    google-chrome \
    visual-studio-code-bin \
    eza \

check_success "Failed to install AUR packages."

# Install Bun
echo "Installing Bun..."
curl -fsSL https://bun.sh/install | bash
check_success "Failed to install Bun."

echo "Software installation complete!"
