-------------
--- Input ---
-------------

hl.config({
  input = {
    kb_layout = "fi,us",
    kb_options = "grp:win_space_toggle, compose:menu",
    resolve_binds_by_sym = true, -- resolve_binds_by_sym	Determines how keybinds act when multiple layouts are used.

    -- Mouse
    accel_profile = "flat", -- "flat" = disable acceleration
    follow_mouse = 1,       -- 1 = Cursor movement will always change focus to the window under the cursor.
    sensitivity = 0,        -- -1.0 to 1.0; 0.0 = disabled

    touchpad = {
      natural_scroll = true,      -- 	Inverts scrolling direction. When enabled, scrolling moves content directly, rather than manipulating a scrollbar.
      disable_while_typing = true -- Disable the touchpad while typing.
    }
  }
})

-- Yoga (laptop) touchpad
hl.device({
  name = "msft0001:00-06cb:ce44-touchpad",
  accel_profile = "adaptive",
  sensitivity = -0.1
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

-- Corne split keyboard
hl.device({
  name = "zmk-project-corne-keyboard",
  kb_layout = "us"
})
