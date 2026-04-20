# path to second_brain repo for notes
export SECOND_BRAIN="$HOME/Repos/github.com/erikrhanson/second_brain"

# Custom scripts
export PATH=$HOME/Repos/github.com/erikrhanson/dotfiles/bin:$PATH

# Set Editor so system tools use Neovim
export EDITOR="nvim"

# alias Neovim
alias v='nvim'

# eval starship for our super nifty cli prompts
# eval "$(starship init bash)"

# Use PodMan for our Docker needs
export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"
