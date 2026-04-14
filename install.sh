#!/bin/bash

# Define directories
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

# Build the source line dynamically from DOTFILES_DIR
SOURCE_LINE="source \"${DOTFILES_DIR}/exports.sh\""

add_source_to_shellrc() {
  local rc_file="$1"

  if [[ -f "$rc_file" ]]; then
    if ! grep -qF "source \"${DOTFILES_DIR}/exports.sh\"" "$rc_file" &&
      ! grep -qF 'source "$HOME/Repos/github.com/erikrhanson/dotfiles/exports.sh"' "$rc_file"; then
      echo "" >>"$rc_file"
      echo "# Added by dotfiles installer" >>"$rc_file"
      echo "$SOURCE_LINE" >>"$rc_file"
      echo "✓ Added source line to $rc_file"
    else
      echo "→ Source line already exists in $rc_file"
    fi
  fi
}

echo " Starting 2026 Dotfile Setup..."

# 1. Create necessary directories
mkdir -p "$CONFIG_DIR/nvim"
mkdir -p "$CONFIG_DIR/sway"

# 2. Clone in LazyVim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# 3. Symlink Tmux (The outer shell)
echo " Linking Tmux..."
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

# 4. Symlink Zsh (The inner shell)
echo " Linking Zsh..."
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# 5. Symlink Sway
echo " Linking Sway.."
ln -sf "$DOTFILES_DIR/sway/config" "$CONFIG_DIR/sway/config"

# 6. Handle Starship (If you have a custom config)
if [ -f "$DOTFILES_DIR/starship.toml" ]; then
  mkdir -p "$CONFIG_DIR"
  ln -sf "$DOTFILES_DIR/starship.toml" "$CONFIG_DIR/starship.toml"
fi

# 7. Add to shell configs
add_source_to_shellrc "$HOME/.bashrc"
add_source_to_shellrc "$HOME/.zshrc"
add_source_to_shellrc "$HOME/.profile"

echo "✅ All links created!"

# 8. Post-install: Refresh Tmux settings if inside a session
if [ -n "$TMUX" ]; then
  tmux source-file ~/.tmux.conf
  echo "Sync'd Tmux config."
fi
