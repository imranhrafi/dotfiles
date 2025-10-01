#!/bin/bash
#
# software.sh
#
# This script installs all the necessary software for the dotfiles configuration.
# It is intended for Arch Linux based systems (like Garuda).

# --- Helper Functions ---
print_info() {
    echo -e "\e[34m[INFO]\e[0m $1"
}

print_success() {
    echo -e "\e[32m[SUCCESS]\e[0m $1"
}

print_error() {
    echo -e "\e[31m[ERROR]\e[0m $1"
}

# --- Update System ---
print_info "Updating system packages..."
sudo pacman -Syu --noconfirm || { print_error "Failed to update system packages."; exit 1; }

# --- Core Applications & Terminals ---
print_info "Installing core applications and terminal emulators..."
sudo pacman -S --noconfirm --needed \
    alacritty \
    kitty \
    wezterm \
    tmux \
    neovim \
    espanso-wayland || { print_error "Failed to install core applications."; exit 1; }

# --- Shells ---
print_info "Installing shells..."
sudo pacman -S --noconfirm --needed \
    fish \
    zsh || { print_error "Failed to install shells."; exit 1; }

# --- CLI Tools & Utilities ---
print_info "Installing essential CLI tools and utilities..."
sudo pacman -S --noconfirm --needed \
    git \
    stow \
    lazygit \
    eza \
    bat \
    fd \
    ripgrep \
    fzf \
    zoxide \
    starship \
    unzip || { print_error "Failed to install CLI tools."; exit 1; }

# --- Yazi (File Manager) Dependencies ---
print_info "Installing dependencies for Yazi file manager..."
sudo pacman -S --noconfirm --needed \
    ffmpegthumbnailer \
    unarchiver \
    poppler || { print_error "Failed to install Yazi dependencies."; exit 1; }

# --- Development Environment ---
print_info "Installing development environment tools..."
sudo pacman -S --noconfirm --needed \
    nodejs-lts-gallium \
    npm \
    bun \
    deno \
    stylua || { print_error "Failed to install development tools."; exit 1; }

print_success "All software has been installed successfully!"

print_info "Please restart your terminal or source your shell configuration for all changes to take effect."