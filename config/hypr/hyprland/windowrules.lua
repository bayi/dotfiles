-- Tags

hl.window_rule({
  match = { tag = "floating" },
  float = true,
  persistent_size = true,
  tag = "+focus",
})

hl.window_rule({
  match = { tag = "focus" },
  no_blur = true,
  no_dim = true,
  no_shadow = true,
  opacity = "1.0 1.0 override",
  opaque = true,
})

hl.window_rule({
  match = { tag = "game" },
  content = "game",
  -- fullscreen = true,
  maximize = true,
  immediate = true,
  decorate = false,
  no_anim = true,
  rounding = 0,
  workspace = "3",
  tag = "+focus",
})

-- Rules

hl.window_rule({
  name = "Firefox Rules",
  match = {
    class = "^(firefox)$"
  },
  tag = "+focus",
})

hl.window_rule({
  name = "Steam Friends Rules",
  match = {
    class = "^(steam)$",
    title = "^(Friends List|Barátlista)$"
  },
  tag = "+floating",
  no_screen_share = true,
})

-- hl.window_rule({
--   name = "Steam Chat Rules",
--   match = {
--     class = "^(steam)$",
--     title = "(chat|csevegés)"
--   },
--   tag = "+floating",
--   no_screen_share = true,
-- })

hl.window_rule({
  name = "Minecraft Rules",
  match = {
    class = "^(Minecraft.+)$"
  },
  tag = "+game",
})

hl.window_rule({
  name = "Steam Game Rules",
  match = {
    class = "^(steam_app_.+)$"
  },
  tag = "+game",
})

hl.window_rule({
  name = "OBS Rules",
  match = {
    class = "^(com.obsproject.Studio)$"
  },
  no_screen_share = true,
  tag = "+focus",
})

