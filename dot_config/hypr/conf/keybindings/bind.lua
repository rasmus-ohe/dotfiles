--- Binded keybindings

require("conf.keybindings.global")
require("conf.keybindings.bind_functions")

local settings = "foot -e nvim ~/.config/hypr/"

-- Bindings
BindDsp(
	"XF86Calculator",
	"",
	launchNotify({
		l = "gnome-calculator",
		p = "Calculator",
		i = "accessories-calculator",
	})
)

BindDsp(MainMod, "A", jumpOrLaunch({ l = "de.vito0912.yaabsa", p = "Yaabsa" }))
BindDsp(
	MainModCtrl,
	"A",
	jumpOrLaunch({
		l = "pavucontrol",
		c = "org.pulseaudio.pavucontrol",
		p = "Volume Control",
		i = "org.pulseaudio.pavucontrol",
	})
) -- Audio (device) control

BindDsp(MainMod, "B", launchNotify({ l = "zen-browser", p = "Zen browser", c = "zen" })) -- browser
BindDsp(MainModAlt, "B", launchNotify({ l = "blender" })) -- Blender
BindExec(MainModCtrl, "B", HyprScript("bt-connect-menu")) -- BT Connection menu
BindDsp(
	MainModShift,
	"B",
	launchNotify({
		l = "zen-browser --private-window",
		p = "Zen browser (private)",
		i = "zen-browser",
	})
) -- private browser
BindDsp(MainModCtrlAlt, "B", jumpOrLaunch({ l = "blueman-manager", i = "network-bluetooth" }))
BindExec(MainModCtrlShift, "B", HyprScript("toggle-bluetooth")) -- Toggle Bluetooth

BindDsp(MainMod, "C", launchNotify({ l = "code", i = "vscode" })) -- VSCode
BindDsp(MainModAlt, "C", hl.dsp.cursor.move_to_corner({ corner = 1 })) -- Move cursor to corner
BindExec(MainModCtrl, "C", "swaync-client -C; hyprctl dismissnotify") -- Dismiss all notifications
BindExec(MainModShift, "C", "cliphist list| fuzzel --dmenu| cliphist decode| wl-copy") -- Clipboard view

BindExec(MainMod, "D", "fuzzel") -- fuzzel
BindExec(MainModShift, "D", HyprScript("list-open-apps")) -- List open software in fuzzel
BindDsp(MainModAlt, "D", jumpOrLaunch({ l = "com.discordapp.Discord", c = "discord" })) -- Discord

BindExec(MainMod, "E", "footclient -e neomutt")
BindDsp(MainModAlt, "E", jumpOrLaunch({ l = "betterbird", c = "eu.betterbird.Betterbird" }))
BindExec(MainModShift, "E", HyprScript("emoji-picker", "copy")) -- Emoji picker
BindDsp(
	MainModCtrl,
	"E",
	jumpOrLaunch({
		l = "easyeffects",
		c = "com.github.wwmm.easyeffects",
		p = "EasyEffects",
		i = "com.github.wwmm.easyeffects-symbolic",
	})
) -- EasyEffects

BindDsp(MainMod, "F", launchNotify({ l = "nemo", i = "document-open-folder" }))
BindExec(MainModAlt, "F", "footclient -e yazi") -- Terminal file manager (yazi)
BindExec(MainModShift, "F", [[ footclient sh -c 'sel=$(fzf -e) && printf "%s" "$sel" | wl-copy' ]]) -- Fuzzy search
BindDsp(MainModCtrl, "F", hl.dsp.window.float())

BindDsp(MainMod, "G", hl.dsp.group.toggle()) -- Toggle group
BindDsp(MainModCtrl, "G", hl.dsp.group.lock()) -- Lock group
BindDsp(MainModShift, "G", hl.dsp.group.next()) -- Next window in group

BindDsp(MainMod, "H", hl.dsp.window.pseudo()) -- Window "hover"-mode

BindExec(MainMod, "I", settings) -- Settings (nvim)
BindExec(MainModAlt, "I", "code ~/.config/hypr/") -- Settings (code)
BindExec(MainModCtrl, "I", HyprScript("change-audio-input")) -- Change input audio device

BindDsp(MainMod, "J", hl.dsp.layout("togglesplit")) -- Toggles the split (top/side)
BindDsp(MainModCtrl, "J", hl.dsp.layout("swapsplit")) -- Swaps the two halves of the split

BindDsp(
	MainMod,
	"K",
	jumpOrLaunch({
		l = "pass show keepassxc/passwords-master | keepassxc --pw-stdin --keyfile ~/.config/keepassxc/Passwords.keyx ~/keepassxc/Passwords.kdbx",
		c = "org.keepassxc.KeePassXC",
		p = "KeePassXC",
		i = "keepassxc",
	})
)

BindExec(MainMod, "L", "nwg-icon-picker | tr -d '\n' | wl-copy")
BindExec(MainModShift, "L", HyprScript("lenny-picker")) -- Lenny picker (fuzzel)

BindDsp(MainMod, "M", jumpOrLaunch({ l = "feishin" })) -- Feishin (music player)
BindDsp(MainModAlt, "M", jumpOrLaunch({ l = "spotify", c = "Spotify" })) -- Spotify
-- BindExec(MainModAlt, "M", jumpOrLaunch({ l = "footclient --app-id=rmpc --title=rmpc -e rmpc", c = "rmpc", i = "emblem-music-symbolic" }))
BindExec(MainModCtrl, "M", "toggle-mic-mute") -- Toggle (default) mic mute status
BindDsp(
	MainModShift,
	"M",
	jumpOrLaunch({
		l = "beeper",
		c = "Beeper",
		i = "beepertexts",
	})
) -- Beeper
BindExec(MainModCtrlShift, "M", "toggle-mouse-hold")

BindDsp(MainMod, "N", jumpOrLaunch({ l = "obsidian", c = "md.obsidian.Obsidian" }))
BindExec(MainModCtrl, "N", "swaync-client -t") -- Toggle the notification panel
BindExec(MainModShift, "N", HyprScript("current-player-notify"))

BindExec(
	MainMod,
	"O",
	NotifyCmd({
		title = "󰥔 Current Time",
		body = "$(date '+%H:%M:%S - %A - %d/%m/%Y')",
		sync = "date_time",
		timeout = 4000,
	})
)
BindExec(MainModCtrl, "O", HyprScript("change-audio-output")) -- Change output audio device
BindExec(MainModCtrlAlt, "O", HyprScript("change-easyeffect-output-preset"))
BindExec(MainModShift, "O", batteryStatusNotif()) -- Battery of laptop battery
BindExec(MainModAltShift, "O", HyprScript("device-battery-status")) -- Battery of all devices

BindExec(MainMod, "P", 'hyprpicker -a -q && notify-send "󰏘 Color copied to clipboard"') -- Color picker
BindExec(MainModCtrl, "P", HyprScript("power-profile-picker")) -- Power profile picker
-- BindExec(MainModShift, "P", HyprScript("mpc-queue-picker")) -- Clear queue, and set playlist in new queue
BindExec(MainModCtrlAlt, "P", HyprScript("ratbag-profile-switcher")) -- Change Logitech mouse profile

BindDsp(MainMod, "Q", hl.dsp.window.close()) -- Kill active window
BindDsp(MainModShift, "Q", hl.dsp.window.kill()) -- Kill all similar windows to the active

-- BindExec(MainMod, "R", HyprScript("rmpc-rate-song")) -- Rate current rmpc song
BindExec(MainModCtrlShift, "R", "hyprctl reload") -- Reload Hyprland

-- BindExec(MainMod, "S", "hyprctl dispatch exec [workspace special] foot -e btop") -- System monitor
BindDsp(MainMod, "S", hl.dsp.exec_cmd([[ footclient --title "btop-monitor" -e btop]]))
BindDsp(MainModAlt, "S", hl.dsp.workspace.toggle_special("magic")) -- Toggle special workspace
BindExec(MainModCtrl, "S", HyprScript("toggle-hyprshade")) -- Toggle hyprshade
BindExec(MainModShift, "S", "footclient -e ncdu") -- Disk usage analyzer
BindExec(MainModCtrlAlt, "S", "hyprshade on grayscale") -- Grayscale mode

BindExec(MainMod, "T", "footclient") -- Terminal
BindExec(MainModCtrl, "T", HyprScript("toggle-touchpad")) -- Toggle touchpad
BindDsp(
	MainModShift,
	"T",
	launchNotify({
		l = "nemo trash://",
		p = "Trash",
		i = "albumfolder-user-trash-symbolic",
	})
) -- Trash

BindExec(MainModCtrl, "V", HyprScript("vpn-menu")) -- Fuzzel VPN menu

-- BindExec(MainMod, "W", HyprScript("go-to-last-used-workspace")) -- Go to last used app
BindDsp(MainMod, "W", goToLastUsedWorkspace())
BindDsp(MainModCtrl, "W", notifyCurrentWorkspace()) -- Notify the current workspace id
BindExec(MainModShift, "W", HyprScript("list-last-used-apps")) -- List last used apps in fuzzel
BindExec(MainModCtrlShift, "W", HyprScript("hold-key"))

BindExec(MainMod, "Y", "footclient -e chroncal")
-- TODO: List todays events in fuzzel

BindDsp(MainMod, "Z", function()
	local ZOOM_LEVEL = 2.5
	local MIN_ZOOM = 1
	local current_zoom = hl.get_config("cursor.zoom_factor")
	local target = current_zoom == MIN_ZOOM and ZOOM_LEVEL or MIN_ZOOM
	hl.config({ cursor = { zoom_factor = target } })
end)
