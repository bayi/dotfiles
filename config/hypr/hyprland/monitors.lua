-- DP-1: left
hl.monitor({
  output = "DP-1",
  mode = "2560x1440",
  position = "0x0",
  scale = 1,
})

-- HDMI-A-1: center
hl.monitor({
  output = "HDMI-A-1",
  mode = "2560x1440@99.95",
  position = "2560x0",
  scale = 1,
})

-- DP-2: right
hl.monitor({
  output = "DP-2",
  mode = "2560x1440",
  position = "5120x0",
  scale = 1,
})

-- HDMI-A-3: disabled
hl.monitor({
  output = "HDMI-A-3",
  disabled = true,
})

-- Everything else
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
