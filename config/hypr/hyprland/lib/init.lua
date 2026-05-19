require("hyprland.lib.variables")
require("hyprland.lib.keycodes")
HOME = os.getenv("HOME")

function Is_file_exists(name)
   local f = io.open(name, "r")
   if f ~= nil then
      io.close(f)
      return true
   else
      return false
   end
end

function Create_if_not_exists(path)
   if not Is_file_exists(path) then
      os.execute("mkdir -p \"$(dirname \"" .. path .. "\")\"")
      os.execute("echo '-- This file will not be overwritten across dots-hyprland updates.\n-- The file name is for the sake of organization and does not matter\n-- See the corresponding files in ~/.config/hypr/hyprland for examples' > \"" .. path .. "\"")
      return true
   end
   return false
end

if Is_file_exists(HOME .. "/.config/hypr/custom/variables.lua") then
    require("custom.variables")
end

function ScreenshotCommand(mode)
  return AppScreenshot .. " --output " .. ScreenshotFolder .. " -m " .. mode
end

function AppCommand(app, single_instance)
   if single_instance then
     return "pgrep " .. _G["App" .. app] .. " || uwsm app -s a -a " .. app .. " -- " .. _G["App" .. app]
   end
   return "uwsm app -a " .. app .. " -- " .. _G["App" .. app]
end
