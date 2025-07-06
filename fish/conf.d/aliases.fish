## Aliases
# File and Directory Management
alias ls="eza -al --color=always --group-directories-first --icons"
alias la="eza -a --color=always --group-directories-first --icons"
alias ll="eza -l --color=always --group-directories-first --icons"
alias lt="eza -aT --color=always --group-directories-first --icons"
alias l="eza -ald --color=always --group-directories-first --icons .*"
alias cat="bat --style header --style snip --style changes --style header"
alias tree="tree -I 'node_modules|.next|.git'"
alias sizes='du -h --max-depth=1 . 2>/dev/null | sort -hr'
alias space='df -h'

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias c="clear"
alias data="cd /mnt/Data/dev-projects"
alias project="cd /mnt/Projects"
alias downloads="cd ~/Downloads"
alias docs="cd ~/Documents"
alias config="cd ~/.config"

# Git Enhanced
alias gs="git status -s"
alias gaa="git add ."
alias gac="git add . && git commit -m"
alias gl="git log --oneline --graph --decorate --all"
alias gb="git branch"
alias gco="git checkout"
alias gd="git diff"
alias gp="git push"
alias gpl="git pull --rebase"
alias gst="git stash"
alias gsp="git stash pop"

# Docker
alias dk="docker"
alias dkc="docker-compose"
alias dkup="docker-compose up -d"
alias dkdown="docker-compose down"
alias dklogs="docker-compose logs -f"
alias dkps="docker ps -a"
alias dkimg="docker images"

# Database (PostgreSQL)
alias pgup="sudo systemctl start postgresql"
alias pgdown="sudo systemctl stop postgresql"
alias pgrest="sudo systemctl restart postgresql"
alias pgstat="sudo systemctl status postgresql"
alias db="sudo -u postgres psql"
alias pgls='sudo -u postgres psql -c "\l"'
alias pgcreate="sudo -u postgres createdb"
alias pgdrop="sudo -u postgres dropdb"

# Prisma
alias pstudio="npx prisma studio"
alias pgen="npx prisma generate"
alias pmig="npx prisma migrate dev"
alias pdb="npx prisma db push"
alias preset="npx prisma db push --force-reset"

# pnpm Enhanced
alias pn="pnpm"
alias pi="pnpm install"
alias pa="pnpm add"
alias pad="pnpm add -D"
alias pd="pnpm run dev"
alias pb="pnpm run build"
alias pt="pnpm test"
alias pl="pnpm lint"
alias px="pnpm dlx"

# Next.js
alias ndev="pnpm run dev"
alias nbuild="pnpm run build"
alias nstart="pnpm run start"
alias nlint="pnpm run lint"

# System Utilities
alias ports="ss -tuln"
alias myip="curl -s ifconfig.me"
alias mem="free -h"
alias procs="ps aux | head -20"
alias kill3000="kill -9 \$(lsof -t -i:3000 2>/dev/null)"
alias kill5000="kill -9 \$(lsof -t -i:5000 2>/dev/null)"
alias kill8000="kill -9 \$(lsof -t -i:8000 2>/dev/null)"

# Development
alias serve="python -m http.server 8000"
alias json="python -m json.tool"
alias vim="nvim"
alias please="sudo"

# Package Management
alias upd="/usr/bin/garuda-update"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias cleanup-docker="docker system prune -f"

# Quick Edits
alias fishconfig="nvim ~/.config/fish/config.fish"
alias hosts="sudo nvim /etc/hosts"

# Shadcn
alias shadcn="pnpm dlx shadcn@latest add"