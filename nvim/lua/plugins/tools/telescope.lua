return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep (Text Search)" },
    { "<leader>fG", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
  },
  opts = {
    defaults = {
      file_ignore_patterns = {
        "node_modules/",
        ".next/",
        "dist/",
        ".vercel/",
        "%.lock",
        "lazy-lock.json",
      },
    },
  },
}