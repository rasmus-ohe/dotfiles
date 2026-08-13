for _, filename in pairs({
    "bind",
    "brightness",
    "focus",
    "media",
    "power",
    "resize",
    "screenshot",
}) do
    require("conf.keybindings." .. filename)
end
