--- Binded keybindings

require("conf.keybindings.global")

local settings = "foot -e nvim ~/.config/hypr/"
local fileManager = "nemo"
local menu = "fuzzel"
local calculator = "gnome-calculator"
local browser = "zen-browser"
local browser_private = "zen-browser --private-window"


local function jumpOrLaunch(opts)
    local cmd = "jump-or-launch-app.sh "

    if opts.l then
        cmd = cmd .. "-l '" .. opts.l .. "' "
    end
    if opts.c then
        cmd = cmd .. "-c '" .. opts.c .. "' "
    end
    if opts.p then
        cmd = cmd .. "-p '" .. opts.p .. "' "
    end
    if opts.i then
        cmd = cmd .. "-i '" .. opts.i .. "' "
    end

    return HyprScript(cmd)
end

local function batteryStatusNotif()
    local pipeline = [[
        capacity="$(< /sys/class/power_supply/BAT0/capacity)";
        status="$(< /sys/class/power_supply/BAT0/status)";

        if [ "$status" = "Charging" ]; then
            icon="󰂄"
        elif [  "$capacity" -ge 80 ]; then
            icon="󰁹"
        elif [ "$capacity" -ge 50 ]; then
            icon="󰂂"
        elif [ "$capacity" -ge 20 ]; then
            icon="󰁿"
        else
            icon="󰁺"
        fi

        time_str="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "time" | xargs)"
        if [ "$status" = "Charging" ]; then
            remove_prfx="time to full: "
        else
            remove_prfx="time to empty: "
        fi
        status_txt="${status} [${time_str#"$remove_prfx"} left]"
    ]]

    return pipeline .. " " ..
        NotifyCmd({
            title = "$icon Battery: $capacity%",
            body = "$status_txt",
            sync = "battery-status",
            timeout = 3000
        })
end


-- Bindings
BindExec("XF86Calculator", "", calculator)
BindExec(
    MainModCtrl,
    "A",
    jumpOrLaunch({ l = "pavucontrol", c = "org.pulseaudio.pavucontrol", p = "Volume Control", i = "󰕾" })
)                                                         -- Audio (device) control

BindExec(MainMod, "B", browser)                           -- zen
BindExec(MainModAlt, "B", "blender")                      -- Blender
BindExec(MainModCtrl, "B", HyprScript("bt-connect-menu")) -- BT Connection menu
BindExec(MainModShift, "B", browser_private)              -- zen (private window)
BindExec(
    MainModCtrlAlt,
    "B",
    jumpOrLaunch({ l = "blueman-manager", i = "󰂯" })
)
BindExec(MainModCtrlShift, "B", HyprScript("toggle-bluetooth")) -- Toggle Bluetooth

BindExec(MainMod, "C", "code") -- VSCode
BindDsp(MainModAlt, "C", hl.dsp.cursor.move_to_corner({ corner = 1 })) -- Move cursor to corner
BindExec(MainModCtrl, "C", "swaync-client -C") -- Close all notifications
BindExec(MainModShift, "C", "cliphist list| fuzzel --dmenu| cliphist decode| wl-copy") -- Clipboard view

BindExec(MainMod, "D", menu) -- fuzzel
BindExec(MainModShift, "D", HyprScript("list-open-apps")) -- List open software in fuzzel
BindExec(MainModAlt, "D", jumpOrLaunch({ l = "com.discordapp.Discord", c = "discord", i = "󰙯" })) -- Discord

BindExec(
    MainMod,
    "E",
    jumpOrLaunch({ l = "thunderbird", c = "eu.thunderbird.Thunderbird", p = "Thunderbird", i = "󰇮" })
) -- Email client
BindExec(MainModShift, "E", HyprScript("emoji-picker", "copy")) -- Emoji picker
BindExec(MainModCtrl, "E",
    jumpOrLaunch({ l = "easyeffects", c = "com.github.wwmm.easyeffects", p = "EasyEffects", icon = "" })) -- EasyEffects

BindExec(MainMod, "F", fileManager)
BindExec(MainModAlt, "F", "footclient -e yazi")     -- Terminal file manager (yazi)
BindExec(MainModShift, "F", "footclient -e fzf -e") -- Fuzzy search
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

BindExec(MainMod, "L", jumpOrLaunch({ l = "net.corluma.Corluma", c = "corluma", i = "󰌵" })) -- Control HUE lights
BindExec(MainModShift, "L", HyprScript("lenny-picker")) -- Lenny picker (fuzzel)

BindExec(MainMod, "M", jumpOrLaunch({ l = "spotify", c = "Spotify", i = "󰓇" })) -- Spotify
BindExec(MainModCtrl, "M", "toggle-mic-mute") -- Toggle (default) mic mute status
BindExec(MainModShift, "M", jumpOrLaunch({ l = "beeper", c = "Beeper", p = "Beeper", i = "󰍡" })) -- Beeper
BindExec(MainModCtrlShift, "M", "toggle-mouse-hold")

BindExec(MainMod, "N", jumpOrLaunch({ l = "obsidian", i = "󰎞" }))
BindExec(MainModCtrl, "N", "swaync-client -t") -- Toggle the notification panel

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

BindExec(MainMod, "P", "hyprpicker -a -q && notify-send \"󰏘 Color copied to clipboard\"") -- Color picker
BindExec(MainModCtrl, "P", HyprScript("power-profile-picker")) -- Power profile picker
BindExec(MainModShift, "P", HyprScript("ratbag-profile-switcher")) -- Change Logitech mouse profile

BindDsp(MainMod, "Q", hl.dsp.window.close()) -- Kill active window
BindDsp(MainModShift, "Q", hl.dsp.window.kill()) -- Kill all similar windows to the active

BindExec(MainModCtrlShift, "R", "hyprctl reload") -- Reload Hyprland

-- BindExec(MainMod, "S", "hyprctl dispatch exec [workspace special] foot -e btop") -- System monitor
BindDsp(MainMod, "S", hl.dsp.exec_cmd(
    [[ footclient --title "btop-monitor" -e btop]]
))
BindDsp(MainModAlt, "S", hl.dsp.workspace.toggle_special("magic")) -- Toggle special workspace
BindExec(MainModCtrl, "S", HyprScript("toggle-hyprshade"))         -- Toggle hyprshade
BindExec(MainModShift, "S", "footclient -e ncdu")                  -- Disk usage analyzer
BindExec(MainModCtrlAlt, "S", "hyprshade on grayscale")            -- Grayscale mode

BindExec(MainMod, "T", "footclient")                               -- Terminal
BindExec(MainModCtrl, "T", "toggle-touchpad")                      -- Toggle touchpad
BindExec(MainModShift, "T", fileManager .. " trash://")            -- Trash

-- TODO: Update system
-- BindExec(
--     MainMod,
--     "U",
--     [[footclient -e script -q -O /tmp/system-update-$(date +%Y%m%d-%H%M%S).log -c ~/.config/hypr/scripts/system-update.sh >/dev/null 2>&1]]
-- ) -- Update system
-- TODO: Alternative system updater
-- BindExec(
--     MainModAlt,
--     "U",
--     [[hyprctl dispatch exec [workspace special] foot -e script -q -O /tmp/system-alt-update-$(date +%Y%m%d-%H%M%S).log -c ~/.config/hypr/scripts/system-alt-update.sh >/dev/null 2>&1]]
-- )                                                               -- Other system updates

BindExec(MainModCtrl, "V", HyprScript("vpn-menu"))              -- Fuzzel VPN menu

BindExec(MainMod, "W", HyprScript("go-to-last-used-workspace")) -- Go to last used app
BindExec(
    MainModCtrl,
    "W",
    NotifyCmd({
        sync = "workspace",
        title =
        "󰍹 Current workspace: $(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | if .specialWorkspace.id == -99 then \"Special\" else .activeWorkspace.id end')",
    })
)                                                              -- Notify the current workspace id
BindExec(MainModShift, "W", HyprScript("list-last-used-apps")) -- List last used apps in fuzzel
BindExec(MainModCtrlShift, "W", HyprScript("hold-key"))

BindDsp(MainMod, "Z", function()
    local ZOOM_LEVEL = 2.5
    local MIN_ZOOM = 1
    local current_zoom = hl.get_config("cursor.zoom_factor")
    local target = current_zoom == MIN_ZOOM and ZOOM_LEVEL or MIN_ZOOM
    hl.config({ cursor = { zoom_factor = target } })
end)
