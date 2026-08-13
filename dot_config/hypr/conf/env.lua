--- System environment variables

hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("GDK_BACKEND", "wayland")

--- DARK MODE
hl.env("GTK_THEME", "Adwaita:dark") -- GTK
-- Qt
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_QUICK_CONTROLS_STYLE", "org.kde.desktop")
-- Exec (run every reload)
hl.on("config.reloaded", function()
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme Adwaita-Dark")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")
end)
