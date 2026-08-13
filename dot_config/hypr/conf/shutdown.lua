---  Shutdown

-- Turn on touchpad
hl.on("hyprland.shutdown", function()
    hl.exec_cmd("hyprctl keyword device[msft0001:00-06cb:ce44-touchpad]:enabled 1")
end)
