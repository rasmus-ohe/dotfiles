-------------------------
-- SOURCE OTHER FILES --
-------------------------

require("monitors")
require("workspaces")

for _, filename in pairs({
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
