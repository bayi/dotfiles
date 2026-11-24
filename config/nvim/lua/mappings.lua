-- A billentyűk a megszokott NvChad kiosztást követik.
local map = vim.keymap.set

map("n", ";", ":", { desc = "Parancs mód" })
map("i", "jk", "<ESC>")
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Keresés kiemelés ki" })

-- mozgás insert módban
map("i", "<C-b>", "<ESC>^i", { desc = "Sor eleje" })
map("i", "<C-e>", "<End>", { desc = "Sor vége" })
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")

-- ablakok
map("n", "<C-h>", "<C-w>h", { desc = "Ablak balra" })
map("n", "<C-l>", "<C-w>l", { desc = "Ablak jobbra" })
map("n", "<C-j>", "<C-w>j", { desc = "Ablak le" })
map("n", "<C-k>", "<C-w>k", { desc = "Ablak fel" })

-- fájl
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Mentés" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Egész fájl másolása" })
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Sorszám ki/be" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Relatív sorszám ki/be" })

-- bufferek
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "Új buffer" })
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Következő buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Előző buffer" })
map("n", "<leader>x", function()
  -- buffer bezárása úgy, hogy az ablak megmaradjon
  local buf = vim.api.nvim_get_current_buf()
  if vim.bo[buf].modified then
    vim.notify("A buffer nincs mentve", vim.log.levels.WARN)
    return
  end
  local alt = vim.fn.bufnr "#"
  if alt > 0 and alt ~= buf and vim.bo[alt].buflisted then
    vim.cmd "buffer #"
  else
    vim.cmd "bprevious"
  end
  if vim.api.nvim_get_current_buf() == buf then
    vim.cmd "enew"
  end
  pcall(vim.api.nvim_buf_delete, buf, {})
end, { desc = "Buffer bezárása" })

-- komment (beépített gc, 0.10+)
map("n", "<leader>/", "gcc", { remap = true, desc = "Komment ki/be" })
map("v", "<leader>/", "gc", { remap = true, desc = "Komment ki/be" })

-- terminál
local term = require "term"
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Kilépés terminál módból" })
map({ "n", "t" }, "<A-i>", function() term.toggle "float" end, { desc = "Lebegő terminál" })
map({ "n", "t" }, "<A-h>", function() term.toggle "horizontal" end, { desc = "Vízszintes terminál" })
map({ "n", "t" }, "<A-v>", function() term.toggle "vertical" end, { desc = "Függőleges terminál" })

-- plugin nélküli módban (régi nvim) a fájlfa a beépített netrw
if not require("caps").plugins then
  map("n", "<C-n>", "<cmd>Lexplore<CR>", { desc = "Fájlfa (netrw) ki/be" })
  map("n", "<leader>e", "<cmd>Lexplore<CR>", { desc = "Fájlfa (netrw)" })
end

-- diagnosztika
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "Diagnosztika lista" })

-- LSP (csak ahol csatlakozik szerver)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local function lmap(keys, fn, desc)
      map("n", keys, fn, { buffer = args.buf, desc = "LSP " .. desc })
    end
    lmap("gD", vim.lsp.buf.declaration, "deklaráció")
    lmap("gd", vim.lsp.buf.definition, "definíció")
    lmap("<leader>D", vim.lsp.buf.type_definition, "típus definíció")
    lmap("<leader>ra", vim.lsp.buf.rename, "átnevezés")
    lmap("<leader>ca", vim.lsp.buf.code_action, "code action")
    lmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "workspace mappa hozzáadás")
    lmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "workspace mappa törlés")
  end,
})
