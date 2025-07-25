autoload -Uz compinit
compinit

# Path to your dotfiles directory
export DOTFILES_DIR="/mnt/Projects/dotfiles"

# Load custom aliases and functions
source "$DOTFILES_DIR/zsh/conf.d/aliases.zsh"
source "$DOTFILES_DIR/zsh/functions/yazi_functions.zsh"
source "$DOTFILES_DIR/zsh/functions/dev_functions.zsh"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"



# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  docker
  npm
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
  yarn
)

source $ZSH/oh-my-zsh.sh



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

# --- Custom Pure Prompt for a Modern Developer ---

# 1. Visual Flair & Icons
# Using a rocket for success and fire for errors.
zstyle :prompt:pure:prompt:success symbol '🚀'
zstyle :prompt:pure:prompt:error symbol '🔥'

# Setting a cool color scheme (Catppuccin inspired).
zstyle :prompt:pure:prompt:success color '#89b4fa' # Blue
zstyle :prompt:pure:prompt:error color '#f38ba8'   # Red
zstyle :prompt:pure:path color '#a6e3a1'            # Green
zstyle :prompt:pure:git:branch color '#f9e2af'      # Yellow
zstyle :prompt:pure:git:action color '#cba6f7'      # Mauve

# 2. Rich Git Information
# Show details like staged/unstaged files.
zstyle :prompt:pure:git:dirty show yes
# Show if the branch is ahead/behind remote.
zstyle :prompt:pure:git:branch:sync show yes
# Show current git action (merge, rebase, etc.).
zstyle :prompt:pure:git:action show yes

# 3. Context-Aware Info
# Show user@host only when in an SSH session to keep it clean.
zstyle :prompt:pure:user:show ssh
# Show how long a command took to run, but only if it's over 5 seconds.
zstyle :prompt:pure:execution_time:show yes
zstyle :prompt:pure:execution_time:threshold 5

# 4. Development Environment Info (Node.js Version)
# This function adds the Node.js version to the prompt.
# It only shows up when you're in a directory with a package.json file.
prompt_pure_preprompt_render() {
    if [[ -f "package.json" || -d "node_modules" ]]; then
        local node_version
        node_version=$(node -v 2>/dev/null)
        if [[ -n "$node_version" ]]; then
            print -Pn " %F{#88c0d0}⬢ ${node_version}%f"
        fi
    fi
}

# --- Load Pure Theme ---
fpath+=("$HOME/.oh-my-zsh/custom/themes/pure")
autoload -U promptinit; promptinit
prompt pure

# --- pnpm setup for Zsh ---
export PNPM_HOME="/home/rafi/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"