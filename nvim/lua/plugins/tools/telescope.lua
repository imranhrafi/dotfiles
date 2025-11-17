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
    pickers = {
      find_files = {
        -- Force the file finder to use `fd` and explicitly exclude common folders.
        -- This is more reliable than relying on `file_ignore_patterns` alone.
        find_command = {
          "fd",
          "--type",
          "f",
          "--hidden",
          "--strip-cwd",
          "--exclude",
          ".git/",
          "--exclude",
          "node_modules/",
          "--exclude",
          ".next/",
          "--exclude",
          "dist/",
          "--exclude",
          ".vercel/",
        },
      },
    },
  },
}