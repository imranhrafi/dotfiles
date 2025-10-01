return {
  "nvim-telescope/telescope.nvim",
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