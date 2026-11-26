
-- Gaming workspace
hl.workspace_rule({
  workspace = "3",
  monitor = "HDMI-A-1",
  no_rounding = true,
  no_border = true,
  no_shadow = true,
  decorate = false,
  -- persistent = true,
})

-- Chat workspace
hl.workspace_rule({
  workspace = "10",
  monitor = "DP-1",
  default = true,
  persistent = true,
  no_rounding = true,
  no_border = true,
  no_shadow = true,
})

-- Coding workspace: ha üresen jön létre, induljon benne egy terminál
hl.on("workspace.created", function(ws)
  if ws and ws.name == "T" and ws.is_empty then
    hl.exec_cmd("alacritty", { workspace = "name:T" })
  end
end)
