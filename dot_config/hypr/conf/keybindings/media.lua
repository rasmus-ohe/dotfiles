--- Media keybindings

require("conf.keybindings.global")

-- Volume
local function volumeNotify()
	local pipeline = [[
		vol_raw="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)";
		pct="$(echo "$vol_raw" | awk '{printf "%.0f", $2*100}')";
		if echo "$vol_raw" | grep -q MUTED; then
			icon="󰝟";
			else
				if [ "$pct" -eq "0" ]; then
					icon="󰕿";
				else if [ "$pct" -lt "50" ]; then
					icon="󰖀";
				else
					icon="󰕾";
				fi
			fi
		fi;
	]]
	local notify = NotifyCmd({ sync = "volume", value = "$pct", title = "$icon Volume: $pct%" })
	return pipeline .. " " .. notify
end

local function volumeControl(mod, key, amount)
	BindExec(
		mod,
		key,
		"wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ " .. amount .. " && " .. volumeNotify(),
		{ repeating = true, locked = true }
	)
end

volumeControl("", "XF86AudioRaiseVolume", "2.5%+")
volumeControl("", "XF86AudioLowerVolume", "2.5%-")
volumeControl("CTRL", "XF86AudioRaiseVolume", "1%+")
volumeControl("CTRL", "XF86AudioLowerVolume", "1%-")
volumeControl("SHIFT", "XF86AudioRaiseVolume", "10%+")
volumeControl("SHIFT", "XF86AudioLowerVolume", "10%-")
volumeControl(MainModAlt, "up", "5%+")
volumeControl(MainModAlt, "down", "5%-")

local volume_gesture = function(change)
	hl.exec_cmd(
		"wpctl set-volume @DEFAULT_AUDIO_SINK@ "
		.. math.abs(change)
		.. "%"
		.. (change < 0 and "-" or "+")
		.. " && "
		.. volumeNotify()
	)
end
hl.gesture({
	fingers = 4,
	direction = "vertical",
	---@diagnostic disable-next-line: assign-type-mismatch
	action = {
		start = function(e)
			volume_gesture(-0.05 * e.delta.y)
		end,
		update = function(e)
			volume_gesture(-0.05 * e.delta.y)
		end,
	},
})

-- Mute media
local function volumeMuteToggle(mod, key)
	local function mediaMuteNotify(emoji, body)
		return NotifyCmd({ sync = "volume", timeout = 2000, title = emoji .. " Volume", body = body })
	end

	local notify = "pactl get-sink-mute @DEFAULT_SINK@ | grep -q 'yes' && "
		.. mediaMuteNotify("󰝟", "Muted")
		.. " || "
		.. mediaMuteNotify("󰕾", "Unmuted")

	BindExec(mod, key, "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && " .. notify, { locked = true })
end

volumeMuteToggle("", "XF86AudioMute")

-- Mute mic
local function micMuteToggle(mod, key)
	local function micMuteToggle(emoji, body)
		return NotifyCmd({ sync = "volume", timeout = 2000, title = emoji .. " Mic", body = body })
	end

	local notify = "pactl get-source-mute @DEFAULT_SOURCE@ | grep -q 'yes' && "
		.. micMuteToggle("󰍭", "Muted")
		.. " || "
		.. micMuteToggle("󰍬", "Unmuted")

	BindExec(mod, key, "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && " .. notify, { locked = true })
end

micMuteToggle("", "XF86AudioMicMute")
micMuteToggle(MainModCtrlShift, "I")

-- Play-pause
local function playPauseToggle(mod, key)
	BindExec(mod, key, "playerctl play-pause", { locked = true })
end
playPauseToggle("", "XF86AudioPause")
playPauseToggle("", "XF86AudioPlay")
playPauseToggle("ALT", "SPACE")

BindExec("CTRL + ALT", "SPACE", "~/.config/hypr/scripts/toggle-selected-player.sh")

-- Previous-Next
local function playNextPrev(mod, key, cmd)
	local full_cmd
	if cmd == "previous" then
		full_cmd = [[
			player_name=$(playerctl metadata --format '{{ lc(playerName) }}')
			position=$(printf "%.0f" $(playerctl position))
			[ $player_name = "mpd" ] && [ $position -gt 3 ] && playerctl position 0 || playerctl previous
		]]
	else
		full_cmd = "playerctl " .. cmd
	end

	BindExec(mod, key, full_cmd, { locked = true })
end
playNextPrev("", "XF86AudioNext", "next")
playNextPrev("", "XF86AudioPrev", "previous")
playNextPrev(MainModAlt, "RIGHT", "next")
playNextPrev(MainModAlt, "LEFT", "previous")

-- Position
local function seekPosition(mod, key, amount)
	BindExec(mod, key, "playerctl position " .. amount, { locked = true })
end
seekPosition(MainMod, "PERIOD", "+5")
seekPosition(MainMod, "COMMA", "-5")
seekPosition(MainModShift, "PERIOD", "+30")
seekPosition(MainModShift, "COMMA", "-30")
