-----------------
--- Autostart ---
-----------------

hl.on("hyprland.start", function()
  hl.exec_cmd("udiskie -ant")                              -- automatic mounting
  hl.exec_cmd("foot --server")                             -- required to use foot clients
  hl.exec_cmd("systemctl --user start hyprpolkitagent")    -- sudo popup
  -- hl.exec_cmd("hypridle") -- idle daemon
  hl.exec_cmd("hyprpm reload")                             -- reload hyprpm
  hl.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1") -- set audio to 10%
  hl.exec_cmd("aw-qt")                                     -- ActivityWatch
  hl.exec_cmd("swaykbdd")                                  -- toggle keyboard language

  -- Clipboard
  hl.exec_cmd("wl-paste --watch cliphist store")     -- stores only text data
  hl.exec_cmd("wl-clip-persist --clipboard regular") -- persistent clipboard

  -- Hyprshade
  hl.exec_cmd("dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE") -- Hyprshade auto-scheduling
  hl.exec_cmd("hyprshade auto")                                                           -- make sure the correct shader is enabled
end)
