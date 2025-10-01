#!/bin/bash
#
# install.sh
#
# This script orchestrates the entire setup for the dotfiles repository.
# It installs software, creates symlinks using stow, and sets permissions.

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

# --- Set Script Directory ---
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$DOTFILES_DIR" || exit

# --- Step 1: Set Permissions ---
print_info "Setting executable permissions for scripts..."
chmod +x software.sh
chmod +x scripts/t
chmod +x new-nextjs.sh
print_success "Script permissions set."

# --- Step 2: Install Software ---
print_info "Running the software installation script..."
if ./software.sh; then
    print_success "Software installation completed."
else
    print_error "Software installation failed. Please check the output above."
    exit 1
fi

# --- Step 3: Create Symlinks with Stow ---
# Stow works by symlinking files/folders from a package directory (e.g., 'nvim')
# into the parent directory of the stow directory (in this case, $HOME).
# We specify the target directory as $HOME.
print_info "Creating symlinks using GNU Stow..."

# List of packages to stow
# Note: 'zsh' is handled separately as it links to the home dir, not .config
STOW_PACKAGES=(
    alacritty
    espanso
    fish
    kitty
    nvim
    tmux
    wezterm
    yazi
    # Add any new config directories here
)

for package in "${STOW_PACKAGES[@]}"; do
    print_info "Stowing '$package'..."
    if stow --target="$HOME" --restow "$package"; then
        print_success "'$package' stowed successfully."
    else
        print_error "Failed to stow '$package'. Please check for conflicts."
    fi
done

# --- Step 4: Handle Special Cases ---
# Some files need to be linked directly to the home directory, not .config
print_info "Handling special symlink cases..."

# Zsh configuration
if ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"; then
    print_success "Linked .zshrc successfully."
else
    print_error "Failed to link .zshrc."
fi

# Ensure local bin directory exists and link scripts
mkdir -p "$HOME/.local/bin"
if ln -sf "$DOTFILES_DIR/scripts/t" "$HOME/.local/bin/t"; then
    print_success "Linked 't' script to ~/.local/bin."
else
    print_error "Failed to link 't' script."
fi


# --- Finalization ---
print_success "Dotfiles setup is complete!"
print_info "Please restart your shell or source your shell's configuration file (e.g., 'source ~/.zshrc') for changes to take effect."