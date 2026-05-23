
-- Gaming workspace
hl.workspace_rule({
  workspace = "3",
  monitor = "HDMI-A-2",
  no_rounding = true,
  no_border = true,
  no_shadow = true,
  decorate = false,
  -- persistent = true,
})

-- Chat workspace
hl.workspace_rule({
  workspace = "10",
  monitor = "DP-3",
  default = true,
  persistent = true,
  no_rounding = true,
  no_border = true,
  no_shadow = true,
})

-- Coding workspace
hl.workspace_rule({
  workspace = "name:T",
  on_created_empty = "alacritty",
})
