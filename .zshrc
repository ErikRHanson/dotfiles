# Path to your devcontainer tools
export PATH="$HOME/.devcontainers/bin:$HOME/bin:/usr/local/bin:$PATH"

# Load Starship Prompt (Install via devcontainer features)
eval "$(starship init zsh)"

# Helpful 2026 Aliases
alias v="nvim"
alias g="git"
# alias dps="docker ps"
# alias pull-db="aws s3 cp s3://your-bucket/data.duckdb ./data/"
# alias push-db="aws s3 cp ./data.duckdb s3://your-bucket/data/"

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST

# Basic operations
setopt autocd
setopt extendedglob
unsetopt beep

# Completion
autoload -Uz compinit
compinit

# Plugins (Arch Packages)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Key bindings for substring search (up/down arrows)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '

source "$HOME/Repos/github.com/erikrhanson/dotfiles/exports.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
