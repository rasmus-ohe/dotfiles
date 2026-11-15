-- Functions used in `bind.lua`

function jumpOrLaunch(opts)
	-- l = launch command
	-- c = hyprctl class name
	-- p = print name (optional)
	-- i = icon image path (optional)

	local launch_cmd = opts.l or opts.c
	local hypr_class = opts.c or opts.l

	local print_name = opts.p or capitalize(launch_cmd)
	local icon_path = opts.i or launch_cmd

	return function()
		local workspace_id = workspaceOfClass(hypr_class)

		-- Go to workspace, if exists
		if workspace_id then
			ExecNotifyCmd({
				sync = "jump-or-launch",
				title = print_name,
				body = " 󱞪 Workspace " .. workspace_id,
				icon = icon_path,
			})
			hl.dispatch(hl.dsp.focus({ window = "class:" .. hypr_class }))
		else -- Launch app
			ExecNotifyCmd({
				sync = "jump-or-launch",
				title = print_name,
				body = "Launching...",
				icon = icon_path,
			})
			hl.dispatch(hl.dsp.exec_cmd(launch_cmd))
		end
	end
end

function launchNotify(opts)
	-- l = launch command
	-- c = hyprctl class name
	-- p = print name (optional)
	-- i = icon image path (optional)

	-- TODO: Notify instance count for class

	local windows = hl.get_windows()

	local print_name = opts.p or capitalize(opts.l)
	local icon_path = opts.i or opts.l
	local hypr_class = opts.c or opts.l

	return function()
		local window_class_count = #hl.get_windows({ class = hypr_class }) + 1

		ExecNotifyCmd({
			title = print_name .. " [" .. window_class_count .. "]",
			body = "Launching...",
			icon = icon_path,
			timeout = 3000,
		})
		hl.dispatch(hl.dsp.exec_cmd(opts.l))
	end
end

function batteryStatusNotif()
	local pipeline = [[
        capacity="$(< /sys/class/power_supply/BAT0/capacity)";
        status="$(< /sys/class/power_supply/BAT0/status)";

        if [ "$status" = "Charging" ]; then
            icon="󰂄"
        elif [  "$capacity" -ge 80 ]; then
            icon="󰁹"
        elif [ "$capacity" -ge 50 ]; then
            icon="󰂂"
        elif [ "$capacity" -ge 20 ]; then
            icon="󰁿"
        else
            icon="󰁺"
        fi

        time_str="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "time" | xargs)"
        if [ "$status" = "Charging" ]; then
            remove_prfx="time to full: "
        else
            remove_prfx="time to empty: "
        fi
        status_txt="${status} [${time_str#"$remove_prfx"} left]"
    ]]

	return pipeline
		.. " "
		.. NotifyCmd({
			title = "$icon Battery: $capacity%",
			body = "$status_txt",
			sync = "battery-status",
			timeout = 3000,
		})
end

function goToLastUsedWorkspace()
	local notif = nil
	return function()
		-- Current workspace
		local cws = hl.get_active_workspace()

		local windows_tbl = hl.get_windows()
		-- Filter by focus history
		table.sort(windows_tbl, function(a, b)
			return a.focus_history_id < b.focus_history_id
		end)

		for _, window in pairs(windows_tbl) do
			local ws = window.workspace
			local ws_id = ws.id

			if ws ~= cws then
				notif = hyprNotify({ notif = notif, text = "Jumped to: " .. ws_id, icon = 5 })
				hl.dispatch(hl.dsp.focus({ workspace = ws }))
				return
			end
		end
		notif = hyprNotify({ notif = notif, text = "No workspace to jump to...", icon = 0 })
	end
end

function notifyCurrentWorkspace()
	local notif = nil

	return function()
		local cws = hl.get_active_workspace()
		notif = hyprNotify({ notif = notif, text = "Current workspace: " .. cws.id, timeout = 1800 })
	end
end
