# My Ultimate Tmux Configuration

This repository contains a highly optimized and feature-rich tmux configuration, designed to transform your terminal experience into a powerful, persistent, and visually appealing workspace. It leverages `tpm` (Tmux Plugin Manager) to manage a curated selection of plugins, enabling you to operate like a true terminal guru.

## Table of Contents

1.  [What is Tmux?](#what-is-tmux)
2.  [Installation & Setup](#installation--setup)
3.  [Key Concepts](#key-concepts)
    *   [Prefix Key](#prefix-key)
    *   [Sessions](#sessions)
    *   [Windows](#windows)
    *   [Panes](#panes)
4.  [Custom Keybindings](#custom-keybindings)
5.  [Plugins & Their Usage](#plugins--their-usage)
    *   [Tmux Plugin Manager (tpm)](#tmux-plugin-manager-tpm)
    *   [tmux-sensible](#tmux-sensible)
    *   [tmux-resurrect & tmux-continuum](#tmux-resurrect--tmux-continuum)
    *   [tmux-yank](#tmux-yank)
    *   [tmux-copycat](#tmux-copycat)
    *   [tmux-fzf-url](#tmux-fzf-url)
    *   [tmux-fzf-open-files-nvim](#tmux-fzf-open-files-nvim)
    *   [tmux-mem-cpu-load](#tmux-mem-cpu-load)
    *   [tmux-fingers](#tmux-fingers)
    *   [Catppuccin for Tmux](#catppuccin-for-tmux)
6.  [Productivity Tips for the Terminal Guru](#productivity-tips-for-the-terminal-guru)

---

## What is Tmux?

Tmux is a terminal multiplexer that allows you to create, manage, and persist multiple terminal sessions, each with multiple windows and panes, all within a single terminal window. This setup empowers you to:

*   **Maintain Persistent Workspaces:** Detach from a session and reattach later, even after closing your terminal, disconnecting from SSH, or system reboots.
*   **Organize Complex Workflows:** Divide your screen into multiple panes for simultaneous tasks (e.g., code editor, shell, logs, version control).
*   **Boost Multitasking Efficiency:** Seamlessly switch between different projects or tasks without losing context.

## Installation & Setup

To get this powerful tmux setup running on your system, follow these steps:

1.  **Clone this repository:**
    If you haven't already, clone your dotfiles repository. For example:
    ```bash
    git clone https://github.com/your-username/dotfiles.git ~/.dotfiles # Adjust path if different
    ```
2.  **Create a symbolic link** to your tmux configuration:
    Ensure your system's tmux looks for this configuration file:
    ```bash
    ln -s -f ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
    ```
3.  **Install `tpm` (Tmux Plugin Manager):**
    `tpm` is essential for managing all the plugins. If you don't have it, install it:
    ```bash
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ```
4.  **Start a new tmux session:**
    If you're in an existing tmux session, detach (`Ctrl+Space d`) and then start a fresh one by typing `tmux` in your terminal. If not, simply type `tmux`.
5.  **Install plugins:**
    Inside your new tmux session, press your prefix key (`Ctrl+Space`) followed by `I` (capital `i`). You should see a message indicating that the plugins are being fetched and installed.

## Key Concepts

### Prefix Key

The prefix key is the cornerstone of tmux interaction. It signals to tmux that the subsequent key combination is a command for tmux itself, not for the application running in the terminal.

**Your custom prefix key is `Ctrl+Space`.**

To execute any tmux command, you will always press `Ctrl+Space` first, release both keys, and then press the command key.

### Sessions

A tmux session is a persistent, independent workspace. It can contain multiple windows and panes. Sessions remain active even if you close your terminal or disconnect from your SSH session.

*   **Start a new session:** `tmux new -s my_session_name`
*   **Attach to an existing session:** `tmux attach -t my_session_name`
*   **List all sessions:** `tmux ls`
*   **Detach from current session:** `Ctrl+Space d`
*   **Kill a specific session:** `tmux kill-session -t session_name` (run from outside tmux or another session)
*   **Kill all sessions:** `tmux kill-server` (run from outside tmux after detaching)

### Windows

Within a session, windows function like tabs in a web browser. Each window can host different applications or tasks, and you can easily switch between them.

*   **Create a new window:** `Ctrl+Space c` (custom binding - opens in current pane's path)
*   **Next window:** `Ctrl+Space n`
*   **Previous window:** `Ctrl+Space p`
*   **Go to window by number:** `Ctrl+Space <number>` (e.g., `Ctrl+Space 1`)
*   **Rename current window:** `Ctrl+Space ,` (then type new name)
*   **Close current window:** `Ctrl+Space &` (prompts for confirmation)
*   **List windows:** `Ctrl+Space w`

### Panes

Panes are subdivisions within a window, allowing you to view multiple command-line interfaces or applications simultaneously. This is ideal for side-by-side coding, monitoring logs, or running tests.

*   **Split pane vertically:** `Ctrl+Space |` (custom binding - creates new pane to the right)
*   **Split pane horizontally:** `Ctrl+Space -` (custom binding - creates new pane below)
*   **Navigate panes (Vim-style):**
    *   `Ctrl+Space h`: Move to left pane
    *   `Ctrl+Space j`: Move to down pane
    *   `Ctrl+Space k`: Move to up pane
    *   `Ctrl+Space l`: Move to right pane
*   **Resize panes (Shift + Vim-style):**
    *   `Ctrl+Space H`: Resize left by 5 units
    *   `Ctrl+Space J`: Resize down by 5 units
    *   `Ctrl+Space K`: Resize up by 5 units
    *   `Ctrl+Space L`: Resize right by 5 units
*   **Swap panes:**
    *   `Ctrl+Space {`: Swap current pane with previous
    *   `Ctrl+Space }`: Swap current pane with next
*   **Kill current pane:** `Ctrl+Space x` (custom binding - prompts for confirmation)
*   **Toggle synchronized input:** `Ctrl+Space s` (custom binding - type in all panes in the current window simultaneously)

## Custom Keybindings

Here's a comprehensive list of the custom keybindings configured in your `tmux.conf`:

| Keybinding        | Action                                     | Notes                                                              |
| :---------------- | :----------------------------------------- | :----------------------------------------------------------------- |
| `Ctrl+Space r`    | Reload tmux configuration                  | Essential after making changes to `.tmux.conf`                        |
| `Ctrl+Space |`    | Split pane vertically                      | Creates a new pane to the right                                    |
| `Ctrl+Space -`    | Split pane horizontally                    | Creates a new pane below                                           |
| `Ctrl+Space h/j/k/l` | Navigate panes (left/down/up/right)        | Vim-style navigation for quick pane switching                      |
| `Ctrl+Space H/J/K/L` | Resize panes (left/down/up/right)          | Hold `Shift` while pressing Vim keys for precise resizing          |
| `Ctrl+Space {`    | Swap current pane with previous            | Reorder panes efficiently                                          |
| `Ctrl+Space }`    | Swap current pane with next                | Reorder panes efficiently                                          |
| `Ctrl+Space n`    | Go to next window                          | Fast window switching                                              |
| `Ctrl+Space p`    | Go to previous window                      | Fast window switching                                              |
| `Ctrl+Space c`    | Create new window in current path          | Opens a new window in the directory of your current pane           |
| `Ctrl+Space x`    | Kill current pane                          | Prompts for confirmation before closing a pane                     |
| `Ctrl+Space s`    | Toggle synchronized input                  | Type in all panes in the current window simultaneously (e.g., for running commands on multiple servers) |
| `Ctrl+Space [`    | Enter copy mode                            | Start selecting text                                               |
| `Ctrl+Space y`    | Copy selection to system clipboard         | After selecting text in copy mode                                  |
| `Ctrl+Space C-v`  | Toggle rectangle selection in copy mode    | For column-wise selection                                          |
| `Ctrl+Space Ctrl+s` | Manually save tmux environment             | Trigger `tmux-resurrect` save                                      |
| `Ctrl+Space Ctrl+r` | Manually restore tmux environment          | Trigger `tmux-resurrect` restore                                   |
| `Ctrl+Space f`    | Search in scrollback (tmux-copycat)        | Find text in your pane history                                     |
| `Ctrl+Space u`    | Open URL from scrollback (tmux-fzf-url)    | Use `fzf` to select and open URLs                                  |
| `Ctrl+Space o`    | Open file from scrollback (tmux-fzf-open-files-nvim) | Use `fzf` to select and open files in `nvim`                       |
| `Ctrl+Space F`    | Trigger tmux-fingers                       | Quickly select and copy/open small text snippets                   |

## Plugins & Their Usage

This configuration includes a powerful set of tmux plugins, managed by `tpm`.

### Tmux Plugin Manager (tpm)

`tpm` is the backbone for managing your tmux plugins. It simplifies installation, updates, and removal.

*   **Install plugins:** `Ctrl+Space I` (capital i) - Run this after cloning the config.
*   **Update plugins:** `Ctrl+Space U` (capital u) - Fetches latest versions of all plugins.
*   **Uninstall plugins:** `Ctrl+Space Alt+u` - Removes all plugins not listed in `.tmux.conf`.

### tmux-sensible

Provides a set of sensible default options for tmux, ensuring a good baseline experience without manual configuration of many common settings.

### tmux-resurrect & tmux-continuum

These two plugins provide robust session persistence, ensuring you never lose your work.

*   **`tmux-resurrect`**: Saves and restores your entire tmux environment (sessions, windows, panes, and their contents) across system reboots or tmux server restarts.
*   **`tmux-continuum`**: Builds on `tmux-resurrect` by providing continuous, automatic saving of your tmux environment at a set interval (configured to 15 minutes in your setup).

**Usage:**
*   **Automatic:** `tmux-continuum` is configured to automatically save and restore. When you start tmux, it will attempt to restore your last saved session.
*   **Manual Save:** `Ctrl+Space Ctrl+s`
*   **Manual Restore:** `Ctrl+Space Ctrl+r`

### tmux-yank

Seamlessly integrates tmux copy mode with your system clipboard, allowing you to copy text from tmux and paste it into other applications (and vice-versa).

**Usage:**
1.  **Enter copy mode:** `Ctrl+Space [`
2.  **Start selection:** In copy mode, move your cursor and press `v` (Vim-style) to begin visual selection.
3.  **Copy to system clipboard:** Press `y` (Vim-style) to copy the selected text to your system clipboard and exit copy mode.
4.  **Rectangle selection:** In copy mode, press `C-v` (Ctrl+v) to toggle rectangle selection.

### tmux-copycat

Enhances tmux's search capabilities, allowing you to quickly find text within your pane's scrollback history using regular expressions.

**Usage:**
*   **Search:** `Ctrl+Space f` (then type your search query/regex)

### tmux-fzf-url

Integrates `fzf` (a fuzzy finder) to quickly extract and open URLs from your tmux pane's scrollback history.

**Usage:**
*   **Open URL:** `Ctrl+Space u` (a list of URLs will appear, use `fzf` to select and open)

### tmux-fzf-open-files-nvim

Similar to `tmux-fzf-url`, this plugin uses `fzf` to find file paths in your scrollback and open them directly in Neovim (nvim).

**Usage:**
*   **Open File in Nvim:** `Ctrl+Space o` (a list of file paths will appear, use `fzf` to select and open)

### tmux-mem-cpu-load

Displays real-time memory and CPU usage directly in your tmux status bar, providing quick insights into system performance.

### tmux-fingers

A powerful tool for quickly selecting and acting upon small, identifiable bits of text (like Git SHAs, IP addresses, file paths, etc.) in your tmux pane.

**Usage:**
*   **Activate:** `Ctrl+Space F` (capital F). This will highlight detectable patterns. Then press the corresponding key to copy or open.

### Catppuccin for Tmux

Provides a beautiful, modern, and highly customizable theme for your tmux status line and windows. It's configured to display relevant information like CPU/RAM usage, battery status, current directory, and session name, enhancing both aesthetics and utility.

## Productivity Tips for the Terminal Guru

Mastering tmux is about building muscle memory and integrating it into your daily workflow. Here are some tips to elevate your terminal game:

*   **Name Your Sessions and Windows:** Use `tmux new -s project_name` when starting a new project, and `Ctrl+Space ,` to rename windows. This keeps your workspace organized and easy to navigate.
*   **Strategic Pane Layouts:** Design your window layouts for specific tasks. For example:
    *   **Development:** Editor (large pane) | Shell (small pane) | Logs (small pane)
    *   **Monitoring:** Multiple panes, each tailing a different log file or showing system metrics.
*   **Embrace Persistence:** With `tmux-resurrect` and `tmux-continuum`, you can confidently close your terminal or reboot your machine. Your entire workspace will be restored exactly as you left it.
*   **Master Copy Mode:** `tmux-yank` and `tmux-copycat` are game-changers. Learn to quickly select, search, and copy text to your system clipboard.
*   **Leverage `fzf` Integration:** `tmux-fzf-url` and `tmux-fzf-open-files-nvim` will save you immense time by allowing you to interact with URLs and files directly from your terminal output.
*   **Synchronize Panes for Repetitive Tasks:** If you need to run the same command on multiple servers (e.g., deploying to a cluster), `Ctrl+Space s` is invaluable.
*   **Efficient Navigation:** Practice switching between panes (`Ctrl+Space h/j/k/l`) and windows (`Ctrl+Space n/p`, `Ctrl+Space <number>`) until it's second nature.
*   **Detach and Reattach Regularly:** This is a core tmux feature. `Ctrl+Space d` to detach, then `tmux attach` to reattach. This allows you to keep long-running processes alive even if your SSH connection drops.
*   **Explore `tmux-fingers`:** This plugin is incredibly useful for quickly grabbing specific pieces of information from your terminal output without manual selection.

Enjoy your powerful new tmux environment and happy hacking!