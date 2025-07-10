# ===== YAZI FILE MANAGER FUNCTIONS =====

# Function to change directory to yazi's last opened directory
yu() {
  local yazi_cwd
  yazi_cwd=$(yazi --cwd)
  if [[ -n "$yazi_cwd" ]]; then
    cd "$yazi_cwd"
  fi
}

ycd() {
  local yazi_cwd
  yazi_cwd=$(yazi --cwd)
  if [[ -n "$yazi_cwd" ]]; then
    cd "$yazi_cwd"
  fi
}

unalias yf 2>/dev/null
yf() {
  local file
  file=$(yazi --select | fzf)
  if [[ -n "$file" ]]; then
    nvim "$file"
  fi
}

unalias ye 2>/dev/null
ye() {
  local file
  file=$(yazi --select)
  if [[ -n "$file" ]]; then
    nvim "$file"
  fi
}