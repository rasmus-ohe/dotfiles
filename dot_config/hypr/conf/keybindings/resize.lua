--- Resize keybindings

require("conf.keybindings.global")

-- Resize windows
local function resizeWindow(direction, x, y)
    BindDsp(MainModCtrl, direction, hl.dsp.window.resize({ x = x, y = y, relative = true }), { repeating = true })
end

resizeWindow("left", -30, 0)
resizeWindow("right", 30, 0)
resizeWindow("up", 0, -30)
resizeWindow("down", 0, 30)

-- Move and resize with mouse
BindDsp(MainMod, "mouse:272", hl.dsp.window.drag(), { mouse = true })   -- LMB
BindDsp(MainMod, "mouse:273", hl.dsp.window.resize(), { mouse = true }) -- RMB
