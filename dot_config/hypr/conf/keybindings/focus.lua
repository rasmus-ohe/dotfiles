--- Focus keybindings

require("conf.keybindings.global")


-- Focus workspace
local function focusWorkspace(key, workspace)
    BindDsp(MainMod, key, hl.dsp.focus({ workspace = workspace }))
end

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
local function moveWindowToWorkspace(key, workspace)
    BindDsp(MainModShift, key, hl.dsp.window.move({ workspace = workspace }))
end

-- Move whole workspace to another workspace
local function moveWholeWorkspace(key, workspace)
    BindDsp(
        MainModCtrlShift,
        key,
        -- TODO: Luaficate shell file
        hl.dsp.exec_cmd("~/.config/hypr/scripts/move-workspace-to-workspace.sh " .. workspace)
    )
end

-- Loop add bindings
for i = 1, 10, 1 do
    local key = (i == 10) and "0" or tostring(i)
    focusWorkspace(key, i)
    moveWindowToWorkspace(key, i)
    moveWholeWorkspace(key, i)
end

-- Move focus with mainMod + arrow keys
local function focusDirection(direction)
    BindDsp(MainMod, direction, hl.dsp.focus({ direction = direction }))
end

-- Move window in direction
local function moveWindowDirection(direction)
    BindDsp(MainModShift, direction, hl.dsp.window.move({ direction = direction }))
end

for _, direction in ipairs({ "left", "right", "up", "down" }) do
    focusDirection(direction)
    moveWindowDirection(direction)
end

-- Scroll through existing workspaces
-- TODO: Notif what workspace is selected
-- TODO: Notif if no workspaces available
BindDsp(MainMod, "mouse_down", hl.dsp.focus({ workspace = "e+1" }))
BindDsp(MainMod, "mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Swipe workspaces
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    ---@diagnostic disable-next-line: assign-type-mismatch
    action = "workspace"
})
