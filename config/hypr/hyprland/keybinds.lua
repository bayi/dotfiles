require("hyprland.lib")

local mainMod = "SUPER"

--## Quit
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("uwsm stop"), { description = "Quit" })

--## !Apps
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(launcherapp), { description = "App: Launcher" })
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal), { description = "App: Terminal" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager), { description = "App: File Manager" })

-- ## Utilities
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"), { description = "Utility: Lock screen" })
hl.bind("Print", hl.dsp.exec_cmd(screenshotRegion), { description = "Utility: Screenshot Fullscreen" })
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(screenshotRegion), { description = "Utility: Screenshot Region" })
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("hyprpicker -a"), { description = "Utility: Color picker" })
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("grim -g \"$(slurp $SLURP_ARGS)\" /tmp/screenshot.png && tesseract /tmp/screenshot.png - | wl-copy && rm -f /tmp/screenshot.png"), { description = "Utility: OCR" })

--## !Control
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close(), { description = "Window: Close" })
hl.bind(mainMod .. " + SHIFT + ALT + Q", hl.dsp.exec_cmd("hyprctl kill"), { description = "Window: Force close" })
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }), { description = "Window: Toggle floating" })
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }), { description = "Window: Toggle fullscreen" })
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Window: Drag" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Window: Resize" })
hl.bind(mainMod .. " + G", hl.dsp.group.toggle(), { description = "Window: Toggle group" })

-- ## !Focus
hl.bind(mainMod .. " + Up", hl.dsp.focus({ direction = "up" }), { description = "Window: Focus up" })
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "right" }), { description = "Window: Focus right" })
hl.bind(mainMod .. " + Down", hl.dsp.focus({ direction = "down" }), { description = "Window: Focus down" })
hl.bind(mainMod .. " + Left", hl.dsp.focus({ direction = "left" }), { description = "Window: Focus left" })
hl.bind(mainMod .. " + SHIFT + Up", hl.dsp.window.move({ direction = "up" }), { description = "Window: Move up" })
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.move({ direction = "right" }), { description = "Window: Move right" })
hl.bind(mainMod .. " + SHIFT + Down", hl.dsp.window.move({ direction = "down" }), { description = "Window: Move down" })
hl.bind(mainMod .. " + SHIFT + Left", hl.dsp.window.move({ direction = "left" }), { description = "Window: Move left" })

-- ## !Media Keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { description = "Media: Volume up" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { description = "Media: Volume down" })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { description = "Media: Toggle mute" })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { description = "Media: Toggle mic mute" })

--## !Workspaces
for i = 0, 9 do
  local workspace = i == 0 and 10 or i
  hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = workspace}), { description = "Workspace: Focus " .. workspace })
  hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = workspace}), { description = "Workspace: Move to " .. workspace })
end
-- T,Z,U
hl.bind(mainMod .. " + T", hl.dsp.focus({ workspace = "name:T"}), { description = "Workspace: Focus T" })
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.window.move({ workspace = "name:T"}), { description = "Workspace: Move to T" })
hl.bind(mainMod .. " + Z", hl.dsp.focus({ workspace = "name:Z"}), { description = "Workspace: Focus Z" })
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "name:Z"}), { description = "Workspace: Move to Z" })
hl.bind(mainMod .. " + U", hl.dsp.focus({ workspace = "name:U"}), { description = "Workspace: Focus U" })
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "name:U"}), { description = "Workspace: Move to U" })

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:special", follow = false }), { description = "Workspace: Move to scratchpad" })
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("special"), { description = "Workspace: Focus scratchpad" })
