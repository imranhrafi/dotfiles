# Neovim Expert's Guide: From VS Code to Vim Mastery

This guide is your personal reference for mastering the Neovim workflow. Read this after a long break to get back up to speed in minutes.

## Part 1: The Mindset Shift - "Thinking in Vim"

The core of Neovim is **modal editing**. Unlike VS Code, where you are always typing, Neovim has different modes for different tasks.

-   **Normal Mode:** The default mode and your command center. Keys are used for navigation, manipulation, and executing commands. **Spend 80% of your time here.**
-   **Insert Mode:** This is for typing text. Enter it deliberately (`i`, `a`, `o`), type what you need, and **immediately escape back to Normal mode** (`Esc` or `jk`).
-   **Visual Mode:** Used for selecting text (`v` for character, `V` for line, `Ctrl-v` for block).

The expert workflow is a rapid dance: `Normal -> Insert -> Normal -> Visual -> Normal`.

## Part 2: The Language of Vim - The Action-Motion Grammar

Stop memorizing keystrokes. Start thinking in the Vim language: **`[action][number][motion]`**.

#### Actions (Verbs):
-   `d`: delete
-   `c`: change (deletes and enters Insert mode)
-   `y`: yank (copy)
-   `v`: visually select

#### Motions (Nouns):
-   `w`: forward one word
-   `b`: backward one word
-   `$`: end of the current line
-   `^`: first non-whitespace character of the line
-   `}`: to the end of the paragraph
-   `t{char}`: move **t**ill you reach `{char}`
-   `f{char}`: move to the next **f**ind of `{char}`

#### Text Objects (Powerful Nouns):
-   `i"`: **i**nside quotes
-   `a"`: **a**round quotes (includes the quotes)
-   `i)`: **i**nside parentheses
-   `a(`: **a**round parentheses
-   `it`: **i**nside tag (e.g., `<div>...</div>`)
-   `at`: **a**round tag

#### Forming Sentences:
-   **Delete 3 words:** `d3w`
-   **Change text inside quotes:** `ci"`
-   **Copy an entire HTML element:** `yat` (yank around tag)
-   **Delete everything until the next 'x':** `dtx`

> **Your First Goal:** Stop using the arrow keys. Force yourself to use `h, j, k, l` and the motion commands. It will be slow for a day, then faster forever.

## Part 3: Your Expert Toolkit (Mapping VS Code to Your Neovim)

| VS Code Feature | Neovim Equivalent (Your Keymap) | The "Expert" Way |
| :--- | :--- | :--- |
| **File Explorer** | Toggle with `<leader>e` | You rarely need it. Use **Telescope** (`<leader>ff`) to fuzzy find and open any file in the project instantly. It's faster. |
| **Global Search** | Telescope Grep: `<leader>fg` | Type `<leader>fg`, enter your search term, and see results in a floating window. Press Enter to jump to the file and line. |
| **Command Palette** | Telescope Commands: `<leader>:` | Find and run any Neovim command without knowing its name. |
| **Integrated Terminal** | `<leader>gt` (float), `<leader>gh` (horizontal) | Your direct replacement. Run `npm run dev`, `git`, etc. Use `<c-t>` to quickly toggle it from Insert mode. |
| **Go to Definition** | `gd` | On a variable/function, press `gd`. Use `Ctrl-o` to jump back. |
| **Find References** | `gr` | Find all usages of a symbol across your project. |
| **Rename Symbol** | `<leader>rn` | Rename a variable, and LSP will refactor it across all files. |
| **Show Errors** | `<leader>xd` (Diagnostics) | Open a list of all project diagnostics and jump to them. |
| **Multi-cursor Edit** | Visual Block Mode (`Ctrl-v`) | Press `Ctrl-v`, select lines with `j`/`k`, press `I` (capital i), type your text, and press `Esc`. The text appears on all selected lines. |
| **Buffer/Tab Nav** | `Shift-L` (Next), `Shift-H` (Prev) | Use buffer navigation to move between the "tabs" in your bufferline. `gt`/`gT` are for native Vim tabs, which you rarely use. |

## Part 4: A Real-World Expert Workflow

**Scenario:** You need to add a new `email` field to a user profile form.

1.  **Find the file:** Press `<leader>ff` and type `profleform`. Telescope finds `UserProfileForm.tsx`. Hit Enter.
2.  **Navigate:** Use `j` to move down to the `name` input. Press `o` to open a new line below and enter Insert mode.
3.  **Write Code:** Type out the new `<input>` component for the email. Press `Esc` to return to Normal mode.
4.  **Copy/Paste:** The new input needs a `div` wrapper like the one around the `name` field. Move up (`k`) to that `div` and press `yap` (yank around paragraph). Move back down (`j`) and press `p` to paste.
5.  **Change Text:** The pasted block says "Name". Put your cursor on the word and press `ciw` (change in word), then type "Email".
6.  **Check Errors:** An LSP warning appears. Hover over it with `K` to see the error message.
7.  **Open Terminal:** Press `<leader>gt` to toggle your floating terminal to check the dev server.
8.  **Commit Changes:** Press `<leader>gg` to open **LazyGit**. Press `a` to stage changes, `c` to commit, type your message, and press Enter. Press `q` to close LazyGit.

You just did all of that without your hands ever leaving the home row. **That is the power of Neovim.**
