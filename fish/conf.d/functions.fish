## Custom Functions
# Create a new Next.js project quickly
function create-next
    if test (count $argv) -eq 0
        echo "Usage: create-next <project-name>"
        return 1
    end
    npx create-next-app@latest $argv[1] --typescript --tailwind --eslint --app --src-dir --import-alias "@/*"
    cd $argv[1]
    echo "✅ Next.js project '$argv[1]' created successfully!"
end

# Quick project setup with common packages
function setup-project
    if test (count $argv) -eq 0
        echo "Usage: setup-project <type> where type is: next, react, node, or express"
        return 1
    end
    switch $argv[1]
        case next
            pnpm add @prisma/client prisma @trpc/server @trpc/client @trpc/react-query @tanstack/react-query zod
            pnpm add -D @types/node
            echo "✅ Next.js packages installed!"
        case react
            pnpm add @tanstack/react-query axios zod
            pnpm add -D @types/node
            echo "✅ React packages installed!"
        case node
            pnpm add express cors helmet dotenv
            pnpm add -D @types/node @types/express nodemon
            echo "✅ Node.js packages installed!"
        case '*'
            echo "❌ Unknown project type. Use: next, react, node, or express"
    end
end

function create-convex
    if test (count $argv) -eq 0
        echo "Usage: create-convex <project-name> [shadcn-components...]"
        return 1
    end

    set project $argv[1]
    set components (string join " " (string sub -s 2 $argv)) # All args after project name

    echo "🔧 Creating Convex project with Next.js + Convex Auth..."

    # Create project with Convex, Next.js, and Convex Auth (auto confirm prompts)
    npm create convex@latest $project -- \
        --use-pnpm \
        --client nextjs-app-router \
        --auth convex

    if test $status -ne 0
        echo "❌ Convex project creation failed."
        return 1
    end

    cd $project

    echo "🎨 Setting up shadcn/ui..."

    # Install shadcn/ui and prefill init config
    pnpm dlx shadcn-ui@latest init --yes --style new-york --tailwind-config tailwind.config.ts --tsconfig tsconfig.json --components-json components.json --base-color neutral

    # Add components (user-defined or default)
    if test -n "$components"
        pnpm dlx shadcn-ui@latest add $components
    else
        pnpm dlx shadcn-ui@latest add button card input label textarea sheet
    end

    echo "✅ Convex + Next.js project '$project' created and shadcn/ui components added!"
    echo "👉 cd $project && pnpm run dev"
end


# Kill process on specific port
function killport
    if test (count $argv) -eq 0
        echo "Usage: killport <port-number>"
        return 1
    end
    set pid (lsof -t -i:$argv[1] 2>/dev/null)
    if test -n "$pid"
        kill -9 $pid
        echo "✅ Killed process on port $argv[1]"
    else
        echo "❌ No process found on port $argv[1]"
    end
end

# Check what's running on a port
function checkport
    if test (count $argv) -eq 0
        echo "Usage: checkport <port-number>"
        return 1
    end
    lsof -i :$argv[1]
end

# Git commit with automatic message generation
function gcommit
    if test (count $argv) -eq 0
        set files_changed (git diff --cached --name-only | wc -l)
        if test $files_changed -eq 0
            echo "❌ No staged changes to commit"
            return 1
        end
        git add .
        set msg "Update $files_changed files"
        git commit -m "$msg"
        echo "✅ Committed with message: $msg"
    else
        git add .
        git commit -m "$argv"
        echo "✅ Committed with message: $argv"
    end
end

# Quick push to current branch
function gpush
    set current_branch (git branch --show-current)
    git push origin $current_branch
    echo "✅ Pushed to $current_branch"
end

# Create and switch to new git branch
function gbranch
    if test (count $argv) -eq 0
        echo "Usage: gbranch <branch-name>"
        return 1
    end
    git checkout -b $argv[1]
    echo "✅ Created and switched to branch: $argv[1]"
end

# Docker cleanup function
function docker-cleanup
    echo "🧹 Cleaning up Docker..."
    docker system prune -f
    docker volume prune -f
    docker image prune -f
    echo "✅ Docker cleanup completed!"
end

# Start a development environment
function devstart
    if test (count $argv) -eq 0
        echo "Usage: devstart <type> where type is: full, db, or app"
        return 1
    end
    switch $argv[1]
        case full
            echo "🚀 Starting full development environment..."
            docker-compose up -d
            sleep 3
            pnpm run dev
        case db
            echo "🗄️  Starting database only..."
            docker-compose up -d postgres
            pgstart
        case app
            echo "⚡ Starting app only..."
            pnpm run dev
        case '*'
            echo "❌ Unknown type. Use: full, db, or app"
    end
end

# Environment variables helper
function env-check
    if test (count $argv) -eq 0
        echo "📋 Current environment variables:"
        printenv | grep -E "(NODE_ENV|DATABASE_URL|NEXTAUTH|API)" | sort
    else
        echo "🔍 Searching for: $argv[1]"
        printenv | grep -i $argv[1]
    end
end

# Package.json scripts helper
function scripts
    if test -f package.json
        echo "📦 Available scripts:"
        cat package.json | jq -r '.scripts | to_entries[] | "  \(.key) -> \(.value)"' 2>/dev/null || echo "❌ jq not installed or invalid package.json"
    else
        echo "❌ No package.json found"
    end
end

# Project structure generator
function tree-project
    if command -v tree >/dev/null
        tree -I 'node_modules|.next|.git|dist|build' -a -L 3
    else
        find . -type d -name "node_modules" -prune -o -type d -name ".next" -prune -o -type d -name ".git" -prune -o -type f -print | head -20
    end
end

# Backup current project
function backup-project
    set project_name (basename $PWD)
    set backup_name "{$project_name}_backup_(date +%Y%m%d_%H%M%S)"
    cd ..
    cp -r $project_name $backup_name
    echo "✅ Project backed up as: $backup_name"
    cd $project_name
end

# Clean all development files
function clean-dev
    echo "🧹 Cleaning development files..."
    if test -d node_modules
        rm -rf node_modules
        echo "✅ Removed node_modules"
    end
    for dir in .next dist build out
        if test -d $dir
            rm -rf $dir
            echo "✅ Removed $dir"
        end
    end
    for file in package-lock.json yarn.lock pnpm-lock.yaml
        if test -f $file
            rm $file
            echo "✅ Removed $file"
        end
    end
    echo "✅ Development files cleaned!"
end

# Database helpers
function db-reset
    echo "🔄 Resetting database..."
    npx prisma db push --force-reset
    npx prisma db seed
    echo "✅ Database reset and seeded!"
end

function db-studio
    echo "🎨 Opening Prisma Studio..."
    npx prisma studio
end

# Quick server for static files
function serve-static
    set port 8000
    if test (count $argv) -gt 0
        set port $argv[1]
    end
    echo "🌐 Serving current directory on http://localhost:$port"
    python -m http.server $port
end

# Enhanced reload function
function reload
    echo "🔄 Reloading Fish configuration..."
    source ~/.config/fish/config.fish
    echo "✅ Fish configuration reloaded!"
end

# Updated history function (more useful)
function history
    if test (count $argv) -eq 0
        builtin history --show-time='%F %T ' | head -50
    else
        builtin history --show-time='%F %T ' | grep -i $argv[1]
    end
end

# Enhanced backup function
function backup
    if test (count $argv) -eq 0
        echo "Usage: backup <file-or-directory>"
        return 1
    end
    set target $argv[1]
    if not test -e "$target"
        echo "❌ File or directory '$target' does not exist"
        return 1
    end
    set backup_name "{$target}.backup.(date +%Y%m%d_%H%M%S)"
    cp -r "$target" "$backup_name"
    echo "✅ Backup created: $backup_name"
end

# Enhanced copy function
function copy
    if test (count $argv) -lt 2
        echo "Usage: copy <source> <destination>"
        return 1
    end
    set source $argv[1]
    set dest $argv[2]
    if not test -e "$source"
        echo "❌ Source '$source' does not exist"
        return 1
    end
    if test -d "$source"
        cp -r "$source" "$dest"
        echo "✅ Directory copied: $source → $dest"
    else
        cp "$source" "$dest"
        echo "✅ File copied: $source → $dest"
    end
end