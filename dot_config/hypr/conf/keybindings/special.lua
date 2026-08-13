--- Special keybindings

require("conf.keybindings.global")


-- Power management
local CtrlAltShift = "CTRL+ALT+SHIFT"

-- Suspend
BindExec(CtrlAltShift, "F2", "playerctl -a pause &> /dev/null || systemctl suspend && hyprlock --no-fade-in -q")

-- Reboot
BindExec(CtrlAltShift, "F3", "systemctl reboot")

-- Poweroff
BindExec(CtrlAltShift, "F4", "systemctl poweroff")

-- Airplane mode notification
local function airplaneModeNotify(status, icon)
    return NotifyCmd({ sync = "airplane-mode", title = icon .. " Airplane mode: " .. status })
end
BindExec("", "XF86RFKill",
    "rfkill list all | grep -q \"Soft blocked: no\" && " ..
    airplaneModeNotify("Off", "󰀞") .. " || " .. airplaneModeNotify("On", "󰀝"), { locked = true })
