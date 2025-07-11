# Neovim Configuration Guide (LazyVim)

Welcome to your Neovim setup! This guide will help you get started with the basics, understand key concepts, and leverage the power of LazyVim for a highly efficient development workflow, especially for Next.js, TypeScript, and Tailwind CSS.

## 1. The Neovim Philosophy: Modes

Neovim operates in different "modes," which dictate how your keystrokes are interpreted. This is fundamental to its power and speed.

*   **Normal Mode (Default):** This is where you navigate, delete, copy, paste, and execute commands. Most of your time will be spent here. You enter Normal mode by pressing `Esc`.
*   **Insert Mode:** This is where you type text, just like a regular text editor. You enter Insert mode by pressing `i` (insert before cursor), `a` (append after cursor), `o` (open new line below), etc. Press `Esc` to return to Normal mode.
*   **Visual Mode:** Used for selecting text.
    *   `v`: Character-wise selection.
    *   `V`: Line-wise selection.
    *   `Ctrl-v`: Block-wise selection.
    Once in Visual mode, you can use navigation keys to extend the selection, and then apply Normal mode commands (e.g., `d` to delete, `y` to yank/copy).
*   **Command-line Mode:** Used for executing commands (like saving, quitting, or running external tools). You enter this mode by pressing `:` in Normal mode.

## 2. Essential Basic Commands (Normal Mode)

*   `h`, `j`, `k`, `l`: Move cursor left, down, up, right.
*   `w`, `b`: Move word forward, backward.
*   `0`, `^`, `$`: Go to start of line, first non-blank character, end of line.
*   `gg`, `G`: Go to first line, last line.
*   `dd`: Delete current line.
*   `dw`: Delete word.
*   `yy`: Yank (copy) current line.
*   `yw`: Yank (copy) word.
*   `p`: Paste after cursor.
*   `u`: Undo last change.
*   `Ctrl-r`: Redo last undone change.
*   `:`: Enter Command-line mode.
    *   `:w`: Save file.
    *   `:q`: Quit Neovim.
    *   `:wq` or `:x`: Save and quit.
    *   `:q!`: Quit without saving (discard changes).

## 3. LazyVim Specifics: The `<leader>` Key

LazyVim heavily relies on the `<leader>` key for its custom keybindings. By default, your `<leader>` key is set to **Spacebar**.

*   **Accessing LazyVim Help:** Press `<leader>h` to open the LazyVim help menu, which lists many common keybindings. This is your go-to resource!

## 4. Key Features & Workflow Enhancements

### 4.1. File Navigation & Fuzzy Finding (Telescope)

LazyVim uses `telescope.nvim` for powerful fuzzy finding.
*   `<leader>ff`: Find files in your project. Start typing part of a filename, and Telescope will fuzzy-match it.
*   `<leader>fg`: Grep (search) for text across files in your project.
*   `<leader>fb`: List open buffers (files).
*   `<leader>fh`: Show command history.

### 4.2. Integrated Terminal (ToggleTerm)

You now have `toggleterm.nvim` for seamless terminal access.
*   `<leader>gt`: Toggle a floating terminal.
*   `<leader>gf`: Toggle a floating terminal (same as `gt`).
*   `<leader>gh`: Toggle a horizontal split terminal.
*   `<leader>gv`: Toggle a vertical split terminal.
*   **Tip:** Use this to run `npm run dev`, `git` commands, or `redis-cli` without leaving Neovim.

### 4.3. Auto-closing/Renaming Tags (`nvim-ts-autotag`)

*   When editing HTML, JSX, or TSX files, type an opening tag (e.g., `<div`), and the closing tag (`</div>`) will be automatically inserted.
*   If you change the opening tag (e.g., `<div>` to `<section>`), the closing tag will automatically update.
*   **Benefit:** Speeds up writing React/Next.js components.

### 4.4. Visual Color Previews (`nvim-colorizer.lua`)

*   When working with CSS or Tailwind CSS, any color codes (e.g., `#FF0000`, `rgb(255,0,0)`, `red`) will be visually highlighted with their actual color in the editor.
*   **Benefit:** Instant visual feedback for styling.

### 4.5. Language Server Protocol (LSP)

LazyVim sets up LSP for intelligent code features (e.g., `tsserver` for TypeScript).
*   `gd`: Go to definition.
*   `gr`: Go to references.
*   `<leader>rn`: Rename symbol.
*   `<leader>ca`: Code actions (e.g., fix errors, refactor).
*   `K`: Show documentation for the symbol under the cursor.
*   **Benefit:** Smart code completion, type checking, refactoring, and error highlighting.

### 4.6. Formatting & Linting

*   **Formatting on Save:** Your setup is configured to automatically format your code on save using tools like Prettier (for JS/TS/CSS). Just save the file (`:w`), and it should format.
*   **Linting:** ESLint integration provides real-time feedback on code quality and potential issues.

### 4.7. Splits & Tabs

*   `Ctrl-w v`: Split window vertically.
*   `Ctrl-w s`: Split window horizontally.
*   `Ctrl-w h/j/k/l`: Move between splits.
*   `Ctrl-w =`: Make all splits equal size.
*   `:tabnew`: Create a new tab.
*   `gt`, `gT`: Go to next/previous tab.

## 5. Customization

Your personal Neovim configuration files are located in:
*   `/mnt/Projects/dotfiles/nvim/lua/config/options.lua`: For general Neovim options (like the clipboard setting).
*   `/mnt/Projects/dotfiles/nvim/lua/plugins/`: Where you can add or override plugin configurations. I've added `web_dev.lua` here for web-specific plugins.

Feel free to explore these files and the LazyVim documentation for more advanced customization.

## 6. Getting Help

*   **Inside Neovim:**
    *   Press `<leader>h` for LazyVim's keybinding help.
    *   `:help <topic>`: Get help on any Neovim topic (e.g., `:help :w`, `:help clipboard`).
*   **LazyVim Documentation:** [https://www.lazyvim.org/](https://www.lazyvim.org/)
*   **Neovim Documentation:** [https://neovim.io/doc/user/](https://neovim.io/doc/user/)

Happy coding with Neovim!