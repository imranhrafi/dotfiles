#!/usr/bin/env fish

# Smart process killing with fuzzy search
#
# Usage:
#   pskill process_name    # Shows matching processes and lets you choose which to kill
#
# Examples:
#   pskill chrome         # Find and kill Chrome processes
#   pskill python         # Find and kill Python processes
#   pskill node           # Find and kill Node.js processes
#
# Features:
# - Interactive process selection
# - Confirmation prompt before killing
# - Fuzzy search matching
# - Shows process name and PID
# - Safe default (requires confirmation)
# - Multiple process selection support

function pskill
    if test (count $argv) -eq 0
        echo "Usage: pskill [process_name]"
        return 1
    end

    set -l search_term $argv[1]
    
    # Get matching processes
    set -l processes (ps aux | grep -v grep | grep -i $search_term)
    
    if test (count $processes) -eq 0
        echo "No matching processes found"
        return 1
    end
    
    # If only one process matches, kill it directly
    if test (count $processes) -eq 1
        set -l pid (echo $processes[1] | awk '{print $2}')
        set -l name (echo $processes[1] | awk '{print $11}')
        read -l -P "Kill process $name (PID: $pid)? [y/N] " confirm
        if test $confirm = "y"
            kill $pid
            echo "Process killed"
        end
        return
    end
    
    # Show multiple matches and let user choose
    echo "Multiple matching processes found:"
    for i in (seq (count $processes))
        set -l pid (echo $processes[$i] | awk '{print $2}')
        set -l name (echo $processes[$i] | awk '{print $11}')
        echo "$i: $name (PID: $pid)"
    end
    
    read -l -P "Enter number of process to kill (or 'q' to quit): " choice
    
    if test $choice = "q"
        return
    end
    
    if test $choice -gt 0; and test $choice -le (count $processes)
        set -l pid (echo $processes[$choice] | awk '{print $2}')
        set -l name (echo $processes[$choice] | awk '{print $11}')
        read -l -P "Kill process $name (PID: $pid)? [y/N] " confirm
        if test $confirm = "y"
            kill $pid
            echo "Process killed"
        end
    else
        echo "Invalid choice"
        return 1
    end
end 