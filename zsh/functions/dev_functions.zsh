# ===== DEVELOPMENT AND SYSTEM UTILITY FUNCTIONS =====

# Function to create convex project
create-convex() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: create-convex <project-name> [shadcn-components...]"
    return 1
  fi

  local project=$1
  shift
  local components=($@)

  echo "🔧 Creating Convex project..."
  npm create convex@latest "$project" -- \
    --use-pnpm \
    --client nextjs-app-router \
    --auth convex

  if [[ $? -ne 0 ]]; then
    echo "❌ Convex project creation failed."
    return 1
  fi

  cd "$project"

  echo "🎨 Initializing shadcn/ui..."
  pnpm dlx shadcn@latest init --yes --base-color neutral
  if [[ $? -ne 0 ]]; then
    echo "❌ shadcn init failed."
    return 1
  fi

  if [[ ${#components[@]} -gt 0 ]]; then
    echo "📦 Adding: ${components[@]}"
    pnpm dlx shadcn@latest add "${components[@]}"
  else
    echo "📦 Adding default components..."
    pnpm dlx shadcn@latest add button input label form card dialog alert-dialog sonner tooltip select tabs accordion switch dropdown-menu textarea table avatar badge progress skeleton popover sheet
  fi

  echo "🔧 Initializing Git repository..."
  git init
  git add .
  git commit -m "Initial commit: Convex + Next.js + shadcn/ui setup"
  git branch -M main

  echo "✅ Project '$project' ready! Starting development server..."
  pnpm dev
}

# Clean all development files
clean-dev() {
  echo "🧹 Cleaning node_modules and .next..."
  if [[ -d node_modules ]]; then
    rm -rf node_modules
    echo "✅ Removed node_modules"
  fi
  if [[ -d .next ]]; then
    rm -rf .next
    echo "✅ Removed .next"
  fi
  echo "🔄 Reinstalling node_modules with pnpm..."
  pnpm install
  if [[ $? -eq 0 ]]; then
    echo "🚀 Starting development server with pnpm dev..."
    pnpm dev
  else
    echo "❌ pnpm install failed. Not starting dev server."
    return 1
  fi
}

# Enhanced reload function
reload() {
  echo "🔄 Reloading Zsh shell (full session)..."
  exec zsh
}

# Updated history function (more useful)
fish-history() {
  if [[ $# -eq 0 ]]; then
    history | head -50
  else
    history | grep -i "$1"
  fi
}

# Clean function
clean() {
  echo "🧹 Cleaning temporary files..."
  rm -rf ~/.cache/*
  echo "🗑️  Cleaning trash..."
  rm -rf ~/.local/share/Trash/*
  echo "📦 Cleaning package cache..."
  sudo pacman -Sc --noconfirm
  echo "✨ Cleanup complete!"
}

# Smart process killing with fuzzy search
pskill() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: pskill [process_name]"
    return 1
  fi

  local search_term="$1"
  
  # Get matching processes
  local processes=($(ps aux | grep -v grep | grep -i "$search_term"))
  
  if [[ ${#processes[@]} -eq 0 ]]; then
    echo "No matching processes found"
    return 1
  fi
  
  # If only one process matches, kill it directly
  if [[ ${#processes[@]} -eq 1 ]]; then
    local pid=$(echo ${processes[1]} | awk '{print $2}')
    local name=$(echo ${processes[1]} | awk '{print $11}')
    read -r -p "Kill process $name (PID: $pid)? [y/N] " confirm
    if [[ "$confirm" == "y" ]]; then
      kill "$pid"
      echo "Process killed"
    fi
    return
  fi
  
  # Show multiple matches and let user choose
  echo "Multiple matching processes found:"
  for i in $(seq 0 $(( ${#processes[@]} - 1 )) ); do
    local pid=$(echo ${processes[$i]} | awk '{print $2}')
    local name=$(echo ${processes[$i]} | awk '{print $11}')
    echo "$((i+1)): $name (PID: $pid)"
  done
  
  read -r -p "Enter number of process to kill (or 'q' to quit): " choice
  
  if [[ "$choice" == "q" ]]; then
    return
  fi
  
  if [[ "$choice" -gt 0 && "$choice" -le ${#processes[@]} ]]; then
    local pid=$(echo ${processes[$((choice-1))]} | awk '{print $2}')
    local name=$(echo ${processes[$((choice-1))]} | awk '{print $11}')
    read -r -p "Kill process $name (PID: $pid)? [y/N] " confirm
    if [[ "$confirm" == "y" ]]; then
      kill "$pid"
      echo "Process killed"
    fi
  else
    echo "Invalid choice"
    return 1
  fi
}

# Update function
update() {
  echo "🔄 Updating system packages..."
  sudo pacman -Syu --noconfirm
  echo "📦 Updating AUR packages..."
  yay -Syu --noconfirm
  echo "🧹 Cleaning package cache..."
  sudo pacman -Sc --noconfirm
  yay -Sc --noconfirm
  echo "✨ System update complete!"
}