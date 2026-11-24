-- LSP, kiegészítés, formázás, Copilot, WakaTime. Itt van a legtöbb gépfüggő dolog.
local caps = require "caps"

-- LSP szerver -> a bináris, ami kell hozzá. Egy szerver csak akkor kapcsol be,
-- ha a binárisa megvan (rendszerből vagy masonból) — különben meg sem próbálja.
local servers = {
  lua_ls = "lua-language-server",
  html = "vscode-html-language-server",
  cssls = "vscode-css-language-server",
  tailwindcss = "tailwindcss-language-server",
  vue_ls = "vue-language-server",
  pug = "pug-lsp",
  intelephense = "intelephense",
  pyright = "pyright-langserver",
  clangd = "clangd",
}

local function setup_lsp()
  vim.lsp.config("*", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  })

  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = { globals = { "vim" } },
        workspace = { library = { vim.env.VIMRUNTIME .. "/lua" }, checkThirdParty = false },
      },
    },
  })

  vim.lsp.config("intelephense", {
    settings = {
      intelephense = {
        -- az alap stubok + ami a Laravel/WAM projektekhez kell (mcrypt, redis, swoole, random)
        stubs = {
          "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl", "date", "dba", "dom",
          "enchant", "exif", "FFI", "fileinfo", "filter", "fpm", "ftp", "gd", "gettext", "gmp", "hash", "iconv",
          "imap", "intl", "json", "ldap", "libxml", "mbstring", "meta", "mysqli", "oci8", "odbc", "openssl", "pcntl",
          "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "posix", "pspell",
          "readline", "Reflection", "session", "shmop", "SimpleXML", "snmp", "soap", "sockets", "sodium", "SPL",
          "sqlite3", "standard", "superglobals", "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer", "xml",
          "xmlreader", "xmlrpc", "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib", "mcrypt", "redis", "swoole", "random",
        },
      },
    },
  })

  for name, bin in pairs(servers) do
    if caps.has(bin) then
      vim.lsp.enable(name)
    end
  end
end

return {
  -- Mason: LSP szerverek telepítése (:Mason). Csak ahol van npm; a bin mappáját a PATH elejére teszi.
  {
    "mason-org/mason.nvim",
    cond = caps.mason,
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    cond = caps.lsp,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason-org/mason.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = setup_lsp,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      { "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
    },
    config = function()
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      }
    end,
  },

  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format { lsp_format = "fallback" }
        end,
        desc = "Formázás",
      },
    },
    opts = {
      formatters_by_ft = { lua = { "stylua" } },
    },
  },

  -- Copilot: csak ahol van node és már be van lépve. Elfogadás: Ctrl+R (a Tab a cmp-é).
  {
    "github/copilot.vim",
    cond = caps.copilot,
    event = "InsertEnter",
    init = function()
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<C-r>", 'copilot#Accept("<CR>")', { expr = true, replace_keycodes = false, desc = "Copilot elfogad" })
    end,
  },

  -- WakaTime: csak ahol van ~/.wakatime.cfg
  {
    "wakatime/vim-wakatime",
    cond = caps.wakatime,
    event = "VeryLazy",
  },
}
