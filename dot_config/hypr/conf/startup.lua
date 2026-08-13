--- Start on boot

-- Autostart
hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("systemctl --user start hyprland-session.target")
	hl.exec_cmd("dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE") -- Hyprshade auto-scheduling
	hl.exec_cmd("foot --server")                                                         -- Required to use foot clients
	hl.exec_cmd("udiskie -ant")                                                          -- automatic mounting
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("hypridle")                                                              -- Idle daemon
	hl.exec_cmd("hyprpm reload")                                                         -- Reload hyprpm
	hl.exec_cmd("wl-paste --watch cliphist store")                                       -- Stores only text data
	hl.exec_cmd("wl-clip-persist --clipboard regular")                                   -- Persistant clipboard
	hl.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1")                             -- Set audio to 10%
	hl.exec_cmd("awatcher --no-tray")                                                    -- Activitywatch
end)

-- Exec (run every reload)
hl.on("config.reloaded", function()
	hl.exec_cmd("swaykbdd")    -- Toggle keyboard language
	hl.exec_cmd("hyprshade auto") -- Makes sure the correct shader is enabled
end)
