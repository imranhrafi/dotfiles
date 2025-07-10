autoload -Uz compinit
compinit

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Path to your dotfiles directory
export DOTFILES_DIR="/mnt/Projects/dotfiles"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  docker
  npm
  yarn
  bun
  node
  nvm
  vscode
  web-search
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  z
  fzf
  colored-man-pages
  command-not-found
  common-aliases
  dirhistory
  extract
  fasd
  history
  httpie
  last-working-dir
  man
  sudo
  systemd
  tmux
  vi-mode
  virtualenv
  yarn
)

source $ZSH/oh-my-zsh.sh

# Load custom aliases and functions
source "$DOTFILES_DIR/zsh/conf.d/aliases.zsh"
source "$DOTFILES_DIR/zsh/functions/yazi_functions.zsh"
source "$DOTFILES_DIR/zsh/functions/dev_functions.zsh"

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# export EDITOR="nvim"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n "$SSH_CONNECTION" ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, or in ~/.oh-my-zsh/custom/aliases.zsh
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


