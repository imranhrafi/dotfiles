# Note: This script assumes you are using the Fish shell due to the 'abbr' command.
# If you are using Bash/Zsh, 'abbr' won't work directly. You'd need to define a function
# or use 'alias' consistently.

# Clear existing aliases if needed (Fish abbr are persistent by default)
# This part is tricky in Fish as abbr are saved. You might need to manage them differently
# or clear them manually if reloading this script causes duplicates.
# For now, we'll just define them. Ensure no duplicates exist in your `fish_config` or `~/.config/fish/fish_variables`.

# Helper to remove existing abbreviations if they exist (optional, use with caution)
# functions --erase abbr_remove_helper
# function abbr_remove_helper
#     set -l abbr_name $argv[1]
#     set -l abbr_list (abbr)
#     if string match -q "*$abbr_name *" $abbr_list
#         abbr -e $abbr_name
#     end
# end

# ===== FILE AND DIRECTORY MANAGEMENT =====
# 'lsa' should show all files, including those starting with '.'
abbr -a lsa "eza -al --color=always --group-directories-first --icons"
abbr -a ls "eza -al --color=always --group-directories-first --icons"
abbr -a la "eza -a --color=always --group-directories-first --icons"
abbr -a ll "eza -l --color=always --group-directories-first --icons"
abbr -a lt "eza -aT --color=always --group-directories-first --icons"
abbr -a l "eza -ald --color=always --group-directories-first --icons .*"
abbr -a cat "bat --style header --style snip --style changes --style header"
abbr -a tree "tree -I 'node_modules|.next|.git'"
abbr -a sizes 'du -h --max-depth=1 . 2>/dev/null | sort -hr'
abbr -a space 'df -h'
abbr -a bigfiles 'find . -type f -size +100M -exec ls -lh {} \; 2>/dev/null | sort -k5 -hr'
abbr -a dir "dir --color=auto"
abbr -a vdir "vdir --color=auto"
abbr -a rmrf "rm -rf"
abbr -a mkdirp "mkdir -p"

# ===== NAVIGATION =====
abbr -a .. "cd .."
abbr -a ... "cd ../.."
abbr -a .... "cd ../../.."
abbr -a ..... "cd ../../../.."
abbr -a ...... "cd ../../../../.."
abbr -a c "clear"
abbr -a data "cd /mnt/Data/dev-projects"
abbr -a project "cd /mnt/Projects"
abbr -a proj "cd /mnt/Projects"
abbr -a downloads "cd ~/Downloads"
abbr -a desk "cd ~/Desktop"
abbr -a docs "cd ~/Documents"
abbr -a config "cd ~/.config"
abbr -a dotfiles "cd /mnt/Projects/dotfiles"

# ===== YAZI FILE MANAGER =====
abbr -a y "yazi"
abbr -a yp "yazi .."
abbr -a yd "yazi ~/Downloads"
abbr -a ydox "yazi ~/Documents"
abbr -a ydata "yazi /mnt/Data"
abbr -a ypjt "yazi /mnt/Projects"
# Note: The following Yazi aliases use command substitution which might not work directly in `abbr`.
# They are kept as aliases for Fish to handle correctly.
alias yu "yazi; cd (yazi --cwd-file=- | tail -1)"
alias ycd "yazi; cd (yazi --cwd-file=- | tail -1)"
abbr -a yv "yazi --preview"
# Note: The following Yazi aliases use command substitution which might not work directly in `abbr`.
# They are kept as aliases for Fish to handle correctly.
alias ye "nvim (yazi --selected-file=- | head -1)"
alias yf 'set file (yazi --selected-file=- | head -1); and test -n "$file"; and nvim "$file"'

# ===== PACKAGE MANAGEMENT (ARCH/GARUDA) =====
abbr -a p "sudo pacman -S"
abbr -a pr "sudo pacman -Rs"
abbr -a pq "pacman -Q | wc -l"
abbr -a pqs "pacman -Qs"
abbr -a pi "pacman -Si"
abbr -a upd "/usr/bin/garuda-update"
abbr -a fixpacman "sudo rm /var/lib/pacman/db.lck"
abbr -a grubup "sudo update-grub"
abbr -a rmpkg "sudo pacman -Rdd"
abbr -a big "expac -H M \"%m\t%n\" | sort -h | nl"
abbr -a gitpkg "pacman -Q | grep -i \"\-git\" | wc -l"
abbr -a pacdiff "sudo -H DIFFPROG=meld pacdiff"
abbr -a rip "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# ===== MIRRORS (ARCH) =====
abbr -a mirror "sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
abbr -a mirrora "sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
abbr -a mirrord "sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
abbr -a mirrors "sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"

# ===== DOCKER =====
abbr -a dk "docker"
abbr -a dkc "docker-compose"
abbr -a dkup "docker-compose up -d"
abbr -a dkdown "docker-compose down"
abbr -a dklogs "docker-compose logs -f"
abbr -a dkps "docker ps -a"
abbr -a dkimg "docker images"
abbr -a dkstop "docker stop (docker ps -q)"
abbr -a dkrm "docker rm (docker ps -aq)"
abbr -a dkprune "docker system prune -f"
abbr -a dockerps "docker ps -a"
abbr -a cleanup-docker "docker system prune -f"

# ===== DATABASE (POSTGRESQL) =====
abbr -a pgstart "sudo systemctl start postgresql"
abbr -a pgstop "sudo systemctl stop postgresql"
abbr -a pgstat "sudo systemctl status postgresql"
abbr -a pgrest "sudo systemctl restart postgresql"
abbr -a pgenable "sudo systemctl enable postgresql"
abbr -a pglog "sudo journalctl -u postgresql -f"
abbr -a psql "sudo -iu postgres psql"
abbr -a pg "sudo -u postgres psql"
abbr -a pgl "sudo -iu postgres psql -l"
abbr -a pgcreate "sudo -u postgres createdb"
abbr -a pgdrop "sudo -u postgres dropdb"
abbr -a pgreset "sudo -u postgres dropdb && sudo -u postgres createdb"
abbr -a dburl "postgresql://postgres:0099@localhost:5432/saas"

# ===== PRISMA =====
abbr -a pstudio "npx prisma studio"
abbr -a pgenerate "npx prisma generate"
abbr -a pmigrate "npx prisma migrate dev"
abbr -a pgen "npx prisma generate"
abbr -a pmig "npx prisma migrate dev"
abbr -a pdb "npx prisma db push"
abbr -a preset "npx prisma db push --force-reset"
abbr -a pseed "npx prisma db seed"
abbr -a pformat "npx prisma format"
abbr -a pinit "npx prisma init"

# ===== PNPM =====
abbr -a pn "pnpm"
abbr -a px "pnpm dlx"
abbr -a pd "pnpm run dev"
abbr -a pi "pnpm install" # Note: 'pi' conflicts with 'pacman -Si'. Consider renaming one.
abbr -a pa "pnpm add"
abbr -a pad "pnpm add -D"
abbr -a pnpm-remove "pnpm remove"
abbr -a ps "pnpm start"
abbr -a pb "pnpm run build"
abbr -a pt "pnpm test"
abbr -a pl "pnpm lint"
abbr -a pf "pnpm format"
abbr -a pc "pnpm clean"
abbr -a pn-update "pnpm update --latest"
abbr -a pndev "pnpm run dev"
abbr -a pnbuild "pnpm run build"
abbr -a outdated "pnpm outdated"
abbr -a npm "pnpm"
abbr -a npx "pnpm dlx"

# ===== NEXT.JS =====
abbr -a nextdev "npm run dev"
abbr -a nextbuild "npm run build"
abbr -a nextlint "npm run lint"
abbr -a ndev "pnpm run dev"
abbr -a nbuild "pnpm run build"
abbr -a nstart "pnpm run start"
abbr -a nlint "pnpm run lint"
abbr -a ntype "pnpm run type-check"
abbr -a nfresh "rm -rf node_modules .next && pnpm install"

# ===== TRPC =====
abbr -a trpc "npx @trpc/cli"
abbr -a trpcgen "npx @trpc/cli generate"

# ===== SHADCN =====
abbr -a shadcn "pnpm dlx shadcn@latest add"
abbr -a shad:base "pnpm dlx shadcn@latest add button input label form card dialog alert-dialog sonner tooltip select tabs accordion switch dropdown-menu textarea table avatar badge progress skeleton popover sheet"

# ===== TAILWIND =====
abbr -a tw "pnpm dlx tailwindcss"
abbr -a twbuild "pnpm dlx tailwindcss -i ./src/input.css -o ./dist/output.css --watch"

# ===== TESTING =====
abbr -a jest "pnpm run test"
abbr -a cypress "pnpm run cypress:open"
abbr -a vitest "pnpm run test:ui"

# ===== SYSTEM UTILITIES =====
abbr -a hw "hwinfo --short"
abbr -a ip "ip -color"
abbr -a jctl "journalctl -p 3 -xb"
abbr -a psmem "ps auxf | sort -nr -k 4"
abbr -a psmem10 "ps auxf | sort -nr -k 4 | head -10"
abbr -a ports "ss -tuln"
abbr -a myip "curl -s ifconfig.me"
abbr -a pingg "ping google.com"
abbr -a netstat "ss -tuln"
abbr -a speedtest "curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
abbr -a mem "free -h"
abbr -a cpu "lscpu"
abbr -a temp "sensors"
abbr -a disk "lsblk"
abbr -a procs "ps aux | head -20"
abbr -a dfh "df -h"
abbr -a reboot "sudo systemctl reboot"
abbr -a poweroff "sudo systemctl poweroff"
abbr -a top "htop"
abbr -a weather "curl wttr.in"

# ===== PROCESS MANAGEMENT =====
# Note: Command substitution in `abbr` can be tricky. Using Fish `alias` is safer here.
abbr -a kill3000 "kill -9 (lsof -ti:3000 2>/dev/null)"
abbr -a kill5000 "kill -9 (lsof -ti:5000 2>/dev/null)"
abbr -a kill8000 "kill -9 (lsof -ti:8000 2>/dev/null)"

# ===== TEXT PROCESSING =====
abbr -a grep "ugrep --color=auto"
abbr -a egrep "ugrep -E --color=auto"
abbr -a fgrep "ugrep -F --color=auto"
abbr -a json "python -m json.tool"
abbr -a urlencode "python -c \"import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))\""

# ===== DEVELOPMENT =====
abbr -a vim "nvim"
abbr -a serve "python -m http.server 8000"
abbr -a nr "npm run"
abbr -a python "python3"
abbr -a ping "ping -c 5"

# ===== MISCELLANEOUS =====
abbr -a wget "wget -c"
abbr -a tb "nc termbin.com 9999"
abbr -a please "sudo"
abbr -a apt "man pacman"
abbr -a apt-get "man pacman"
abbr -a helpme "echo 'To print basic information about a command use tldr <command>'"

# ===== ENVIRONMENT =====
abbr -a env "printenv | sort"
abbr -a path "echo \$PATH | tr \":\" \"\\n\""
abbr -a reload-env "source ~/.config/fish/config.fish"

# ===== QUICK EDITS =====
abbr -a fishconfig "nvim ~/.config/fish/config.fish"
abbr -a hosts "sudo nvim /etc/hosts"
abbr -a bashrc "nvim ~/.bashrc"

# ===== CURSOR AI EDITOR =====
abbr -a cursor-cache-remove "rm -rf ~/.config/Cursor ~/.cache/Cursor"
# Note: The following aliases use `and` which is Fish-specific syntax.
# They might not work perfectly within `abbr`. Using `alias` is recommended.
alias regen-cursor "rm -rf ~/.config/Cursor ~/.cache/Cursor; sudo rm /etc/machine-id; and sudo systemd-machine-id-setup"
alias regen-cursor-minimal "sudo rm -f /etc/machine-id /var/lib/dbus/machine-id; sudo systemd-machine-id-setup; rm -rf ~/.config/Cursor/User/globalStorage"


# ===== GIT =====
# (These were already using `abbr -a`)
abbr -a gac 'git add . && git commit -m'
abbr -a gacp 'git add . && git commit -m && git push'
abbr -a git-new 'git checkout -b'
abbr -a gcamend 'git commit --amend -m'
abbr -a gll 'git log --graph --oneline --all'