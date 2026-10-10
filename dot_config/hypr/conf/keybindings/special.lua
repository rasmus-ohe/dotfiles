--- Special keybindings

require("conf.keybindings.global")

-- Power management
local CtrlAltShift = "CTRL+ALT+SHIFT"

local function hyprshutdown(title, post_cmd)
	return "hyprshutdown --top-label '" .. title .. "' --post-cmd '" .. post_cmd .. "'"
end

-- Suspend
BindExec(CtrlAltShift, "F2", "loginctl lock-session")

-- Reboot
BindExec(CtrlAltShift, "F3", hyprshutdown("Rebooting...", "systemctl reboot"))

-- Poweroff
BindExec(CtrlAltShift, "F4", hyprshutdown("Powering off...", "shutdown -P 0"))

-- Airplane mode notification
local function airplaneModeNotify(status, icon)
	return NotifyCmd({ sync = "airplane-mode", title = icon .. " Airplane mode: " .. status })
end
BindExec(
	"",
	"XF86RFKill",
	'rfkill list all | grep -q "Soft blocked: no" && '
		.. airplaneModeNotify("Off", "󰀞")
		.. " || "
		.. airplaneModeNotify("On", "󰀝"),
	{ locked = true }
)

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

	ExecNofityCmd({ title = "󰜎 Escaped" })
end)

--- Laptop lid
-- local function controlLaptopScreen(action)
--     hl.dsp.dpms({ action = action, monitor = "eDP-1" })
-- end

local function handleLidClosed()
	local monitors = hl.get_monitors()
	local eDP1_monitor = hl.get_monitor("eDP-1")

	if eDP1_monitor == nil then
		ExecNofityCmd({ title = "Lid closed", body = "Monitor not found", timeout = 10000 })
		return
	end

	-- Check if more than one
	if #monitors > 1 then
		-- Disable "eDP-1"
		hl.monitor({ output = "eDP-1", disabled = true })
		ExecNofityCmd({ title = "Lid closed", body = "Monitor disabled", timeout = 10000 })
	else
		-- TODO: Put to sleep
	end
end

local function handleLidOpen()
	-- Check if monitor is enabled
	if hl.get_monitor("eDP-1") == nil then
		-- Enable "eDP-1"
		hl.monitor({ output = "eDP-1", disabled = false })
		HyprReload()
		ExecNofityCmd({ title = "Lid open", body = "Monitor enabled", timeout = 10000 })
	end
end

-- BindDsp("", "switch:on:Lid Switch", function()
-- 	handleLidClosed()
-- end)
-- BindDsp("", "switch:off:Lid Switch", function()
-- 	handleLidOpen()
-- end)

local function tempDebug()
	hl.exec_cmd("beeper", { workspace = "1 silent" })

	-- ExecNofityCmd({ title = "Debug", body = TwoDecimalPlaces(eDP1_monitor.scale), timeout = 10000 })
end

BindDsp(MainMod, "A", function()
	tempDebug()
end)
