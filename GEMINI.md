# Gemini CLI Memory

This file serves as a persistent memory for the Gemini CLI agent within this project. It will be updated with relevant information, configurations, and learned facts to help the agent provide better assistance.

## Project Overview

This repository contains personal dotfiles for an Arch Linux (Garuda Hyprland) setup, primarily focused on web and software development. It includes configurations for various command-line tools and applications.

### Key Components and Their Configurations:

*   **Alacritty**: Terminal emulator configuration (`alacritty/alacritty.toml`, `alacritty/alacritty.yml`).
*   **Fish**: Fish shell configuration, including functions, completions, and prompt settings (`fish/config.fish`, `fish/conf.d/`, `fish/functions/`, `fish/completions/`).
*   **Kitty**: Terminal emulator configuration (`kitty/kitty.conf`).
*   **Neovim**: Neovim configuration, including lazy loading, keymaps, autocmds, and plugins (`nvim/init.lua`, `nvim/lua/config/`, `nvim/lua/plugins/`).
*   **Tmux**: Terminal multiplexer configuration (`tmux/tmux.conf`).
*   **Wezterm**: Terminal emulator configuration, including appearance, bindings, fonts, and event handling (`wezterm/wezterm.lua`, `wezterm/config/`, `wezterm/events/`).
*   **Yazi**: File manager configuration, including keymaps, themes, and plugins (`yazi/keymap.toml`, `yazi/theme.toml`, `yazi/yazi.toml`).
*   **Zsh**: Zsh shell configuration, including aliases and functions (`zsh/.zshrc`, `zsh/conf.d/`, `zsh/functions/`).

### Installation Process:

The installation typically involves:
1.  Cloning the repository.
2.  Making installation scripts executable (`install.sh`, `software.sh`, `symlink.sh`, `scripts/t`).
3.  Updating script paths (specifically `scripts/t`).
4.  Downloading necessary software via `software.sh`.
5.  Running the main installation script `install.sh` to set up symlinks and configurations.

### Development Focus:

The dotfiles are tailored for a development environment, with specific configurations for web and general software development workflows.