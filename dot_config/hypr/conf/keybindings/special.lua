--- Special keybindings

require("conf.keybindings.global")


-- Power management
local CtrlAltShift = "CTRL+ALT+SHIFT"

-- Suspend
BindExec(CtrlAltShift, "F2", "playerctl -a pause &> /dev/null || systemctl suspend && hyprlock --no-fade-in -q")

-- Reboot
BindExec(CtrlAltShift, "F3", "systemctl reboot")

-- Poweroff
BindExec(CtrlAltShift, "F4", "hyprshutdown")

-- Airplane mode notification
local function airplaneModeNotify(status, icon)
    return NotifyCmd({ sync = "airplane-mode", title = icon .. " Airplane mode: " .. status })
end
BindExec("", "XF86RFKill",
    "rfkill list all | grep -q \"Soft blocked: no\" && " ..
    airplaneModeNotify("Off", "󰀞") .. " || " .. airplaneModeNotify("On", "󰀝"), { locked = true })

--- Escape mode
BindDsp(MainMod, "Escape", function()
    -- Get all monitors
    local monitors = hl.get_monitors()

    for indx, monitor in ipairs(monitors) do
        -- Focus monitor
        hl.dispatch(hl.dsp.focus({ monitor = monitor.name }))
        -- Set monitor to workspace 99+index
        hl.dispatch(hl.dsp.focus({ workspace = 99 + indx }))
    end

    hl.exec_cmd(NotifyCmd({ title = "󰜎 Escaped", body = "Monitors: " .. #monitors }))
end)

--- Laptop lid
-- local function controlLaptopScreen(action)
--     hl.dsp.dpms({ action = action, monitor = "eDP-1" })
-- end

BindDsp("", "switch:on:Lid Switch", hl.dsp.dpms({ action = "disabled", monitor = "eDP-1" }))
BindDsp("", "switch:off:Lid Switch", hl.dsp.dpms({ action = "enabled", monitor = "eDP-1" }))
