--- Focus keybindings

require("conf.keybindings.global")

-- Focus workspace
local function focusWorkspace(key, workspace)
	BindDsp(MainMod, key, hl.dsp.focus({ workspace = workspace }))
end

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
local function moveWindowToWorkspace(key, workspace)
	BindDsp(MainModShift, key, function()
		local function notify(title, body)
			ExecNotifyCmd({ title = title, body = body, sync = "window-to-workspace" })
		end

		-- Return if no active window
		local window = hl.get_active_window()
		if not window then
			notify("Nothing to move", "No active window selected")
			return
		end

		-- Move window to workspace
		notify("Moving " .. window.class, "Workspace: " .. workspace)
		hl.dispatch(hl.dsp.window.move({ workspace = workspace }))
	end)
end

-- Move whole workspace to another workspace
local function moveWholeWorkspace(key, dst_ws)
	BindDsp(MainModCtrlShift, key, function()
		local function notify(body)
			ExecNotifyCmd({ title = "Workspace switcher", body = body, sync = "workspace_switcher", timeout = 5000 })
		end

		-- Return if no window(s) on current workspace
		local active = hl.get_active_window()
		if not active then
			notify("No window found!")
			return -- empty workspace, nothing to move
		end

		-- Return if current workspace is same as destination
		local src_ws = active.workspace.id
		if src_ws == dst_ws then
			notify("Destination same as source!")
			return
		end

		-- Move all windows from current workspace to destination workspace
		for _, w in ipairs(hl.get_windows()) do
			if w.workspace.id == src_ws then
				hl.dispatch(hl.dsp.window.move({ workspace = dst_ws, window = w }))
			end
		end

		notify("Moved to: " .. dst_ws)
	end)
end

-- Loop add bindings
for i = 1, 10, 1 do
	local key = (i == 10) and "0" or tostring(i)
	focusWorkspace(key, i)
	moveWindowToWorkspace(key, i)
	moveWholeWorkspace(key, i)
end

-- Move focus with mainMod + arrow keys
local function focusDirection(direction)
	BindDsp(MainMod, direction, hl.dsp.focus({ direction = direction }))
end

-- Move window in direction
local function moveWindowDirection(direction)
	BindDsp(MainModShift, direction, hl.dsp.window.move({ direction = direction }))
end

for _, direction in ipairs({ "left", "right", "up", "down" }) do
	focusDirection(direction)
	moveWindowDirection(direction)
end

-- Scroll through existing workspaces
-- TODO: Notif what workspace is selected
-- TODO: Notif if no workspaces available
BindDsp(MainMod, "mouse_down", hl.dsp.focus({ workspace = "e+1" }))
BindDsp(MainMod, "mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Swipe workspaces
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	---@diagnostic disable-next-line: assign-type-mismatch
	action = "workspace",
})
