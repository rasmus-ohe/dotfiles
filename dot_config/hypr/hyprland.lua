-------------------------
-- SOURCE OTHER FILES --
-------------------------

-- require("monitors")
-- require("workspaces")

for _, filename in pairs({
	"dynamic_workspaces",
	"env",
	"keybindings.keybindings",
	"startup",
	"window_rules",
	"workspaces",
	"input_devices",
	"look_and_feel",
	"plugins",
	"shutdown",
}) do
	require("conf." .. filename)
end

do
	local path = os.getenv("HOME") .. "/.config/hypr/hyprmoncfg-monitors.lua"
	local file = io.open(path, "r")
	if file then
		file:close()
		dofile(path)
	end
end

-- Uncomment ONLY for debugging Lua code!
-- hl.config({ debug = { disable_logs = false } })

do
	local path = os.getenv("HOME") .. "/.config/hypr/hyprmoncfg-monitors.lua"
	local file = io.open(path, "r")
	if file then
		file:close()
		dofile(path)
	end
end

do
	local path = os.getenv("HOME") .. "/.config/hypr/hyprmoncfg-monitors.lua"
	local file = io.open(path, "r")
	if file then
		file:close()
		dofile(path)
	end
end

-- Added by hyprmoncfg: its generated monitor rules load last, so nothing before this can override the applied layout.
do local path = os.getenv("HOME") .. "/.config/hypr/hyprmoncfg-monitors.lua"; local file = io.open(path, "r"); if file then file:close(); dofile(path) end end
