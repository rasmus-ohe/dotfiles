hl.config({
    general = {
        hide_cursor = true,
        ignore_empty_input = true,
    },
})

hl.config({
    background = {
        color = "rgb(000000)",
        blur_passes = 0,
    },
})
-- NOTE: Section 'background' may be a plugin or custom section; verify the output

hl.config({
    label = {
        text = "Locked",
        color = "rgba(ffffffff)",
        font_size = 32,
        position = { 0, -300 },
        halign = "center",
        valign = "center",
    },
})
-- NOTE: Section 'label' may be a plugin or custom section; verify the output

-- hl.config({
--     input-field = {
--         size = { 300, 50 },
--         outline_thickness = 3,
--         dots_center = true,
--         position = { 0, 0 },
--         halign = "center",
--         valign = "center",
--         outer_color = "rgba(888888aa)",
--         inner_color = "rgba(000000aa)",
--         font_color = "rgba(ffffffff)",
--         fade_on_empty = false,
--     },
-- })
-- NOTE: Section 'input-field' may be a plugin or custom section; verify the output
