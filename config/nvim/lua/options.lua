local o = vim.opt

-- megjelenés
o.number = true
o.relativenumber = true
o.numberwidth = 2
o.cursorline = true
o.cursorlineopt = "both"
o.signcolumn = "yes"
o.laststatus = 3 -- egy közös statusline
o.showmode = false
o.ruler = false
o.termguicolors = true
o.fillchars = { eob = " " }
o.shortmess:append "sI"
o.splitbelow = true
o.splitright = true

-- szerkesztés
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.smartindent = true
o.ignorecase = true
o.smartcase = true
o.mouse = "a"
o.whichwrap:append "<>[]hl"
o.timeoutlen = 400
o.undofile = true
o.clipboard = "unnamedplus"

-- gyakori swap írás, mert sokszor megy el az áram :D
o.updatetime = 50

-- Blade
vim.filetype.add {
  pattern = { [".*%.blade%.php"] = "blade" },
}

-- PHP-ban a $ a szó része
vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    vim.opt_local.iskeyword:append "$"
  end,
})

vim.diagnostic.config {
  virtual_text = true,
  severity_sort = true,
  float = { border = "rounded" },
}

-- :Caps — mit kapcsolt be/ki a config ezen a gépen
vim.api.nvim_create_user_command("Caps", function()
  local lines = {}
  for name, value in pairs(require "caps") do
    if type(value) == "boolean" then
      lines[#lines + 1] = string.format("%-12s %s", name, value and "igen" or "nem")
    end
  end
  table.sort(lines)
  print(table.concat(lines, "\n"))
end, { desc = "Mi megy ezen a gépen" })
