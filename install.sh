#!/bin/bash
mkdir -p ~/.config/nvim
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ln -sf "$DOTFILES_DIR/.tmux.conf" ~/.tmux.conf
ln -sf "$DOTFILES_DIR/init.lua" ~/.config/nvim/init.lua
echo "Dotfiles linked!"
