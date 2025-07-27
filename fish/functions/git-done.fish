function git-done
    # Check if we're in a git repo
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo "❌ Not in a git repository"
        return 1
    end

    # Get current branch
    set current (git rev-parse --abbrev-ref HEAD)

    # Get the default branch (main, master, or whatever)
    set default_branch (git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | string replace 'refs/remotes/origin/' '')

    # Fallback detection if symbolic-ref doesn't work
    if test -z "$default_branch"
        if git show-ref --verify --quiet refs/remotes/origin/main
            set default_branch "main"
        else if git show-ref --verify --quiet refs/remotes/origin/master
            set default_branch "master"
        else
            echo "❌ Could not determine default branch"
            return 1
        end
    end

    # Check if we're already on default branch
    if test "$current" = "$default_branch"
        echo "❌ Already on $default_branch branch."
        return 1
    end

    echo "✅ Pushing current branch: $current"
    if not git push
        echo "❌ Failed to push branch"
        return 1
    end

    echo "🔁 Switching to $default_branch..."
    if not git checkout $default_branch
        echo "❌ Failed to switch to $default_branch"
        return 1
    end

    echo "⬇️ Pulling latest $default_branch..."
    if not git pull
        echo "❌ Failed to pull $default_branch"
        return 1
    end

    echo "🧹 Deleting local branch: $current"
    if not git branch -d $current
        echo "❌ Failed to delete local branch (might have unmerged changes)"
        return 1
    end

    # Optional: delete remote branch too
    echo "🚮 Deleting remote branch: origin/$current"
    git push origin --delete $current
end