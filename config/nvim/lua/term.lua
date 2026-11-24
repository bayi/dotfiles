-- Ki/be kapcsolható terminálok (float / horizontal / vertical), plugin nélkül.
-- Mindegyik fajtából egy van; elrejtve is tovább fut.
local M = {}
local terms = {} -- kind -> { buf, win }

local function open_win(kind, buf)
  if kind == "float" then
    local w = math.floor(vim.o.columns * 0.8)
    local h = math.floor(vim.o.lines * 0.7)
    return vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = w,
      height = h,
      col = math.floor((vim.o.columns - w) / 2),
      row = math.floor((vim.o.lines - h) / 2) - 1,
      border = "rounded",
      style = "minimal",
    })
  end
  vim.cmd(kind == "vertical" and "botright vsplit" or "botright 12split")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn = "no"
  return win
end

function M.toggle(kind)
  local t = terms[kind] or {}
  terms[kind] = t

  if t.win and vim.api.nvim_win_is_valid(t.win) then
    vim.api.nvim_win_close(t.win, true)
    t.win = nil
    return
  end

  local fresh = not (t.buf and vim.api.nvim_buf_is_valid(t.buf))
  if fresh then
    t.buf = vim.api.nvim_create_buf(false, true)
  end
  t.win = open_win(kind, t.buf)
  if fresh then
    vim.fn.termopen(vim.o.shell)
  end
  vim.cmd "startinsert"
end

return M
