require("hyprland.lib")

--## Quit
hl.bind(MainMod .. " + SHIFT + X", hl.dsp.exec_cmd("uwsm stop"), { description = "Quit" })

--## !Apps
hl.bind(MainMod .. " + D", hl.dsp.exec_cmd(AppCommand("Launcher", true)), { description = "App: Launcher" })
hl.bind(MainMod .. " + Return", hl.dsp.exec_cmd(AppCommand("Terminal")), { description = "App: Terminal" })
hl.bind(MainMod .. " + E", hl.dsp.exec_cmd(AppCommand("FileManager")), { description = "App: File Manager" })

-- ## Utilities
hl.bind("Print", hl.dsp.exec_cmd(ScreenshotCommand("region")), { description = "Utility: Screenshot Region" })
hl.bind(MainMod .. " + Print", hl.dsp.exec_cmd(ScreenshotCommand("output")), { description = "Utility: Screenshot" })
hl.bind(MainMod .. " + L", hl.dsp.exec_cmd("hyprlock"), { description = "Utility: Lock screen" })
hl.bind(MainMod .. " + C", hl.dsp.exec_cmd("hyprpicker -a"), { description = "Utility: Color picker" })
hl.bind(MainMod .. " + O", hl.dsp.exec_cmd("grim -g \"$(slurp $SLURP_ARGS)\" /tmp/screenshot.png && tesseract /tmp/screenshot.png - | wl-copy && rm -f /tmp/screenshot.png"), { description = "Utility: OCR" })

--## !Control
hl.bind(MainMod .. " + SHIFT + Q", hl.dsp.window.close(), { description = "Window: Close" })
hl.bind(MainMod .. " + SHIFT + ALT + Q", hl.dsp.exec_cmd("hyprctl kill"), { description = "Window: Force close" })
hl.bind(MainMod .. " + F", hl.dsp.window.float({ action = "toggle" }), { description = "Window: Toggle floating" })
hl.bind(MainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }), { description = "Window: Toggle fullscreen" })
hl.bind(MainMod .. " + " .. MouseLeft, hl.dsp.window.drag(), { mouse = true, description = "Window: Drag" })
hl.bind(MainMod .. " + " .. MouseRight, hl.dsp.window.resize(), { mouse = true, description = "Window: Resize" })
hl.bind(MainMod .. " + G", hl.dsp.group.toggle(), { description = "Window: Toggle group" })

-- ## !Focus
local directions = { "up", "right", "down", "left" }
for _, direction in ipairs(directions) do
  hl.bind(MainMod .. " + " .. direction, hl.dsp.focus({ direction = direction }), { description = "Window: Focus " .. direction })
  hl.bind(MainMod .. " + SHIFT + " .. direction, hl.dsp.window.move({ direction = direction }), { description = "Window: Move " .. direction })
end

-- ## !Media Keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { description = "Media: Volume up" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { description = "Media: Volume down" })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { description = "Media: Toggle mute" })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { description = "Media: Toggle mic mute" })

--## !Workspaces
for i = 0, 9 do
  local workspace = i == 0 and 10 or i
  hl.bind(MainMod .. " + " .. i, hl.dsp.focus({ workspace = workspace}), { description = "Workspace: Focus " .. workspace })
  hl.bind(MainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = workspace}), { description = "Workspace: Move to " .. workspace })
end
-- T,Z,U
hl.bind(MainMod .. " + T", hl.dsp.focus({ workspace = "name:T"}), { description = "Workspace: Focus T" })
hl.bind(MainMod .. " + SHIFT + T", hl.dsp.window.move({ workspace = "name:T"}), { description = "Workspace: Move to T" })
hl.bind(MainMod .. " + Z", hl.dsp.focus({ workspace = "name:Z"}), { description = "Workspace: Focus Z" })
hl.bind(MainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "name:Z"}), { description = "Workspace: Move to Z" })
hl.bind(MainMod .. " + U", hl.dsp.focus({ workspace = "name:U"}), { description = "Workspace: Focus U" })
hl.bind(MainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "name:U"}), { description = "Workspace: Move to U" })

-- Special workspace (scratchpad)
hl.bind(MainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:", follow = false }), { description = "Workspace: Move to scratchpad" })
hl.bind(MainMod .. " + S", hl.dsp.workspace.toggle_special(""), { description = "Workspace: Focus scratchpad" })

-- Toggle side monitors with SUPORT + SHIFT + M
-- local sideMonitors = { "DP-3", "DP-2" }
-- hl.bind(MainMod .. " + SHIFT + M", function()
--   for _, output in ipairs(sideMonitors) do
--     local state = hl.get_monitor(output)
--     if state ~= nil then
--       local toggle = state.disabled == true and "false" or "true"
--       hl.monitor(output, { disabled = toggle })
--     end
--   end
-- end, { description = "Toggle side monitors" })
