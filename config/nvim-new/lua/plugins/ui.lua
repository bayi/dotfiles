-- Kinézet: téma, statusline, buffer fülek, which-key. Ezek mindenhol mennek.
return {
  {
    "wtfox/jellybeans.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("jellybeans").setup {}
      vim.cmd.colorscheme "jellybeans"
    end,
  },

  { "nvim-tree/nvim-web-devicons", opts = {} },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        globalstatus = true,
        section_separators = "",
        component_separators = "│",
      },
      sections = {
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "filetype" },
        lualine_y = { "hostname" },
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        offsets = { { filetype = "NvimTree", text = "Fájlok", highlight = "Directory" } },
      },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = { scope = { enabled = false } },
  },
}
