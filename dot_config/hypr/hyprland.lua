-------------------------
-- SOURCE OTHER FILES --
-------------------------

require("monitors")
require("workspaces")

for _, filename in pairs({
    "dynamic_workspaces",
    "env",
    "keybindings.keybindings",
    "startup",
    "window_rules",
    "input_devices",
    "look_and_feel",
    "plugins",
    "shutdown",
}) do
    require("conf." .. filename)
end

-- Added by hyprmoncfg: its generated monitor rules load last, so nothing before this can override the applied layout.
do local path = os.getenv("HOME") .. "/.config/hypr/hyprmoncfg-monitors.lua"; local file = io.open(path, "r"); if file then file:close(); dofile(path) end end
