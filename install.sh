#!/bin/bash

# Define directories
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

# Build the source line dynamically from DOTFILES_DIR
SOURCE_LINE="source \"${DOTFILES_DIR}/exports.sh\""

# Function to add the exports.sh to the system's '.rc' file.
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

# === LazyVim Setup Function ===
setup_lazyvim() {
  echo "→ Setting up LazyVim..."

  # Check if neovim is installed
  if ! command -v nvim >/dev/null 2>&1; then
    echo "✗ Neovim is not installed. Skipping LazyVim setup."
    echo "   (A basic vim will still be available)"
    return 0
  fi

  # Extract Neovim version (e.g. 0.10.4 or 0.11.2)
  NVIM_VERSION=$(nvim --version | head -n1 | grep -oE 'NVIM v[0-9]+\.[0-9]+\.[0-9]+' | cut -d' ' -f2 | sed 's/^v//')

  if [[ -z "$NVIM_VERSION" ]]; then
    echo "✗ Could not detect Neovim version. Skipping LazyVim setup."
    return 0
  fi

  # Minimum required version for LazyVim
  MIN_NVIM_VERSION="0.11.2"

  # Compare versions using sort -V (semantic versioning)
  if [[ "$(printf '%s\n' "$MIN_NVIM_VERSION" "$NVIM_VERSION" | sort -V | head -n1)" == "$MIN_NVIM_VERSION" ]]; then
    echo "✓ Neovim $NVIM_VERSION detected (>= $MIN_NVIM_VERSION)"

    # Only clone if ~/.config/nvim doesn't exist or is empty
    if [[ ! -d "$HOME/.config/nvim" ]] || [[ -z "$(ls -A "$HOME/.config/nvim" 2>/dev/null)" ]]; then
      echo "→ Cloning LazyVim starter..."
      git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
      rm -rf "$HOME/.config/nvim/.git"
      echo "✓ LazyVim starter installed successfully!"
    else
      echo "→ ~/.config/nvim already exists. Skipping clone."
    fi
  else
    echo "⚠ Neovim version $NVIM_VERSION is older than $MIN_NVIM_VERSION."
    echo "   LazyVim requires >= $MIN_NVIM_VERSION → Skipping LazyVim setup."
    echo "   A basic Neovim/vim will still be available."
  fi
}

echo " Starting 2026 Dotfile Setup..."

# 1. Create necessary directories
mkdir -p "$CONFIG_DIR/nvim"
mkdir -p "$CONFIG_DIR/sway"

# 2. Clone in LazyVim (only if neovim is new enough)
setup_lazyvim

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
