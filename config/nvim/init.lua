-- Saját, minimál nvim config. Elv: semmi nem töltődik be, aminek az adott gépen
-- nincs meg a függősége — egy csupasz szerveren is hiba nélkül kell indulnia.
-- Hogy mi megy ezen a gépen: lua/caps.lua (és a :Caps parancs).

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require "options"

local caps = require "caps"

-- lazy.nvim bootstrap — csak ahol a pluginek futni is tudnak (lásd caps.plugins)
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if caps.plugins and not vim.uv.fs_stat(lazypath) then
  vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", "https://github.com/folke/lazy.nvim.git", lazypath }
end

if not (caps.plugins and vim.uv.fs_stat(lazypath)) then
  -- plugin nélküli mód: beépített téma, a fájlfa helyett netrw (mappings.lua)
  caps.plugins = false
  pcall(vim.cmd.colorscheme, "habamax")
else
  vim.opt.rtp:prepend(lazypath)
  require("lazy").setup("plugins", {
    defaults = { lazy = true },
    install = { colorscheme = { "jellybeans", "habamax" } },
    change_detection = { notify = false },
    -- a config mappa symlink a dotfiles-ba: a lockfile így a repóba kerül
    lockfile = vim.fn.stdpath "config" .. "/lazy-lock.json",
    performance = {
      rtp = { disabled_plugins = { "gzip", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin" } },
    },
  })
end

require "mappings"
