-----------------
--- Dark Mode ---
-----------------

-- GTK
hl.env("GDK_BACKEND", "wayland,swaync,x11,*")
hl.env("GTK_THEME", "Adwaita:dark")
hl.on("hyprland.start", function()
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme Adwaita-Dark")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")
end)

-- Qt
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1") -- Enables automatic scaling, based on the monitor’s pixel density
hl.env("QT_QPA_PLATFORM", "wayland")       -- Tell Qt applications to use the Wayland backend, and fall back to X11 if Wayland is unavailable
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")    -- Tells Qt based applications to pick your theme from qt5ct, use with Kvantum.
-- hl.env("QT_QUICK_CONTROLS_STYLE", "org.kde.desktop") -- Tells Qt based applications to use the Kvantum style

-- XDG
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
