-- Mit tud ez a gép? Minden gépfüggő döntés ebből a táblából megy, sehol máshol nincs feltétel.
local function has(bin)
  return vim.fn.executable(bin) == 1
end

local function exists(path)
  return vim.uv.fs_stat(vim.fn.expand(path)) ~= nil
end

-- van-e a fájlban kitöltött "kulcs = érték" sor (a tartalmát nem tároljuk, nem írjuk ki)
local function has_setting(path, key)
  local f = io.open(vim.fn.expand(path), "r")
  if not f then
    return false
  end
  local found = false
  for line in f:lines() do
    if line:match("^%s*" .. key .. "%s*=%s*%S") then
      found = true
      break
    end
  end
  f:close()
  return found
end

local M = {}

M.has = has

local modern = vim.fn.has "nvim-0.11" == 1

-- Pluginek egyáltalán: a mai pluginek (telescope, gitsigns…) 0.11-et kérnek, a Debian 13 0.10-et ad.
-- Régi nvim-en ezért plugin nélkül megyünk (beállítások + billentyűk + beépített téma), hiba nélkül.
M.plugins = modern and has "git"

-- natív LSP config (vim.lsp.config / vim.lsp.enable) csak 0.11-től van
M.lsp = M.plugins

-- treesitter (main ág): C fordító és a tree-sitter CLI kell a parserek fordításához
M.treesitter = M.plugins and (has "cc" or has "gcc" or has "clang") and has "tree-sitter"

-- mason: szinte minden szervere node-os, npm nélkül nincs értelme
M.mason = M.lsp and has "npm"

-- copilot: node kell, és csak ott, ahol már be van lépve (headless szerveren úgysem lesz)
M.copilot = M.plugins and has "node" and exists "~/.config/github-copilot/apps.json"

-- wakatime: csak ahol tényleg van API kulcs, különben fájlonként hibát dob
-- (a plugin kulcs nélkül is létrehozza a ~/.wakatime.cfg-t, ezért a fájl megléte nem elég)
M.wakatime = M.plugins and has_setting("~/.wakatime.cfg", "api_key")

-- telescope live grep
M.ripgrep = has "rg"

return M
