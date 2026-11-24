-- Fájlfa, kereső, git jelek, treesitter.
local caps = require "caps"

return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = {
      { "<C-n>", "<cmd>NvimTreeToggle<CR>", desc = "Fájlfa ki/be" },
      { "<leader>e", "<cmd>NvimTreeFocus<CR>", desc = "Fájlfa fókusz" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      disable_netrw = true,
      sync_root_with_cwd = true,
      update_focused_file = { enable = true },
      -- rejtett és gitignore-olt fájlok is látsszanak
      filters = { dotfiles = false, git_ignored = false },
      git = { enable = true },
      renderer = { highlight_git = true },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<leader>ff",
        function()
          local builtin = require "telescope.builtin"
          -- rg/fd tiszteli a .gitignore-t. Ha egyik sincs, a telescope sima find-ra esne vissza
          -- (vendor, node_modules és társai is jönnének) — git repóban ilyenkor a git listáz.
          if caps.ripgrep or caps.has "fd" then
            builtin.find_files()
          elseif not pcall(builtin.git_files, { show_untracked = true }) then
            builtin.find_files()
          end
        end,
        desc = "Fájl keresés",
      },
      { "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", desc = "Fájl keresés (mind)" },
      {
        "<leader>fw",
        function()
          if not caps.ripgrep then
            vim.notify("A szöveges kereséshez ripgrep (rg) kell, ezen a gépen nincs", vim.log.levels.WARN)
            return
          end
          require("telescope.builtin").live_grep()
        end,
        desc = "Szöveg keresés (rg)",
      },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Bufferek" },
      { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Legutóbbi fájlok" },
      { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Keresés a bufferben" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Súgó" },
      { "<leader>ma", "<cmd>Telescope marks<CR>", desc = "Jelölők" },
      { "<leader>cm", "<cmd>Telescope git_commits<CR>", desc = "Git commitok" },
      { "<leader>gt", "<cmd>Telescope git_status<CR>", desc = "Git státusz" },
    },
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" },
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    cond = caps.has "git",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      numhl = true,
      current_line_blame = true,
      current_line_blame_opts = { virt_text_pos = "eol", delay = 1000 },
      signs = {
        delete = { text = "󰍵" },
        changedelete = { text = "󱕖" },
      },
    },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Treesitter (main ág): csak ahol le is tudja fordítani a parsereket (caps.treesitter).
  -- Ahol nincs, ott marad a beépített regexes kiemelés — hiba nélkül.
  {
    "nvim-treesitter/nvim-treesitter",
    cond = caps.treesitter,
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install {
        "vim", "lua", "vimdoc",
        "html", "css", "scss", "javascript", "typescript", "vue", "pug", "php", "blade",
        "bash", "python", "c", "cpp",
        "yaml", "json", "markdown",
      }
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          -- ha az adott nyelvhez nincs parser, csendben marad
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
}
