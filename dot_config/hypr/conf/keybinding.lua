local mainMod = "SUPER + "
local mainModShift = "SUPER + SHIFT + "
local mainModCtrl = "SUPER + CTRL + "
local mainModAlt = "SUPER + ALT + "
local mainModAltShift = "SUPER + ALT + SHIFT + "
local mainModCtrlShift = "SUPER + CTRL + SHIFT + "
local mainModCtrlAlt = "SUPER + CTRL + ALT + "

local newTerminal = "footclient -e"
local newTerminalHold = "footclient -e --hold"
-- $specialExec: launch into the special workspace via exec rules
local function specialExec(cmd)
	return hl.dsp.exec_cmd(cmd, { workspace = "special" })
end

-- Shorthand aliases
local exec = hl.dsp.exec_cmd
local rep = { repeating = true }
local lock = { locked = true }

-- Applications
local terminal = "foot"
local settings = "foot -e nvim ~/.config/hypr/"
local fileManager = "nemo"
local menu = "fuzzel"
local calculator = "gnome-calculator"
local browser = "zen-browser"
local browser_private = "zen-browser --private-window"
local discord = "com.discordapp.Discord"

------------------------
--- App / Misc binds ---
------------------------

hl.bind("XF86Calculator", exec(calculator))
hl.bind(mainMod .. "Escape", exec("~/.config/hypr/scripts/hypr-blank.sh && notify-send 'Escaped'")) -- Moves all monitors to a blank screen
hl.bind(
	mainModCtrl .. "A",
	exec(
		"~/.config/hypr/scripts/jump-or-launch-app.sh -l pavucontrol -c org.pulseaudio.pavucontrol -p 'Volume Control' -i 󰕾"
	)
) -- Audio (device) control
hl.bind(mainMod .. "B", exec(browser)) -- zen
hl.bind(mainModAlt .. "B", exec("blender")) -- Blender
hl.bind(mainModCtrl .. "B", exec("~/.config/hypr/scripts/bt-connect-menu.sh")) -- BT Connection menu
hl.bind(mainModShift .. "B", exec(browser_private)) -- zen (private window)
hl.bind(
	mainModCtrlAlt .. "B",
	exec("~/.config/hypr/scripts/jump-or-launch-app.sh -l blueman-manager -p 'Bluetooth manager' -i 󰂯")
)
hl.bind(mainModCtrlShift .. "B", exec("~/.config/hypr/scripts/toggle-bluetooth.sh")) -- Toggle Bluetooth
hl.bind(mainMod .. "C", exec("code")) -- VSCode
-- hl.bind(mainModAlt .. "C", hl.dsp.mouse.cursor_to_corner(1)) -- Move cursor to corner (1: bottom right)
hl.bind(mainModCtrl .. "C", exec("swaync-client -C")) -- Close all notifications
hl.bind(mainModShift .. "C", exec("cliphist list | fuzzel --dmenu | cliphist decode | wl-copy")) -- Clipboard view
hl.bind(mainMod .. "D", exec(menu)) -- fuzzel
hl.bind(mainModShift .. "D", exec("~/.config/hypr/scripts/list-open-apps.sh")) -- List open software in fuzzel
hl.bind(
	mainModAlt .. "D",
	exec("~/.config/hypr/scripts/jump-or-launch-app.sh -l " .. discord .. " -c 'discord' -i 󰙯")
) -- Discord
hl.bind(
	mainMod .. "E",
	exec(
		"~/.config/hypr/scripts/jump-or-launch-app.sh -l betterbird -c eu.betterbird.Betterbird -p 'Betterbird' -i 󰇮"
	)
) -- Email client
hl.bind(mainModShift .. "E", exec("~/.config/hypr/scripts/emoji-picker.sh copy")) -- Emoji picker
hl.bind(mainMod .. "F", exec(fileManager))
hl.bind(mainModAlt .. "F", exec(newTerminal .. " yazi")) -- Terminal file manager (yazi)
hl.bind(mainModShift .. "F", exec(newTerminal .. " fzf -e")) -- Fuzzy search
hl.bind(mainModCtrl .. "F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. "H", hl.dsp.window.pseudo()) -- Window "hover"-mode
hl.bind(mainMod .. "I", exec(settings)) -- Settings (nvim)
hl.bind(mainModAlt .. "I", exec("code ~/.config/hypr/")) -- Settings (code)
hl.bind(mainMod .. "J", hl.dsp.layout("togglesplit")) -- Toggles the split (top/side)
hl.bind(mainModCtrl .. "J", hl.dsp.layout("swapsplit")) -- Swaps the two halves of the split
hl.bind(
	mainMod .. "L",
	exec("~/.config/hypr/scripts/jump-or-launch-app.sh -l 'net.corluma.Corluma' -c 'corluma' -i 󰌵")
) -- Control HUE lights
hl.bind(mainModShift .. "L", exec("/home/rasmus/.config/hypr/scripts/lenny-picker.sh")) -- Lenny picker (fuzzel)
hl.bind(mainMod .. "M", exec("~/.config/hypr/scripts/jump-or-launch-app.sh -l 'spotify' -c 'Spotify' -i 󰓇")) -- Spotify
hl.bind(mainModCtrl .. "M", exec("toggle-mic-mute")) -- Toggle (default) mic mute status
hl.bind(
	mainModShift .. "M",
	exec("~/.config/hypr/scripts/jump-or-launch-app.sh -c BeeperTexts -l beeper -p Beeper -i '󰍡'")
) -- Beeper (messaging app)
hl.bind(mainModCtrlShift .. "M", exec("~/.config/hypr/scripts/toggle-mouse-hold.sh"))
hl.bind(mainMod .. "N", exec("~/.config/hypr/scripts/jump-or-launch-app.sh -l 'obsidian' -i 󰎞"))
hl.bind(mainModCtrl .. "N", exec("swaync-client -t")) -- Toggle the notification panel
hl.bind(
	mainMod .. "O",
	exec(
		"notify-send -t 4000 -h string:synchronous:date_time '󰥔 Current Time' \"$(date '+%H:%M:%S - %A - %d/%m/%Y')\""
	)
)
hl.bind(mainModShift .. "O", exec("~/.config/hypr/scripts/battery-status-notify.sh")) -- Battery of laptop battery
hl.bind(mainModAltShift .. "O", exec("~/.config/hypr/scripts/device-battery-status.sh")) -- Battery of all devices
hl.bind(mainModShift .. "P", exec("~/.config/hypr/scripts/ratbag-profile-switcher.sh")) -- Change Logitech mouse profile
hl.bind(mainMod .. "Q", hl.dsp.window.kill()) -- Kill active window
hl.bind(mainModShift .. "Q", exec("hyprctl dispatch forcekillactive")) -- Kill all similar windows to the active
hl.bind(mainModCtrlShift .. "R", exec("hyprctl reload")) -- Reload Hyprland
hl.bind(mainMod .. "S", specialExec("btop")) -- System monitor
hl.bind(mainModAlt .. "S", hl.dsp.workspace.toggle_special())
hl.bind(mainModShift .. "S", exec(newTerminal .. " ncdu")) -- Disk usage analyzer
hl.bind(mainMod .. "T", exec(terminal)) -- Terminal
hl.bind(mainModShift .. "T", exec(fileManager .. " trash://")) -- Trash
hl.bind(
	mainMod .. "U",
	specialExec(
		"script -q -O /tmp/system-update-$(date +%Y%m%d-%H%M%S).log -c ~/.config/hypr/scripts/system-update.sh >/dev/null 2>&1"
	)
) -- Update system
hl.bind(
	mainModAlt .. "U",
	specialExec(
		"script -q -O /tmp/system-alt-update-$(date +%Y%m%d-%H%M%S).log -c ~/.config/hypr/scripts/system-alt-update.sh >/dev/null 2>&1"
	)
) -- Other system updates
hl.bind(mainModCtrl .. "V", exec("~/.config/hypr/scripts/vpn-menu.sh")) -- Fuzzel VPN menu
hl.bind(mainMod .. "W", exec("~/.config/hypr/scripts/go-to-last-used-workspace.sh")) -- Go to last used app
hl.bind(
	mainModCtrl .. "W",
	exec(
		'notify-send -h string:synchronous:workspace \'󰍹 Workspace: $(hyprctl monitors -j | jq -r ".[] | select(.focused == true) | if .specialWorkspace.id == -99 then \\"Special\\" else .activeWorkspace.id end")\''
	)
) -- Notify current workspace id
hl.bind(mainModShift .. "W", exec("~/.config/hypr/scripts/list-last-used-apps.sh")) -- List last used apps in fuzzel
hl.bind(mainModCtrlShift .. "W", exec("~/.config/hypr/scripts/hold-key.sh"))
