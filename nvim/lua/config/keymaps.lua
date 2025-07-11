-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>Q", ":qa<CR>", { desc = "Quit all windows" })
vim.keymap.set("n", "<C-e>", "<C-w>h", { desc = "Focus file explorer" })
vim.keymap.set("n", "gt", "<cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "gT", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
