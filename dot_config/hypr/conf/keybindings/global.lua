--- Global keybinding functions

MainMod = "SUPER" -- Sets "Windows" key as main modifier
MainModShift = "SUPER + SHIFT"
MainModCtrl = "SUPER + CTRL"
MainModAlt = "SUPER + ALT"
MainModAltShift = "SUPER + ALT + SHIFT"
MainModCtrlShift = "SUPER + CTRL + SHIFT"
MainModCtrlAlt = "SUPER + CTRL + ALT"
NewTerminal = "footclient -e"
NewTerminalHold = "footclient -e --hold"
SpecialExec = "hyprctl dispatch exec [workspace special] foot -e"

-- Bind functions
function BuildKeybind(mod, key)
    if mod == "" then
        return key
    else
        return mod .. " + " .. key
    end
end

function BindExec(mod, key, cmd, flags)
    hl.bind(BuildKeybind(mod, key), hl.dsp.exec_cmd(cmd), flags)
end

function BindDsp(mod, key, dispatcher, flags)
    hl.bind(BuildKeybind(mod, key), dispatcher, flags)
end

function BindFunc(mod, key, func, flags)
    hl.bind(BuildKeybind(mod, key), func, flags)
end

-- Notify command
function NotifyCmd(opts)
    local parts = { "notify-send" }

    if opts.timeout then
        table.insert(parts, "-t " .. opts.timeout)
    end
    if opts.sync then
        table.insert(parts, "-h string:synchronous:" .. opts.sync)
    end
    if opts.value then
        table.insert(parts, "-h int:value:" .. opts.value)
    end
    if opts.urgency then
        table.insert(parts, "-u " .. opts.urgency)
    end

    table.insert(parts, '"' .. opts.title .. '"')
    if opts.body then
        table.insert(parts, '"' .. opts.body .. '"')
    end

    return table.concat(parts, " ")
end

-- Paths
function HyprScript(filename, args)
    if args == nil then
        args = ""
    end

    return "~/.config/hypr/scripts/" .. filename .. ".sh" .. " " .. args
end
