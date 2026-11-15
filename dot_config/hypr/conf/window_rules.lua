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

-- Functions
local function class_to_workspace(class, ws)
	hl.window_rule({ match = { class = "^" .. class .. "$" }, workspace = ws })
end

local function init_class_to_workspace(class, ws)
	hl.window_rule({ match = { initial_class = "^" .. class .. "$" }, workspace = ws })
end

-- Music/Audio players -> workspace 10
for _, class in pairs({
	"Spotify",
	"rmpc",
	"feishin",
	"de.vito0912.yaabsa",
}) do
	class_to_workspace(class, "10")
end

-- Messaging -> workspace 8
for _, class in pairs({
	"Beeper",
	"vesktop",
}) do
	class_to_workspace(class, "8")
end
init_class_to_workspace("discord", "8")

-- Betterbird -> workspace 7
class_to_workspace("^eu\\.betterbird\\.Betterbird$", "7")

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

hl.window_rule({
	name = "RecIt",
	match = { class = "^recit$" },
	float = true,
})
