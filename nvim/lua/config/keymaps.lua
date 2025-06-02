local discipline = require("craftzdog.discipline")
discipline.cowboy()

-- Alias for cleaner usage
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Utility function to simplify repetitive leader mappings
local function map_leader(modes, lhs, rhs, desc)
  for _, mode in ipairs(modes) do
    keymap(mode, "<Leader>" .. lhs, rhs, { desc = desc, noremap = true, silent = true })
  end
end

-- === Editing ===
map_leader({ "n" }, "p", '"0p', "Paste last yank (below)")
map_leader({ "n" }, "P", '"0P', "Paste last yank (above)")
map_leader({ "v" }, "p", '"0p', "Paste last yank over selection")
map_leader({ "n", "v" }, "c", '"_c', "Change without yanking")
map_leader({ "n", "v" }, "C", '"_C', "Change to EOL without yanking")
map_leader({ "n", "v" }, "d", '"_d', "Delete without yanking")
map_leader({ "n", "v" }, "D", '"_D', "Delete to EOL without yanking")
keymap("n", "x", '"_x', { desc = "Delete char without yanking", noremap = true, silent = true })
keymap("v", "p", '"_dP', { desc = "Paste over without yanking", noremap = true, silent = true })
keymap("n", "dw", 'vb"_d', { desc = "Delete word backwards", noremap = true, silent = true })

-- Increment/Decrement
keymap("n", "+", "<C-a>", { desc = "Increment number", noremap = true, silent = true })
keymap("n", "-", "<C-x>", { desc = "Decrement number", noremap = true, silent = true })

-- === Navigation ===
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Move up (wrapped)", expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Move down (wrapped)", expr = true, silent = true })
keymap("n", "<C-i>", "<C-i>", { desc = "Jump forward in jumplist", noremap = true, silent = true }) -- Avoid <C-m> collision

-- === Visual Mode ===
keymap("v", "<", "<gv", { desc = "Indent left and reselect", noremap = true, silent = true })
keymap("v", ">", ">gv", { desc = "Indent right and reselect", noremap = true, silent = true })

-- === Line Movement ===
keymap("n", "<A-j>", ":move .+1<CR>==", { desc = "Move line down", noremap = true, silent = true })
keymap("n", "<A-k>", ":move .-2<CR>==", { desc = "Move line up", noremap = true, silent = true })
keymap("i", "<A-j>", "<Esc>:move .+1<CR>==gi", { desc = "Move line down (insert)", noremap = true, silent = true })
keymap("i", "<A-k>", "<Esc>:move .-2<CR>==gi", { desc = "Move line up (insert)", noremap = true, silent = true })
keymap("v", "<A-j>", ":move '>+1<CR>gv=gv", { desc = "Move selection down", noremap = true, silent = true })
keymap("v", "<A-k>", ":move '<-2<CR>gv=gv", { desc = "Move selection up", noremap = true, silent = true })

-- === File & Buffer Management ===
keymap("n", "<C-a>", "ggVG", { desc = "Select all", noremap = true, silent = true }) -- Simplified from gg<S-v>G
keymap("n", "<Leader>w", ":update<CR>", { desc = "Save file", noremap = true, silent = true })
keymap("n", "<Leader>q", ":quit<CR>", { desc = "Quit current window", noremap = true, silent = true })
keymap("n", "<Leader>Q", ":qa<CR>", { desc = "Quit all", noremap = true, silent = true })
keymap("n", "<Leader>k", ":nohlsearch<CR>", { desc = "Clear search highlight", noremap = true, silent = true })

-- === Window Management ===
keymap("n", "ss", ":split<CR>", { desc = "Horizontal split", noremap = true, silent = true })
keymap("n", "sv", ":vsplit<CR>", { desc = "Vertical split", noremap = true, silent = true })
keymap("n", "sh", "<C-w>h", { desc = "Move to left window", noremap = true, silent = true })
keymap("n", "sj", "<C-w>j", { desc = "Move to below window", noremap = true, silent = true })
keymap("n", "sk", "<C-w>k", { desc = "Move to above window", noremap = true, silent = true })
keymap("n", "sl", "<C-w>l", { desc = "Move to right window", noremap = true, silent = true })
keymap("n", "<C-left>", "<C-w><", { desc = "Decrease width", noremap = true, silent = true })
keymap("n", "<C-right>", "<C-w>>", { desc = "Increase width", noremap = true, silent = true })
keymap("n", "<C-up>", "<C-w>+", { desc = "Increase height", noremap = true, silent = true })
keymap("n", "<C-down>", "<C-w>-", { desc = "Decrease height", noremap = true, silent = true })

-- === Tab Management ===
keymap("n", "te", ":tabedit<CR>", { desc = "New tab", noremap = true, silent = true })
keymap("n", "<Tab>", ":tabnext<CR>", { desc = "Next tab", noremap = true, silent = true })
keymap("n", "<S-Tab>", ":tabprevious<CR>", { desc = "Previous tab", noremap = true, silent = true })

-- === Plugins ===
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer", noremap = true, silent = true })
keymap("n", "<Leader>f", ":NvimTreeFindFile<CR>", { desc = "Find file in explorer", noremap = true, silent = true })
keymap("n", "<Leader>mp", ":MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown preview", noremap = true, silent = true })
keymap("n", "<Leader>r", function()
  local ok, hsl = pcall(require, "craftzdog.hsl")
  if ok then hsl.replaceHexWithHSL() else vim.notify("HSL module not found", "error") end
end, { desc = "Replace hex with HSL", noremap = true, silent = true })
keymap("n", "<Leader>i", function()
  local ok, lsp = pcall(require, "craftzdog.lsp")
  if ok then lsp.toggleInlayHints() else vim.notify("LSP module not found", "error") end
end, { desc = "Toggle inlay hints", noremap = true, silent = true })

-- === Miscellaneous ===
keymap("n", "<Leader>o", "o<Esc>^Da", { desc = "New line below (no auto-indent)", noremap = true, silent = true })
keymap("n", "<Leader>O", "O<Esc>^Da", { desc = "New line above (no auto-indent)", noremap = true, silent = true })
keymap("n", "<C-j>", vim.diagnostic.goto_next, { desc = "Next diagnostic", noremap = true, silent = true })