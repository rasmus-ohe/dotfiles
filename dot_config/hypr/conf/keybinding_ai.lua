-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local mainMod          = "SUPER"
local mainModShift     = "SUPER + SHIFT"
local mainModCtrl      = "SUPER + CTRL"
local mainModAlt       = "SUPER + ALT"
local mainModAltShift  = "SUPER + ALT + SHIFT"
local mainModCtrlShift = "SUPER + CTRL + SHIFT"
local mainModCtrlAlt   = "SUPER + CTRL + ALT"

local newTerminal      = "footclient -e"
local newTerminalHold  = "footclient -e --hold"
-- $specialExec: launch into the special workspace via exec rules
local function specialExec(cmd)
    return hl.dsp.exec_cmd(cmd, { workspace = "special" })
end

-- Shorthand aliases
local exec            = hl.dsp.exec_cmd
local rep             = { repeating = true }
local lock            = { locked = true }

-- Applications
local terminal        = "foot"
local settings        = "foot -e nvim ~/.config/hypr/"
local fileManager     = "nemo"
local menu            = "fuzzel"
local calculator      = "gnome-calculator"
local browser         = "zen-browser"
local browser_private = "zen-browser --private-window"
local discord         = "com.discordapp.Discord"

-- ── App / misc binds ────────────────────────────────────────────────

hl.bind("XF86Calculator", exec(calculator))
hl.bind(mainMod .. " + Escape", exec("~/.config/hypr/scripts/hypr-blank.sh && notify-send 'Escaped'")) -- Moves all monitors to a blank screen
hl.bind(mainModCtrl .. " + A",
    exec(
        "~/.config/hypr/scripts/jump-or-launch-app.sh -l pavucontrol -c org.pulseaudio.pavucontrol -p 'Volume Control' -i 󰕾")) -- Audio (device) control
hl.bind(mainMod .. " + B", exec(browser)) -- zen
hl.bind(mainModAlt .. " + B", exec("blender")) -- Blender
hl.bind(mainModCtrl .. " + B", exec("~/.config/hypr/scripts/bt-connect-menu.sh")) -- BT Connection menu
hl.bind(mainModShift .. " + B", exec(browser_private)) -- zen (private window)
hl.bind(mainModCtrlAlt .. " + B",
    exec("~/.config/hypr/scripts/jump-or-launch-app.sh -l blueman-manager -p 'Bluetooth manager' -i 󰂯"))
hl.bind(mainModCtrlShift .. " + B", exec("~/.config/hypr/scripts/toggle-bluetooth.sh")) -- Toggle Bluetooth
hl.bind(mainMod .. " + C", exec("code")) -- VSCode
hl.bind(mainModAlt .. " + C", hl.dsp.mouse.cursor_to_corner(1)) -- Move cursor to corner (1: bottom right)
hl.bind(mainModCtrl .. " + C", exec("swaync-client -C")) -- Close all notifications
hl.bind(mainModShift .. " + C", exec("cliphist list | fuzzel --dmenu | cliphist decode | wl-copy")) -- Clipboard view
hl.bind(mainMod .. " + D", exec(menu)) -- fuzzel
hl.bind(mainModShift .. " + D", exec("~/.config/hypr/scripts/list-open-apps.sh")) -- List open software in fuzzel
hl.bind(mainModAlt .. " + D", exec("~/.config/hypr/scripts/jump-or-launch-app.sh -l " .. discord .. " -c 'discord' -i 󰙯")) -- Discord
hl.bind(mainMod .. " + E",
    exec("~/.config/hypr/scripts/jump-or-launch-app.sh -l betterbird -c eu.betterbird.Betterbird -p 'Betterbird' -i 󰇮")) -- Email client
hl.bind(mainModShift .. " + E", exec("~/.config/hypr/scripts/emoji-picker.sh copy")) -- Emoji picker
hl.bind(mainMod .. " + F", exec(fileManager))
hl.bind(mainModAlt .. " + F", exec(newTerminal .. " yazi")) -- Terminal file manager (yazi)
hl.bind(mainModShift .. " + F", exec(newTerminal .. " fzf -e")) -- Fuzzy search
hl.bind(mainModCtrl .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + H", hl.dsp.window.pseudo()) -- Window "hover"-mode
hl.bind(mainMod .. " + I", exec(settings)) -- Settings (nvim)
hl.bind(mainModAlt .. " + I", exec("code ~/.config/hypr/")) -- Settings (code)
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- Toggles the split (top/side)
hl.bind(mainModCtrl .. " + J", hl.dsp.layout("swapsplit")) -- Swaps the two halves of the split
hl.bind(mainMod .. " + L",
    exec("~/.config/hypr/scripts/jump-or-launch-app.sh -l 'net.corluma.Corluma' -c 'corluma' -i 󰌵")) -- Control HUE lights
hl.bind(mainModShift .. " + L", exec("/home/rasmus/.config/hypr/scripts/lenny-picker.sh")) -- Lenny picker (fuzzel)
hl.bind(mainMod .. " + M", exec("~/.config/hypr/scripts/jump-or-launch-app.sh -l 'spotify' -c 'Spotify' -i 󰓇")) -- Spotify
hl.bind(mainModCtrl .. " + M", exec("toggle-mic-mute")) -- Toggle (default) mic mute status
hl.bind(mainModShift .. " + M",
    exec("~/.config/hypr/scripts/jump-or-launch-app.sh -c BeeperTexts -l beeper -p Beeper -i '󰍡'")) -- Beeper (messaging app)
hl.bind(mainModCtrlShift .. " + M", exec("~/.config/hypr/scripts/toggle-mouse-hold.sh"))
hl.bind(mainMod .. " + N", exec("~/.config/hypr/scripts/jump-or-launch-app.sh -l 'obsidian' -i 󰎞"))
hl.bind(mainModCtrl .. " + N", exec("swaync-client -t")) -- Toggle the notification panel
hl.bind(mainMod .. " + O",
    exec("notify-send -t 4000 -h string:synchronous:date_time '󰥔 Current Time' \"$(date '+%H:%M:%S - %A - %d/%m/%Y')\""))
hl.bind(mainModShift .. " + O", exec("~/.config/hypr/scripts/battery-status-notify.sh"))    -- Battery of laptop battery
hl.bind(mainModAltShift .. " + O", exec("~/.config/hypr/scripts/device-battery-status.sh")) -- Battery of all devices
hl.bind(mainModShift .. " + P", exec("~/.config/hypr/scripts/ratbag-profile-switcher.sh"))  -- Change Logitech mouse profile
hl.bind(mainMod .. " + Q", hl.dsp.window.kill())                                            -- Kill active window
hl.bind(mainModShift .. " + Q", exec("hyprctl dispatch forcekillactive"))                   -- Kill all similar windows to the active
hl.bind(mainModCtrlShift .. " + R", exec("hyprctl reload"))                                 -- Reload Hyprland
hl.bind(mainMod .. " + S", specialExec("btop"))                                             -- System monitor
hl.bind(mainModAlt .. " + S", hl.dsp.workspace.toggle_special())
hl.bind(mainModShift .. " + S", exec(newTerminal .. " ncdu"))                               -- Disk usage analyzer
hl.bind(mainMod .. " + T", exec("footclient"))                                              -- Terminal
hl.bind(mainModShift .. " + T", exec(fileManager .. " trash://"))                           -- Trash
hl.bind(mainMod .. " + U",
    specialExec(
        "script -q -O /tmp/system-update-$(date +%Y%m%d-%H%M%S).log -c ~/.config/hypr/scripts/system-update.sh >/dev/null 2>&1")) -- Update system
hl.bind(mainModAlt .. " + U",
    specialExec(
        "script -q -O /tmp/system-alt-update-$(date +%Y%m%d-%H%M%S).log -c ~/.config/hypr/scripts/system-alt-update.sh >/dev/null 2>&1")) -- Other system updates
hl.bind(mainModCtrl .. " + V", exec("~/.config/hypr/scripts/vpn-menu.sh"))                                                                -- Fuzzel VPN menu
hl.bind(mainMod .. " + W", exec("~/.config/hypr/scripts/go-to-last-used-workspace.sh"))                                                   -- Go to last used app
hl.bind(mainModCtrl .. " + W",
    exec(
        "notify-send -h string:synchronous:workspace '󰍹 Workspace: $(hyprctl monitors -j | jq -r \".[] | select(.focused == true) | if .specialWorkspace.id == -99 then \\\"Special\\\" else .activeWorkspace.id end\")'")) -- Notify current workspace id
hl.bind(mainModShift .. " + W", exec("~/.config/hypr/scripts/list-last-used-apps.sh")) -- List last used apps in fuzzel
hl.bind(mainModCtrlShift .. " + W", exec("~/.config/hypr/scripts/hold-key.sh"))


-- ── Focus (arrow keys) ──────────────────────────────────────────────

hl.bind(mainMod .. " + left", hl.dsp.window.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.window.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.window.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.window.focus({ direction = "d" }))


-- ── Move window / group (arrow keys) ────────────────────────────────

hl.bind(mainModShift .. " + left", hl.dsp.window.move_or_group({ direction = "l" }))
hl.bind(mainModShift .. " + right", hl.dsp.window.move_or_group({ direction = "r" }))
hl.bind(mainModShift .. " + up", hl.dsp.window.move_or_group({ direction = "u" }))
hl.bind(mainModShift .. " + down", hl.dsp.window.move_or_group({ direction = "d" }))


-- ── Workspaces ───────────────────────────────────────────────────────

for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.workspace.change(tostring(i)))
    hl.bind(mainModShift .. " + " .. i, hl.dsp.window.move({ workspace = tostring(i) }))
    hl.bind(mainModCtrlShift .. " + " .. i, exec("~/.config/hypr/scripts/move-workspace-to-workspace.sh " .. i))
end
hl.bind(mainMod .. " + 0", hl.dsp.workspace.change("10"))
hl.bind(mainModShift .. " + 0", hl.dsp.window.move({ workspace = "10" }))
hl.bind(mainModCtrlShift .. " + 0", exec("~/.config/hypr/scripts/move-workspace-to-workspace.sh 10"))


-- ── Groups ───────────────────────────────────────────────────────────

hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainModShift .. " + G", hl.dsp.group.change_active("f"))
hl.bind(mainModCtrl .. " + G", hl.dsp.group.lock("toggle"))


-- ── Workspace scroll (mouse wheel) ──────────────────────────────────

hl.bind(mainMod .. " + mouse_down", hl.dsp.workspace.change("e+1"))
hl.bind(mainMod .. " + mouse_up", hl.dsp.workspace.change("e-1"))


-- ── Move / resize windows with mouse ────────────────────────────────

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.move(), { mouse = true })   -- LMB drag: move
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- RMB drag: resize


-- ── Resize windows (arrow keys) ─────────────────────────────────────

hl.bind(mainModCtrl .. " + left", hl.dsp.window.resize("-30 0"), rep)
hl.bind(mainModCtrl .. " + right", hl.dsp.window.resize("30 0"), rep)
hl.bind(mainModCtrl .. " + up", hl.dsp.window.resize("0 -30"), rep)
hl.bind(mainModCtrl .. " + down", hl.dsp.window.resize("0 30"), rep)


-- ── Misc hardware ────────────────────────────────────────────────────

hl.bind("XF86RFKill", exec("airplane-mode-notify"))     -- Airplane mode notification
hl.bind(mainModCtrl .. " + T", exec("toggle-touchpad")) -- Toggle touchpad


-- ── Power ────────────────────────────────────────────────────────────

hl.bind("CTRL + ALT + SHIFT + F2",
    exec("playerctl -a pause &> /dev/null || systemctl suspend && hyprlock --no-fade-in -q")) -- suspend
hl.bind("CTRL + ALT + SHIFT + F3", exec("systemctl reboot"))                                  -- reboot
hl.bind("CTRL + ALT + SHIFT + F4", exec("systemctl poweroff"))                                -- poweroff


-- ── Hyprland / Screenshots ───────────────────────────────────────────

local screenshot_dir = "~/Pictures/Screenshots"

hl.bind("PRINT",
    exec("hyprshot -z -m region -m active -m window -o " ..
        screenshot_dir .. " -f \"$(date +'%Y_%m_%d_%H%M%S')_hyprshot_window.png\""))                                   -- Active window
hl.bind("CTRL + PRINT",
    exec("hyprshot -m region -z -o " .. screenshot_dir .. " -f \"$(date +'%Y_%m_%d_%H%M%S')_hyprshot_region.png\""))   -- Selected area
hl.bind(mainMod .. " + PRINT",
    exec("hyprshot -m output -z -o " .. screenshot_dir .. " -f \"$(date +'%Y_%m_%d_%H%M%S')_hyprshot_monitor.png\""))  -- Whole monitor
-- hl.bind(mainMod .. " + TAB",         hl.dsp.exec_cmd("hyprexpo:expo toggle"))  -- Hyprspace (commented out)
hl.bind(mainModCtrl .. " + S", exec("toggle-hyprshade"))                                                               -- Toggle hyprshade
hl.bind(mainModCtrlAlt .. " + S", exec("hyprshade on grayscale"))                                                      -- Enable grayscale filter
hl.bind(mainMod .. " + Z", exec("hypr-zoom -easing=OutQuart -easingOut=OutQuart -duration=200 -steps=50 -interp=log")) -- Zoom tool
hl.bind(mainMod .. " + P", exec("hyprpicker -a -q && notify-send '󰏘 Color copied to clipboard'"))


-- ── Brightness ───────────────────────────────────────────────────────

local brightness_notify =
    "awk -v cur=\"$(brightnessctl get)\" -v max=\"$(brightnessctl max)\" " ..
    "'BEGIN { printf(\"%.0f\\n\", cur/max*100) }' | " ..
    "xargs -I{} notify-send -h int:value:{} -h string:synchronous:volume '󰍹 Brightness: {}%'"

hl.bind("XF86MonBrightnessUp", exec("brightnessctl set 5%+  && " .. brightness_notify), rep)
hl.bind("XF86MonBrightnessDown", exec("brightnessctl set 5%-  && " .. brightness_notify), rep)
hl.bind("SHIFT + XF86MonBrightnessUp", exec("brightnessctl set 30%+ && " .. brightness_notify), rep)
hl.bind("SHIFT + XF86MonBrightnessDown", exec("brightnessctl set 30%- && " .. brightness_notify), rep)
hl.bind("CTRL + XF86MonBrightnessUp", exec("brightnessctl set 2%+  && " .. brightness_notify), rep)
hl.bind("CTRL + XF86MonBrightnessDown", exec("brightnessctl set 2%-  && " .. brightness_notify), rep)


-- ── Volume & Media ───────────────────────────────────────────────────

local volume_notify =
    "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}' | " ..
    "xargs -I{} notify-send -t 1000 -h int:value:{} -h string:synchronous:volume '󰕾 Volume: {}%'"

local media_mute_notify =
    "pactl get-sink-mute @DEFAULT_SINK@ | grep -q 'yes' " ..
    "&& notify-send -t 2000 -h string:synchronous:volume '󰝟 Muted' " ..
    "|| notify-send -t 2000 -h string:synchronous:volume '󰕾 Unmuted'"

local mic_mute_notify =
    "pactl get-source-mute @DEFAULT_SOURCE@ | grep -q 'yes' " ..
    "&& notify-send -t 2000 -h string:synchronous:mic-mute '󰍭 Muted' " ..
    "|| notify-send -t 2000 -h string:synchronous:mic-mute '󰍬 Unmuted'"

-- Volume steps
hl.bind("XF86AudioRaiseVolume", exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+  && " .. volume_notify), rep)
hl.bind("XF86AudioLowerVolume", exec("wpctl set-volume    @DEFAULT_AUDIO_SINK@ 2%-    && " .. volume_notify), rep)
hl.bind("SHIFT + XF86AudioRaiseVolume", exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 10%+ && " .. volume_notify), rep)
hl.bind("SHIFT + XF86AudioLowerVolume", exec("wpctl set-volume    @DEFAULT_AUDIO_SINK@ 10%-   && " .. volume_notify), rep)
hl.bind("CTRL + XF86AudioRaiseVolume", exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 0.25%+ && " .. volume_notify),
    rep)
hl.bind("CTRL + XF86AudioLowerVolume", exec("wpctl set-volume    @DEFAULT_AUDIO_SINK@ 0.25%- && " .. volume_notify), rep)
hl.bind(mainModAlt .. " + up", exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+  && " .. volume_notify), rep)
hl.bind(mainModAlt .. " + down", exec("wpctl set-volume    @DEFAULT_AUDIO_SINK@ 2%-    && " .. volume_notify), rep)

-- Mute output / input
hl.bind("XF86AudioMute", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@   toggle && " .. media_mute_notify), lock)
hl.bind(mainModCtrlShift .. " + O", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@   toggle && " .. media_mute_notify), lock)
hl.bind("XF86AudioMicMute", exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && " .. mic_mute_notify), lock)
hl.bind(mainModCtrlShift .. " + I", exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && " .. mic_mute_notify), lock)

-- Playback
hl.bind("XF86AudioPause", exec("playerctl play-pause"), lock)
hl.bind("XF86AudioPlay", exec("playerctl play-pause"), lock)
hl.bind("ALT + SPACE", exec("playerctl play-pause"))
hl.bind("CTRL + ALT + P", exec("playerctl -a pause"))
hl.bind("CTRL + ALT + SPACE", exec("~/.config/hypr/scripts/toggle-selected-player.sh"))

-- Previous / Next
hl.bind("XF86AudioNext", exec("playerctl next"), lock)
hl.bind("XF86AudioPrev", exec("playerctl previous"), lock)
hl.bind(mainModAlt .. " + right", exec("playerctl next"))
hl.bind(mainModAlt .. " + left", exec("playerctl previous"))

-- Seek
hl.bind(mainMod .. " + period", exec("playerctl position 5+"))
hl.bind(mainMod .. " + comma", exec("playerctl position 5-"))
hl.bind(mainModShift .. " + period", exec("playerctl position 30+"))
hl.bind(mainModShift .. " + comma", exec("playerctl position 30-"))

-- Audio device switching
hl.bind(mainModCtrl .. " + O", exec("~/.config/hypr/scripts/change-audio-output.sh"))
hl.bind(mainModCtrl .. " + I", exec("~/.config/hypr/scripts/change-audio-input.sh"))


-- ── Clamshell mode ───────────────────────────────────────────────────

hl.bind(mainModCtrlShift .. " + E", exec("clamshell open"), { description = "Enable main display" })
hl.bind(mainModCtrlShift .. " + D", exec("clamshell closed"), { description = "Disable main display" })
hl.bind("switch:off:Lid Switch", exec("clamshell open"), lock)
hl.bind("switch:on:Lid Switch", exec("clamshell closed"), lock)


-- ── Trackpad gesture ─────────────────────────────────────────────────

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
