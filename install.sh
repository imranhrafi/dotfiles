#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

# Alacritty configuration
rm -rf $HOME/.config/alacritty
ln -sT $DOTFILES/alacritty $HOME/.config/alacritty

# Tmux configuration
rm -f $HOME/.tmux.conf
ln -sT $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf

# Ensure local bin directory exists
mkdir -p $HOME/.local/bin

# Script link
rm -f $HOME/.local/bin/t
ln -sT $DOTFILES/scripts/t $HOME/.local/bin/t

# Neovim configuration
rm -rf $HOME/.config/nvim
ln -sT $DOTFILES/nvim $HOME/.config/nvim

# Hypr configuration
rm -rf $HOME/.config/hypr
ln -sT $DOTFILES/hypr $HOME/.config/hypr
