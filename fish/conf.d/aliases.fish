# ===== FILE AND DIRECTORY MANAGEMENT =====
# 'lsa' should show all files, including those starting with '.'
alias lsa="eza -al --color=always --group-directories-first --icons"
alias ls="eza -al --color=always --group-directories-first --icons"
alias la="eza -a --color=always --group-directories-first --icons"
alias ll="eza -l --color=always --group-directories-first --icons"
alias lt="eza -aT --color=always --group-directories-first --icons"
alias l="eza -ald --color=always --group-directories-first --icons .*"
alias cat="bat --style header --style snip --style changes --style header"
alias tree="tree -I 'node_modules|.next|.git'"
alias sizes='du -h --max-depth=1 . 2>/dev/null | sort -hr'
alias space='df -h'
alias bigfiles='find . -type f -size +100M -exec ls -lh {} \; 2>/dev/null | sort -k5 -hr'
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias rmrf="rm -rf"
alias mkdirp="mkdir -p"

# ===== NAVIGATION =====
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias c="clear"
alias data="cd /mnt/Data/dev-projects"
alias project="cd /mnt/Projects"
alias proj="cd /mnt/Projects"
alias downloads="cd ~/Downloads"
alias desk="cd ~/Desktop"
alias docs="cd ~/Documents"
alias config="cd ~/.config"
alias dotfiles="cd /mnt/Projects/dotfiles"

# ===== YAZI FILE MANAGER =====
alias y="yazi"
alias yp="yazi .."
alias yd="yazi ~/Downloads"
alias ydox="yazi ~/Documents"
alias ydata="yazi /mnt/Data"
alias ypjt="yazi /mnt/Projects"
alias yu="yazi; cd (yazi --cwd)"
alias ycd="yazi; cd (yazi --cwd)"
alias yv="yazi --preview"
alias ye="nvim (yazi --select)"
alias yf="set file (yazi --select | fzf); and test -n \"$file\"; and nvim \"$file\""

# ===== PACKAGE MANAGEMENT (ARCH/GARUDA) =====
alias p="sudo pacman -S"
alias pr="sudo pacman -Rs"
alias pq="pacman -Q | wc -l"
alias pqs="pacman -Qs"
alias pi="pacman -Si"
alias upd="/usr/bin/garuda-update"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias grubup="sudo update-grub"
alias rmpkg="sudo pacman -Rdd"
alias big="expac -H M \"%m\t%n\" | sort -h | nl"
alias gitpkg="pacman -Q | grep -i \"\-git\" | wc -l"
alias pacdiff="sudo -H DIFFPROG=meld pacdiff"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# ===== MIRRORS (ARCH) =====
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"

# ===== DOCKER =====
alias dk="docker"
alias dkc="docker-compose"
alias dkup="docker-compose up -d"
alias dkdown="docker-compose down"
alias dklogs="docker-compose logs -f"
alias dkps="docker ps -a"
alias dkimg="docker images"
alias dkstop="docker stop \$(docker ps -q)"
alias dkrm="docker rm \$(docker ps -aq)"
alias dkprune="docker system prune -f"
alias dockerps="docker ps -a"
alias cleanup-docker="docker system prune -f"

# ===== DATABASE (POSTGRESQL) =====
alias pgstart="sudo systemctl start postgresql"
alias pgstop="sudo systemctl stop postgresql"
alias pgenable="sudo systemctl enable postgresql"
alias pgstatus="sudo systemctl status postgresql"
alias pgup="sudo systemctl start postgresql"
alias pgdown="sudo systemctl stop postgresql"
alias pgrest="sudo systemctl restart postgresql"
alias pgstat="sudo systemctl status postgresql"
alias pglog="sudo journalctl -u postgresql -f"
alias psql="sudo -iu postgres psql"
alias db="sudo -u postgres psql"
alias dburl="postgresql://postgres:0099@localhost:5432/saas"

# ===== PRISMA =====
alias pstudio="npx prisma studio"
alias pgenerate="npx prisma generate"
alias pmigrate="npx prisma migrate dev"
alias pgen="npx prisma generate"
alias pmig="npx prisma migrate dev"
alias pdb="npx prisma db push"
alias preset="npx prisma db push --force-reset"
alias pseed="npx prisma db seed"
alias pformat="npx prisma format"
alias pinit="npx prisma init"

# ===== PNPM =====
alias pn="pnpm"
alias px="pnpm dlx"
alias pd="pnpm run dev"
alias pi="pnpm install"
alias pa="pnpm add"
alias pad="pnpm add -D"
alias pnpm-remove="pnpm remove"
alias ps="pnpm start"
alias pb="pnpm run build"
alias pt="pnpm test"
alias pl="pnpm lint"
alias pf="pnpm format"
alias pc="pnpm clean"
alias pn-update="pnpm update --latest"
alias pndev="pnpm run dev"
alias pnbuild="pnpm run build"
alias outdated="pnpm outdated"
alias npm="pnpm"
alias npx="pnpm dlx"

# ===== NEXT.JS =====
alias nextdev="npm run dev"
alias nextbuild="npm run build"
alias nextlint="npm run lint"
alias ndev="pnpm run dev"
alias nbuild="pnpm run build"
alias nstart="pnpm run start"
alias nlint="pnpm run lint"
alias ntype="pnpm run type-check"
alias nfresh="rm -rf node_modules .next && pnpm install"

# ===== TRPC =====
alias trpc="npx @trpc/cli"
alias trpcgen="npx @trpc/cli generate"

# ===== SHADCN =====
alias shadcn="pnpm dlx shadcn@latest add"
alias shad:base="pnpm dlx shadcn@latest add button input label form card dialog alert-dialog sonner tooltip select tabs accordion switch dropdown-menu textarea table avatar badge progress skeleton popover sheet"

# ===== TAILWIND =====
alias tw="pnpm dlx tailwindcss"
alias twbuild="pnpm dlx tailwindcss -i ./src/input.css -o ./dist/output.css --watch"

# ===== TESTING =====
alias jest="pnpm run test"
alias cypress="pnpm run cypress:open"
alias vitest="pnpm run test:ui"

# ===== SYSTEM UTILITIES =====
alias hw="hwinfo --short"
alias ip="ip -color"
alias jctl="journalctl -p 3 -xb"
alias psmem="ps auxf | sort -nr -k 4"
alias psmem10="ps auxf | sort -nr -k 4 | head -10"
alias ports="ss -tuln"
alias myip="curl -s ifconfig.me"
alias pingg="ping google.com"
alias netstat="ss -tuln"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias mem="free -h"
alias cpu="lscpu"
alias temp="sensors"
alias disk="lsblk"
alias procs="ps aux | head -20"
alias dfh="df -h"
alias reboot="sudo systemctl reboot"
alias poweroff="sudo systemctl poweroff"
alias top="htop"
alias weather="curl wttr.in"

# ===== PROCESS MANAGEMENT =====
alias kill3000="kill -9 \$(lsof -t -i:3000 2>/dev/null)"
alias kill5000="kill -9 \$(lsof -t -i:5000 2>/dev/null)"
alias kill8000="kill -9 \$(lsof -t -i:8000 2>/dev/null)"

# ===== TEXT PROCESSING =====
alias grep="ugrep --color=auto"
alias egrep="ugrep -E --color=auto"
alias fgrep="ugrep -F --color=auto"
alias json="python -m json.tool"
alias urlencode="python -c \"import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))\""

# ===== DEVELOPMENT =====
alias vim="nvim"
alias serve="python -m http.server 8000"
alias nr="npm run"
alias python="python3"
alias ping="ping -c 5"

# ===== MISCELLANEOUS =====
alias wget="wget -c"
alias tb="nc termbin.com 9999"
alias please="sudo"
alias apt="man pacman"
alias apt-get="man pacman"
alias helpme="echo 'To print basic information about a command use tldr <command>'"

# ===== ENVIRONMENT =====
alias env="printenv | sort"
alias path="echo \$PATH | tr \":\" \"\\n\""
alias reload-env="source ~/.config/fish/config.fish"

# ===== QUICK EDITS =====
alias fishconfig="nvim ~/.config/fish/config.fish"
alias hosts="sudo nvim /etc/hosts"
alias bashrc="nvim ~/.bashrc"

# ===== CURSOR AI EDITOR =====
alias cursor-cache-remove="rm -rf ~/.config/Cursor ~/.cache/Cursor"
alias regen-cursor="rm -rf ~/.config/Cursor ~/.cache/Cursor; sudo rm /etc/machine-id; and sudo systemd-machine-id-setup"
alias regen-cursor-minimal="sudo rm -f /etc/machine-id /var/lib/dbus/machine-id; sudo systemd-machine-id-setup; rm -rf ~/.config/Cursor/User/globalStorage"




