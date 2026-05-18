hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 2,

    border_size = 1,
    resize_on_border = true,

    layout = "dwindle",

    allow_tearing = true,
  },

  input = {
    kb_layout = "hu,us",
    follow_mouse = 1,

    touchpad = {
      natural_scroll = false,
    }
  },

  group = {

    groupbar = {
      font_size = 12,
      height = 1,
      text_offset = -8,
      indicator_height = 14,
      keep_upper_gap = false,
      text_color = "rgba(ffffffee)",
    },

  },

  decoration = {
    rounding = 8,
    active_opacity = 1.0,
    inactive_opacity = 0.9,

    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    },

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(1a1a1aee)",
    }
  },

  animations = {
    enabled = true,
  },

  dwindle = {
    preserve_split = true,
    smart_split = true,
  },

  misc = {
    force_default_wallpaper = 0,
    key_press_enables_dpms = true,
    mouse_move_enables_dpms = true,
  }
})
