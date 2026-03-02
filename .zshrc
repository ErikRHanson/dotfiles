# Path to your devcontainer tools
export PATH="$HOME/.devcontainers/bin:$PATH"

# Load Starship Prompt (Install via devcontainer features)
eval "$(starship init zsh)"

# Helpful 2025 Aliases
alias v="nvim"
alias g="git"
alias dps="docker ps"
alias pull-db="aws s3 cp s3://your-bucket/data.duckdb ./data/"
alias push-db="aws s3 cp ./data.duckdb s3://your-bucket/data/"

# History settings (crucial for long EC2 sessions)
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY