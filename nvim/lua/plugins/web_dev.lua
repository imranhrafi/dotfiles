return {
  -- Auto-closing and auto-renaming HTML/JSX/TSX tags
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    config = true,
  },

  -- Visual color previews for CSS/Tailwind
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup({
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = true, -- "Name" codes like Blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          AARRGGBB = true, -- 0xAARRGGBB hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true, -- Enable all CSS functions: rgb_fn, hsl_fn
          mode = "background", -- "background" for a colored background, "foreground" for colored text, "virtualtext" for colored virtual text
          -- set to `true` for the plugin to work, or a table of languages to only work on
          -- enable_tailwind = true, -- Enable tailwind colors
        },
      })
    end,
  },

  -- Integrated terminal management
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    keys = {
      { "<leader>gt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
      { "<leader>gf", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Floating Terminal" },
      { "<leader>gh", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Horizontal Terminal" },
      { "<leader>gv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Toggle Vertical Terminal" },
    },
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-t>]], -- Default mapping to open terminal
        hide_numbers = true, -- Hide the number of each terminal
        direction = "float", -- "horizontal", "vertical", "float", "tab"
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2, -- the degree by which to darken to background terminal
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        persist_size = true,
        close_on_exit = true, -- close the terminal window when the process exits
        shell = vim.o.shell, -- change the default shell
        -- This field is only relevant if direction is set to 'float'
        float_opts = {
          border = "curved", -- 'single', 'double', 'rounded', 'curved', 'none'
          winblend = 0,
          height = 80,
          width = 80,
          row = nil,
          col = nil,
        },
      })
    end,
  },

  -- Override nvim-tree.lua settings for auto-close
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        auto_close = true,
      },
    },
  },
}
