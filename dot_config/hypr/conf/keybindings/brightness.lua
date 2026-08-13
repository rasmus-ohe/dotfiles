--- Brightness keybindings

require("conf.keybindings.global")

local function brigthnessControl(mod, key, amount)
    local pipeline = [[
		pct="$(awk -v cur="$(brightnessctl get)" -v max="$(brightnessctl max)" 'BEGIN { printf("%.0f", cur/max*100) }')";
		if [ "$pct" -lt "30" ]; then icon="󰃞"; elif [ "$pct" -lt "70" ]; then icon="󰃟"; else icon="󰃠"; fi;
	]]
    local notify = NotifyCmd({ sync = "volume", value = "$pct", title = "$icon Brightness: $pct%" })
    BindExec(
        mod,
        key,
        "brightnessctl set " .. amount .. "% && " .. pipeline .. " " .. notify,
        { repeating = true, locked = true }
    )
end

brigthnessControl("", "XF86MonBrightnessUp", "15+")
brigthnessControl("", "XF86MonBrightnessDown", "15-")
brigthnessControl("SHIFT", "XF86MonBrightnessUp", "25+")
brigthnessControl("SHIFT", "XF86MonBrightnessDown", "25-")
brigthnessControl("CTRL", "XF86MonBrightnessUp", "5+")
brigthnessControl("CTRL", "XF86MonBrightnessDown", "5-")
