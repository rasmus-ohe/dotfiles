--- Screenshot keybindings

require("conf.keybindings.global")

local function bindScreenshot(mod, key, cmd, type)
    BindExec(mod, key, "hyprshot -z  -o ~/Pictures/Screenshots " ..
        cmd .. " -f $(date +'%Y_%m_%d_%H%M%S')_hyprshot_" .. type .. ".png")
end

-- Screenshot the active window
bindScreenshot("", "PRINT", "-m region -m active -m window", "window")

-- Screenshot selected area
bindScreenshot("CTRL", "PRINT", "-m region", "region")

-- Screenshot whole monitor
bindScreenshot(MainMod, "PRINT", "-m output", "monitor")
