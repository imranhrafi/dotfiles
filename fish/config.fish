## Set values
# Hide welcome message & ensure we are reporting fish as shell
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT 1
set -xU MANPAGER "sh -c 'col -bx | bat -l man -p'"  # Use bat for man pages
set -xU MANROFFOPT -c
set -x SHELL /usr/bin/fish  # Set Fish as default shell

## Export variable needed for qt-theme
if type qtile >/dev/null 2>&1
    set -x QT_QPA_PLATFORMTHEME qt5ct  # Qt theme for qtile
end

## Settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000  # Notify after 10s
set -U __done_notification_urgency_level low  # Low urgency notifications

## Environment setup
# Apply .profile: use this for fish-compatible .profile content
if test -f ~/.fish_profile
    source ~/.fish_profile
end

# Add ~/.local/bin and depot_tools to PATH using fish_add_path for simplicity
fish_add_path -g ~/.local/bin ~/Applications/depot_tools

## Starship prompt
if type starship >/dev/null 2>&1; and status --is-interactive
    source (starship init fish --print-full-init | psub)  # Initialize Starship prompt
end

## Advanced command-not-found hook
source /usr/share/doc/find-the-command/ftc.fish

## Functions
# History navigation (! for last command, $ for last argument)
function __history_previous_command
    # Usage: Type ! and press Enter to insert the last command
    # Example: If last command was "ls -l", typing ! inserts "ls -l"
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    # Usage: Type $ and press Enter to cycle through last command's arguments
    # Example: If last command was "cp file.txt /dir", $ inserts "file.txt" or "/dir"
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

function history --argument search
    # Usage: 'history' to list all commands with timestamps, or 'history <term>' to filter
    # Example: 'history git' shows all git commands with timestamps
    if test -n "$search"
        builtin history --show-time='%F %T ' | grep $search
    else
        builtin history --show-time='%F %T '
    end
end

function backup --argument filename
    # Usage: 'backup myfile.txt' to create myfile.txt.bak
    # Example: 'backup config.fish' makes a backup as config.fish.bak
    if test -e "$filename"
        cp $filename $filename.bak
    else
        echo "File '$filename' does not exist."
    end
end

function copy
    # Usage: 'copy src dest' to copy files or directories
    # Example: 'copy dir1 dir2' copies dir1 into dir2; 'copy file.txt file2.txt' copies a file
    set count (count $argv)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (string trim --right --chars=/ $argv[1])
        set to $argv[2]
        command cp -r $from $to
    else if test "$count" -gt 0
        command cp $argv
    else
        echo "Usage: copy <source> <dest>"
    end
end

function cleanup
    # Usage: 'cleanup' to remove orphaned packages (Arch-specific)
    # Example: Run 'cleanup' after uninstalling software to tidy up dependencies
    while pacman -Qdtq
        sudo pacman -R (pacman -Qdtq)
    end
end

function reload
    # Usage: 'reload' to restart Fish and apply config changes
    # Example: Edit config.fish, then 'reload' to use the new settings
    exec fish
end

## Root prompt customization
if test (id -u) -eq 0
    set -x fish_color_cwd red  # Red cwd in prompt when root
end

## Dynamic package manager aliases
if type pacman >/dev/null 2>&1
    alias p="sudo pacman -S"   # Install package on Arch
    alias pr="sudo pacman -Rs" # Remove package on Arch
else if type apt >/dev/null 2>&1
    alias p="sudo apt install" # Install package on Debian/Ubuntu
    alias pr="sudo apt remove" # Remove package on Debian/Ubuntu
end
# Useful aliases

## File and Directory Management
alias ls="eza -al --color=always --group-directories-first --icons"  # Preferred listing
alias la="eza -a --color=always --group-directories-first --icons"   # All files and dirs
alias ll="eza -l --color=always --group-directories-first --icons"   # Long format
alias lt="eza -aT --color=always --group-directories-first --icons"  # Tree listing
alias l="eza -ald --color=always --group-directories-first --icons .*" # Show only dotfiles
alias cat="bat --style header --style snip --style changes --style header"  # Better cat
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias data="cd /mnt/Data/dev-projects"             # Quick access to data partition
alias project="cd /mnt/Projects"             # Quick access to data partition
alias tree="tree -I 'node_modules|.next'"  # Tree with exclusions
alias y="yazi"  # File explorer
alias yp="yazi .."  # Open parent directory
alias yd="yazi ~/Downloads"  # Quick access to Downloads
alias ydox="yazi ~/Documents"  # Quick access to Documents
alias yd="yazi /mnt/Data"  # Quick access to DATA
alias ypjt="yazi /mnt/Projects"  # Quick access to Projects
alias yu="yazi; cd (yazi --cwd)"  # Open Yazi and go up one level on exit
alias ycd="yazi; cd (yazi --cwd)"  # Open Yazi and change to last visited dir on exit
alias yv="yazi --preview"  # Preview a file
alias ye="nvim (yazi --select)"  # Edit last selected file in Neovim
alias yf="set file (yazi --select | fzf); and test -n \"$file\"; and nvim \"$file\""  # Find and open files with fzf


## Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias c="clear"

## Package Management (Arch/Garuda)
alias p="sudo pacman -S"              # Install package
alias pr="sudo pacman -Rs"            # Remove package
alias upd="/usr/bin/garuda-update"    # System update
alias fixpacman="sudo rm /var/lib/pacman/db.lck"  # Fix pacman lock
alias grubup="sudo update-grub"       # Update GRUB
alias rmpkg="sudo pacman -Rdd"        # Remove package without deps
alias big="expac -H M \"%m\t%n\" | sort -h | nl"  # Sort packages by size
alias gitpkg="pacman -Q | grep -i \"\-git\" | wc -l"  # Count -git packages
alias pacdiff="sudo -H DIFFPROG=meld pacdiff"  # Config diff tool
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"  # Recent packages
if not test -x /usr/bin/yay; and test -x /usr/bin/paru
    alias yay="paru"                  # Fallback to paru if yay absent
end

## Mirrors (Arch)
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"

## Git
alias gaa="git add ."                 # Add all
alias gac='git add . && git commit -m'  # Add all and commit
alias gp="git push"                   # Push changes
alias gcm='git commit -m'             # Commit with message

## Database (PostgreSQL)
alias pgstart='sudo systemctl start postgresql'   # Start PostgreSQL
alias pgenable='sudo systemctl enable postgresql' # Enable on boot
alias pgstatus='sudo systemctl status postgresql' # Check status
alias pgstop='sudo systemctl stop postgresql'     # Stop PostgreSQL
alias psql='sudo -iu postgres psql'               # Access psql as postgres user
alias dburl='postgresql://postgres:0099@localhost:5432/saas'  # Database URL

## Prisma
alias pstudio='npx prisma studio'     # Launch Prisma Studio
alias pgenerate='npx prisma generate' # Generate Prisma client
alias pmigrate='npx prisma migrate dev'  # Run migrations

## Shadcn
alias shadcn="bunx --bun shadcn@latest add"  # Add Shadcn components

## System Utilities
alias hw="hwinfo --short"             # Hardware info
alias ip="ip -color"                  # Colored ip output
alias jctl="journalctl -p 3 -xb"      # Error logs
alias psmem="ps auxf | sort -nr -k 4" # Process memory usage
alias psmem10="ps auxf | sort -nr -k 4 | head -10"  # Top 10 memory hogs

## Text Processing
alias grep="ugrep --color=auto"       # Better grep
alias egrep="ugrep -E --color=auto"   # Extended grep
alias fgrep="ugrep -F --color=auto"   # Fixed-string grep

## Miscellaneous
alias vim="nvim"                      # Use Neovim
alias wget="wget -c"                  # Resume downloads
alias tb="nc termbin.com 9999"        # Pipe to termbin
alias please="sudo"                   # Polite sudo
alias apt="man pacman"                # Help for apt users
alias apt-get="man pacman"            # Help for apt-get users
alias helpme="echo 'To print basic information about a command use tldr <command>'"


## File and Directory Management
alias rmrf="rm -rf"                   # Force recursive delete (use with caution)
alias duh="du -h --max-depth=1 | sort -hr"  # Human-readable dir sizes
alias mkdirp="mkdir -p"               # Create parent dirs as needed

## Package Management
alias pq="pacman -Q | wc -l"          # Count installed packages
alias pqs="pacman -Qs"                # Search installed packages
alias pi="pacman -Si"                 # Package info

## Git
alias gs="git status"                 # Quick status check
alias gl="git log --oneline --graph --decorate"  # Pretty log
alias gb="git branch"                 # List branches
alias gco="git checkout"              # Switch branches
alias gd="git diff"                   # Show changes

## System Utilities
alias reboot="sudo systemctl reboot"  # Reboot system
alias poweroff="sudo systemctl poweroff"  # Shut down
alias top="htop"                      # Better top (if htop installed)
alias dfh="df -h"                     # Disk usage in human-readable form

## Development
alias nr="npm run"                    # Shortcut for npm scripts
alias dockerps="docker ps -a"         # List all Docker containers
alias python="python3"                # Default to Python 3

## Network
alias pingg="ping google.com"         # Quick ping test
alias myip="curl ifconfig.me"         # Get public IP
alias ports="ss -tuln"                # List open ports

# Cursor Ai Editor
alias cursor-cache-remove="rm -rf ~/.config/Cursor ~/.cache/Cursor"  # Clear Cursor AI cache
alias regen-cursor='rm -rf ~/.config/Cursor ~/.cache/Cursor; sudo rm /etc/machine-id; and sudo systemd-machine-id-setup'

#pnpm
alias pn='pnpm'
alias px='pnpm dlx'
alias pd='pnpm run dev'
alias pn-update='pnpm update --latest'  # Update all packages to latest version
alias pndev='pnpm run dev'  # Run development server
alias pnbuild='pnpm run build'  # Build project
alias shadcn='pnpm dlx shadcn@latest add '
alias npm='pnpm'  # Use bun as npm
alias npx='pnpm dlx'



#bun
alias bunshadcn='pnpm dlx shadcn@latest add'  # Add Shadcn components




# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Next.js aliases
alias nextdev="npm run dev"
alias nextbuild="npm run build"
alias nextlint="npm run lint"