--- Power keybindings

require("conf.keybindings.global")

local CtrlAltShift = "CTRL+ALT+SHIFT"

-- Suspend
BindExec(CtrlAltShift, "F2", "playerctl -a pause &> /dev/null || systemctl suspend && hyprlock --no-fade-in -q")

-- Reboot
BindExec(CtrlAltShift, "F3", "systemctl reboot")

-- Poweroff
BindExec(CtrlAltShift, "F4", "systemctl poweroff")

-- Airplane mode notification
BindExec("", "XF86RFKill", HyprScript("airplane-mode-notify"), { locked = true })
