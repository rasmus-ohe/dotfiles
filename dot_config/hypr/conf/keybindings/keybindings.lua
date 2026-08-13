for _, filename in pairs({
    "bind",
    "brightness",
    "focus",
    "media",
    "special",
    "resize",
    "screenshot",
}) do
    require("conf.keybindings." .. filename)
end
