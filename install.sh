#!/bin/bash
mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/init.lua ~/.config/nvim/init.lua
echo "Dotfiles linked!"
