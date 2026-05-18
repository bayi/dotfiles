-- local home_dir = os.getenv("HOME")

-- Cursor config
hl.env("XCURSOR_SIZE", "32")
hl.env("HYPRCURSOR_SIZE", "32")
hl.env("XCURSOR_THEME", "Nordzy-cursors")
hl.env("HYPRCURSOR_THEME", "Nordzy-cursors")

-- Wayland
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

-- Firefox
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- GTK
hl.env("GDK_BACKEND", "wayland,x11")

-- QT
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
-- hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
-- hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
