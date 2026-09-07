--- Dynamic workspaces

require("conf.keybindings.global")

hl.on("monitor.added", function(monitor)
    local workspace

    -- Assign monitor to workspace
    if monitor.serial == "PIPM4JA006993" then
        workspace = "10"
    elseif monitor.serial == "0x30303453" then
        workspace = "1"
    elseif monitor.serial == "08DXD4AP0TAL" then
        workspace = "2"
    else
        -- Notify of unknown monitor
        hl.exec_cmd(NotifyCmd({ title = "Unknown monitor", body = monitor.name, timeout = 10000 }))
        return
    end

    hl.workspace_rule({ workspace = workspace, monitor = monitor.name, default = true })
    hl.exec_cmd(NotifyCmd({ title = "Workspace moved to monitor", body = workspace .. " -> " .. monitor.name, timeout = 10000 }))
end)

hl.on("monitor.removed", function(monitor)
    hl.exec_cmd(NotifyCmd({ title = "monitor removed", body = monitor.name, timeout = 10000 }))
end)
