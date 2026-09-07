--- Feel

hl.config({
	input = {
		kb_layout = "fi,us",
		kb_options = "grp:win_space_toggle,compose:menu",
		-- resolve_binds_by_sym = 1,
		accel_profile = "flat", -- mouse acceleration: flat=disabled
		follow_mouse = 1,
		sensitivity = 0,  -- -1.0 - 1.0 (0 means no modification)
		touchpad = {
			natural_scroll = true, -- Inverts scrolling direction
			disable_while_typing = true,
		},
	},

	gestures = {
		workspace_swipe_forever = false,
		workspace_swipe_create_new = false,
	}
})

-- Yoga (laptop) touchpad
hl.device({
	name = "msft0001:00-06cb:ce44-touchpad",
	accel_profile = "adaptive",
	sensitivity = -0.1,
})

-- Corne split keyboard
hl.device({
	name = "corne-keyboard",
	kb_layout = "us",
})
