# Set environment values and shell settings
set fish_greeting
set -xU VIRTUAL_ENV_DISABLE_PROMPT 1
set -xU MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -xU MANROFFOPT -c
set -x SHELL /usr/bin/fish

# Set terminal title to "rafi@rafi" on startup
function fish_title
    echo "RafiCodes"
end

# Export variables needed for qt-theme, if qtile is installed
if type -q qtile
    set -x QT_QPA_PLATFORMTHEME qt5ct
end

# Set settings for "done" notifications
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

# Source additional environment profiles
if test -f ~/.fish_profile
    source ~/.fish_profile
end

# Add custom bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add depot_tools to PATH if available
if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end

# Starship prompt setup (only if Starship is installed)
if type -q starship
    starship init fish | source
end

# Advanced command-not-found hook (only if the file exists)
if test -f /usr/share/doc/find-the-command/ftc.fish
    source /usr/share/doc/find-the-command/ftc.fish
end

# History command with time format
function history
    builtin history --show-time='%F %T '
end

# Create backup for a file
function backup --argument filename
    cp $filename $filename.bak
end

# Copy command with directory support
function copy
    set count (count $argv)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (string trim --right --chars=/ $argv[1])
        set to $argv[2]
        command cp -r $from $to
    else
        command cp $argv
    end
end

# Cleanup local orphaned packages
function cleanup
    while pacman -Qdtq
        sudo pacman -R (pacman -Qdtq)
    end
end

# Useful and commonly used aliases
alias ls="eza -al --color=always --group-directories-first --icons"   # Preferred listing
alias la="eza -a --color=always --group-directories-first --icons"    # All files and dirs
alias ll="eza -l --color=always --group-directories-first --icons"    # Long format
alias lt="eza -aT --color=always --group-directories-first --icons"   # Tree listing
alias l.="eza -ald --color=always --group-directories-first --icons .*" # Dotfiles only

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias c="clear"

# Enhanced tools
alias cat="bat --style=header --style=snip --style=changes"  # Better `cat` output
alias vim="nvim"                                             # Set vim to nvim

# Package management (Pacman)
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias cleanup="sudo pacman -Rns $(pacman -Qdtq)"             # Clean orphaned packages
alias big="expac -H M \"%m\t%n\" | sort -h | nl"             # Sort packages by size
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist" # Update mirrors

# PostgreSQL management
alias pgstart="sudo systemctl start postgresql"
alias pgenable="sudo systemctl enable postgresql"
alias pgstatus="sudo systemctl status postgresql"
alias pgstop="sudo systemctl stop postgresql"
alias psql="sudo -iu postgres psql"

# Prisma
alias pstudio="npx prisma studio"
alias pgenerate="npx prisma generate"
alias pmigrate="npx prisma migrate dev"

# Git Aliases

# Status and info
alias gs="git status -sb"                      # Short status with branch
alias gl="git log --oneline --graph --all"     # Clean, graph-style log
alias gd="git diff"                            # Show unstaged changes
alias gds="git diff --staged"                  # Show staged changes

# Add and commit
alias gaa="git add --all"                      # Add all changes
alias gcm="git commit -m"                      # Quick commit with message
alias gac="git add --all && git commit -m"     # Add all and commit
alias gca="git commit --amend --no-edit"       # Amend last commit without editing

# Branch and checkout
alias gb="git branch"                          # List branches
alias gcb="git checkout -b"                    # Create and switch to new branch
alias gco="git checkout"                       # Switch branches
alias gbD="git branch -D"                      # Force delete branch

# Push and pull
alias gp="git push"                            # Push to remote
alias gpf="git push --force-with-lease"        # Safe force push
alias gpl="git pull"                           # Pull latest from remote

# Stash
alias gss="git stash save"                     # Stash changes
alias gsl="git stash list"                     # List stashes
alias gsp="git stash pop"                      # Apply and drop top stash
alias gsa="git stash apply"                    # Apply without dropping

# Tags
alias gtag="git tag"                           # List tags
alias gtat="git tag -a"                        # Create annotated tag
alias gtp="git push origin --tags"             # Push all tags to remote

# Cleanup
alias gclean="git clean -fd"                   # Remove untracked files and directories
alias gprune="git remote prune origin"         # Remove stale remote branches

# Git configuration and aliases
alias gconfig="git config --global -e"         # Open global git config
alias galias="git config --global alias"       # View Git aliases

# Quick commands
alias ip="ip -color"
alias hw="hwinfo --short"                                    # Hardware info
alias tarnow="tar -acf"                                      # Archive files
alias untar="tar -zxvf"                                      # Extract archive
alias y="yazi"                                               # Launch yazi
alias wget="wget -c"                                         # Continue downloads

# Help and info
alias helpme="echo 'Use tldr <command> for basic info'"
alias tb="nc termbin.com 9999"                               # Quick terminal sharing
alias pacdiff="sudo -H DIFFPROG=meld pacdiff"                # Config diff helper
alias jctl="journalctl -p 3 -xb"                             # Show recent errors

# Bun setup
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH


# Shadcn UI alias
alias shadcn="bunx --bun shadcn-ui@latest add"
