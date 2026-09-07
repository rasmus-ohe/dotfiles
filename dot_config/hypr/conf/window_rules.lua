------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------

-- See https://wiki.hypr.land/Configuring/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules

-- Steam games
hl.window_rule({
	name = "steam-games",
	match = { class = "^steam_app_.*" },
	workspace = "9",
	fullscreen = true,
	border_size = 0,
	rounding = 0,
})

hl.window_rule({
	name = "steam-games-gamescope",
	match = { class = "^gamescope*" },
	workspace = "9",
	border_size = 0,
	rounding = 0,
})

-- Ignore maximize requests from apps
hl.window_rule({
	name = "ignore-maximize",
	suppress_event = "maximize",
})

-- Spotify -> workspace 10
hl.window_rule({ match = { class = "^Spotify$" }, workspace = "10 silent" })

-- Beeper -> workspace 8
hl.window_rule({ match = { class = "^Beeper$" }, workspace = "8" })

-- Discord -> workspace 8
hl.window_rule({ match = { initial_class = "^discord$" }, workspace = "8" })
hl.window_rule({ match = { class = "^vesktop$" }, workspace = "8" })

-- Betterbird -> workspace 7
hl.window_rule({ match = { class = "^eu\\.betterbird\\.Betterbird$" }, workspace = "7" })

-- Corluma -> workspace 5
hl.window_rule({ match = { class = "^corluma$" }, workspace = "5" })

-- Blender -> workspace 1 (keep file browser size persistent)
hl.window_rule({
	name = "blender",
	match = { class = "blender" },
	workspace = "1",
	persistent_size = true,
})

-- Fix some dragging issues with XWayland
hl.window_rule({
	match = { xwayland = true, class = "^$", title = "^$" },
	float = true,
})

-- Open btop monitor into special workspace
hl.window_rule({
	name = "btop-monitor",
	match = { title = "^btop-monitor$" },
	workspace = "special",
})
