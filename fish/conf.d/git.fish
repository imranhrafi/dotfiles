# ================================
# 🎯 GIT FUNCTION POWER PACK v2.0
# ================================

# 📘 Git Help Menu - Complete Cheat Sheet
function gf
    echo ""
    echo "📘 COMPLETE GIT WORKFLOW CHEAT SHEET (PHASE-ORDERED)"
    echo "════════════════════════════════════════════════════"
    echo ""
    echo "🌱 1. START WORKING"
    echo "────────────────────────────────────────────"
    echo "🔹 git-new <name>        → Create & switch to new branch (e.g. git-new feat/auth)"
    echo "🔹 git-switch <branch>   → Move to existing branch (e.g. git-switch main)"
    echo "🔹 git-sync              → Update branch with latest main (do this first!)"
    echo "🔹 git-list              → List all local/remote branches"
    echo "🔹 git-current           → Show current branch name"
    echo ""
    echo "💻 2. ACTIVE DEVELOPMENT"
    echo "────────────────────────────────────────────"
    echo "⚡ Saving Work:"
    echo "  git-save '<msg>'       → Add+commit+push all changes (e.g. git-save 'add login form')"
    echo "  git-commit '<msg>'     → Commit without push (for local saves)"
    echo "  git-push               → Push committed changes"
    echo "  git-amend              → Fix last commit (add files/message)"
    echo ""
    echo "🔍 Review Changes:"
    echo "  gs (git status)        → See changed/untracked files"
    echo "  git-diff               → View line-by-line changes"
    echo "  git-log                → Show commit history graph"
    echo "  git-who                → Show file change authors"
    echo "  git-find '<text>'      → Search commit messages (e.g. git-find 'validation')"
    echo ""
    echo "🔄 Context Switching:"
    echo "  git-stash '<msg>'      → Temporarily shelf changes"
    echo "  git-stash-pop          → Restore stashed work"
    echo "  git-stash-list         → View saved stashes"
    echo ""
    echo "🚨 3. FIXING MISTAKES & CONFLICTS"
    echo "────────────────────────────────────────────"
    echo "🔹 git-undo-commit       → Undo last commit (keep changes)"
    echo "🔹 git-restore           → Discard unstaged changes"
    echo "🔹 git-abort             → Cancel ongoing merge/rebase"
    echo "🔹 git-conflicts         → List conflicted files"
    echo "🔹 git-undo-all          → Reset ALL uncommitted changes"
    echo "‼️  git-reset-hard       → DANGER: Wipe all changes since last commit"
    echo "‼️  git-nuke             → DANGER: Delete current branch (local only)"
    echo ""
    echo "🚀 4. FINALIZE & CLEANUP"
    echo "────────────────────────────────────────────"
    echo "🔹 git-sync              → Rebase onto latest main before PR"
    echo "🔹 git-done              → Merge to main & delete branch (after approval)"
    echo "🔹 git-prune             → Delete all merged branches"
    echo "🔹 git-stash-clear       → Remove all stashed changes"
    echo ""
    echo "🛠️  QUICK ALIASES"
    echo "────────────────────────────────────────────"
    echo "🔸 gs  → git status         🔸 gpl → git pull"
    echo "🔸 ga  → git add .          🔸 gp  → git push"
    echo "🔸 gc  → git commit -m      🔸 gco → git checkout"
    echo "🔸 gl  → git log --oneline  🔸 gb  → git branch"
    echo "🔸 gd  → git diff           🔸 gm  → git merge"
    echo ""
    echo "💡 PRO TIPS"
    echo "────────────────────────────────────────────"
    echo "• Always git-sync before starting work"
    echo "• Use git-save for small atomic changes"
    echo "• git-stash when context switching"
    echo "• git-done merges to main AND deletes branch"
    echo "• git-prune weekly to remove stale branches"
    echo "• git-who to find code owners"
    echo "• git-conflicts after failed merges"
    echo ""
    echo "🆘 Type 'gf' to show this complete workflow guide"
    echo "════════════════════════════════════════════════════"
end

# ================================
# 🔧 HELPER FUNCTIONS
# ================================

# Check if we're in a git repository
function _git_check
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo "❌ Not in a git repository!"
        return 1
    end
    return 0
end

# Check for uncommitted changes
function _git_has_changes
    git diff-index --quiet HEAD --
    return $status
end

# Get current branch name
function _git_current_branch
    git branch --show-current
end

# Check if branch exists
function _git_branch_exists
    git show-ref --verify --quiet refs/heads/$argv[1]
    return $status
end

# ================================
# 🌿 BRANCH MANAGEMENT
# ================================

# Create new feature branch
function git-new
    _git_check; or return 1

    if test (count $argv) -eq 0
        echo "❗ Usage: git-new <branch-name>"
        echo "💡 Example: git-new login-page"
        return 1
    end

    set branch_name "feat/$argv[1]"

    # Check if branch already exists
    if _git_branch_exists $branch_name
        echo "❌ Branch '$branch_name' already exists!"
        echo "💡 Use: git-switch $branch_name"
        return 1
    end

    # Stash changes if any
    if _git_has_changes
        echo "📦 Stashing current changes..."
        git stash push -m "Auto-stash before creating $branch_name"
    end

    git checkout -b $branch_name
    echo "✅ Created and switched to: $branch_name"
end

# Merge current branch to main and cleanup
function git-done
    _git_check; or return 1

    set current_branch (_git_current_branch)

    if test "$current_branch" = "main"
        echo "❌ Already on main branch!"
        return 1
    end

    # Check for uncommitted changes
    if _git_has_changes
        echo "❌ You have uncommitted changes!"
        echo "💡 Commit them first or use git-stash"
        return 1
    end

    echo "🔄 Merging '$current_branch' into main..."

    # Switch to main and pull latest
    git checkout main
    git pull origin main

    # Merge the branch
    git merge $current_branch

    # Push to remote
    git push origin main

    # Delete local branch
    git branch -d $current_branch

    # Delete remote branch if it exists
    if git show-ref --verify --quiet refs/remotes/origin/$current_branch
        git push origin --delete $current_branch
    end

    echo "✅ Successfully merged '$current_branch' into main and cleaned up"
end

# Sync current branch with latest main
function git-sync
    _git_check; or return 1

    set current_branch (_git_current_branch)
    set stashed false

    # Stash changes if any
    if _git_has_changes
        echo "📦 Stashing current changes..."
        git stash push -m "Auto-stash before sync"
        set stashed true
    end

    # Pull latest main
    git checkout main
    git pull origin main
    git checkout $current_branch

    # Restore stashed changes
    if test "$stashed" = "true"
        echo "📦 Restoring stashed changes..."
        git stash pop
    end

    echo "✅ Synced with latest main, back on '$current_branch'"
end

# Switch to existing branch safely
function git-switch
    _git_check; or return 1

    if test (count $argv) -eq 0
        echo "❗ Usage: git-switch <branch-name>"
        echo "💡 Example: git-switch feat/login"
        return 1
    end

    set target_branch $argv[1]

    # Check if branch exists
    if not _git_branch_exists $target_branch
        echo "❌ Branch '$target_branch' doesn't exist!"
        echo "💡 Use: git-new $target_branch"
        return 1
    end

    # Stash changes if any
    if _git_has_changes
        echo "📦 Stashing current changes..."
        git stash push -m "Auto-stash before switching to $target_branch"
    end

    git checkout $target_branch
    echo "✅ Switched to: $target_branch"
end

# Show current branch
function git-current
    _git_check; or return 1
    set current (_git_current_branch)
    echo "🟢 Current branch: $current"
end

# List all branches
function git-list
    _git_check; or return 1
    echo "📂 Local branches:"
    git branch
    echo ""
    echo "🌐 Remote branches:"
    git branch -r
end

# Delete merged branches safely
function git-prune
    _git_check; or return 1

    # Get merged branches, remove leading '*', trim whitespace, exclude main and current branch
    set current_branch (_git_current_branch)
    set merged_branches (
        git branch --merged main | string trim | string replace -r '^\* ' '' | grep -v '^main$' | grep -v "^$current_branch\$"
    )

    if test (count $merged_branches) -eq 0
        echo "✅ No merged branches to delete"
        return 0
    end

    echo "🧹 Deleting merged branches:"
    for branch in $merged_branches
        echo "  - $branch"
        git branch -d $branch
    end

    echo "✅ Cleaned up merged branches"
end

# ================================
# ⚡ QUICK COMMITS
# ================================

# Add all + commit + push in one go
function git-save
    _git_check; or return 1

    if test (count $argv) -eq 0
        echo "❗ Usage: git-save 'your commit message'"
        echo "💡 Example: git-save 'fix header alignment'"
        return 1
    end

    set message $argv[1]

    git add .
    git commit -m "$message"
    git push origin HEAD

    echo "🚀 Saved and pushed: $message"
end

# Add all + commit (no push)
function git-commit
    _git_check; or return 1

    if test (count $argv) -eq 0
        echo "❗ Usage: git-commit 'your commit message'"
        echo "💡 Example: git-commit 'WIP: new feature'"
        return 1
    end

    set message $argv[1]

    git add .
    git commit -m "$message"

    echo "✅ Committed: $message"
end

# Push current branch
function git-push
    _git_check; or return 1

    git push origin HEAD
    echo "🚀 Pushed current branch"
end

# Amend last commit
function git-amend
    _git_check; or return 1

    git add .
    git commit --amend --no-edit

    echo "✅ Amended last commit"
end

# ================================
# 🔄 UNDO OPERATIONS
# ================================

# Undo last commit (keep changes)
function git-undo-commit
    _git_check; or return 1

    git reset --soft HEAD~1
    echo "⏪ Undone last commit (changes kept)"
end

# Hard reset and clean (DANGEROUS)
function git-undo-all
    _git_check; or return 1

    echo "⚠️  This will DELETE all local changes!"
    echo "❓ Are you sure? (y/N)"
    read -l confirm

    if test "$confirm" = "y" -o "$confirm" = "Y"
        git reset --hard HEAD
        git clean -fd
        echo "💥 All local changes wiped"
    else
        echo "❌ Cancelled"
    end
end

# Restore unstaged changes
function git-restore
    _git_check; or return 1

    git restore .
    echo "✅ Restored all unstaged changes"
end

# ================================
# 📦 STASH MANAGEMENT
# ================================

# Stash changes with message
function git-stash
    _git_check; or return 1

    if test (count $argv) -eq 0
        set message "Quick stash"
    else
        set message $argv[1]
    end

    git stash push -m "$message"
    echo "📦 Stashed: $message"
end

# Apply and remove latest stash
function git-stash-pop
    _git_check; or return 1

    if test (git stash list | wc -l) -eq 0
        echo "❌ No stashes found"
        return 1
    end

    git stash pop
    echo "✅ Applied and removed latest stash"
end

# List all stashes
function git-stash-list
    _git_check; or return 1

    if test (git stash list | wc -l) -eq 0
        echo "📦 No stashes found"
        return 0
    end

    echo "📦 Stashes:"
    git stash list
end

# Clear all stashes
function git-stash-clear
    _git_check; or return 1

    if test (git stash list | wc -l) -eq 0
        echo "📦 No stashes to clear"
        return 0
    end

    echo "⚠️  This will DELETE all stashes!"
    echo "❓ Are you sure? (y/N)"
    read -l confirm

    if test "$confirm" = "y" -o "$confirm" = "Y"
        git stash clear
        echo "✅ All stashes cleared"
    else
        echo "❌ Cancelled"
    end
end

# ==== git-nuke → ব্রাঞ্চ মুছে ফেলে =====
function git-nuke
    set current_branch (_git_current_branch)

    if test "$current_branch" = "main"
        echo "❌ Can't delete main branch!"
        return 1
    end

    echo "⚠️  This will DELETE the current branch: $current_branch"
    echo "❓ Are you sure? (y/N)"
    read -l confirm

    if test "$confirm" = "y" -o "$confirm" = "Y"
        git checkout main
        git branch -D $current_branch
        git push origin --delete $current_branch 2>/dev/null
        echo "💥 Nuked branch: $current_branch"
    else
        echo "❌ Cancelled"
    end
end

# ================================
# 🔍 INFORMATION & HISTORY
# ================================

# Pretty commit graph
function git-log
    _git_check; or return 1

    git log --oneline --graph --decorate --all -20
end

# See who committed what
function git-who
    _git_check; or return 1

    git shortlog -sne
end

# Show current changes
function git-diff
    _git_check; or return 1

    git diff
end

# Show conflicted files
function git-conflicts
    _git_check; or return 1

    set conflicts (git diff --name-only --diff-filter=U)

    if test (count $conflicts) -eq 0
        echo "✅ No conflicts found"
        return 0
    end

    echo "⚠️  Conflicted files:"
    for file in $conflicts
        echo "  - $file"
    end
end

# Find commits containing text
function git-find
    _git_check; or return 1

    if test (count $argv) -eq 0
        echo "❗ Usage: git-find 'search text'"
        echo "💡 Example: git-find 'bug fix'"
        return 1
    end

    set search_text $argv[1]

    echo "🔍 Searching for: $search_text"
    git log --oneline --grep="$search_text" --all
end

# ================================
# 🔥 EMERGENCY FIXES
# ================================

# Abort current merge/rebase
function git-abort
    _git_check; or return 1

    if git status | grep -q "rebase in progress"
        git rebase --abort
        echo "✅ Aborted rebase"
    else if git status | grep -q "merge in progress"
        git merge --abort
        echo "✅ Aborted merge"
    else
        echo "❌ No merge or rebase in progress"
    end
end

# Reset to last commit (DANGEROUS)
function git-reset-hard
    _git_check; or return 1

    echo "⚠️  This will DELETE all changes since last commit!"
    echo "❓ Are you sure? (y/N)"
    read -l confirm

    if test "$confirm" = "y" -o "$confirm" = "Y"
        git reset --hard HEAD
        echo "💥 Reset to last commit"
    else
        echo "❌ Cancelled"
    end
end

# ================================
# 🔗 QUICK ALIASES
# ================================

alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push origin HEAD"
alias gpl="git pull origin main"
alias gco="git checkout"
alias gm="git merge"
alias gb="git branch"
alias gd="git diff"
alias gl="git log --oneline"
alias gbd="git branch -d"
