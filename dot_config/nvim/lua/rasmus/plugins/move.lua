return {
	"fedepujol/move.nvim",
	keys = {
		-- Normal Mode
		{ "<A-Down>", ":MoveLine(1)<CR>", desc = "Move Line Down" },
		{ "<A-Up>", ":MoveLine(-1)<CR>", desc = "Move Line Up" },
		{ "<A-h>", ":MoveHChar(-1)<CR>", desc = "Move Character Left" },
		{ "<A-l>", ":MoveHChar(1)<CR>", desc = "Move Character Right" },
		{ "<leader>wf", ":MoveWord(-1)<CR>", mode = { "n" }, desc = "Move Word Left" },
		{ "<leader>wb", ":MoveWord(1)<CR>", mode = { "n" }, desc = "Move Word Right" },
		-- Visual Mode
		{ "<A-Down>", ":MoveBlock(1)<CR>", mode = { "v" }, desc = "Move Block Up" },
		{ "<A-Up>", ":MoveBlock(-1)<CR>", mode = { "v" }, desc = "Move Block Down" },
		{ "<A-h>", ":MoveHBlock(-1)<CR>", mode = { "v" }, desc = "Move Block Left" },
		{ "<A-l>", ":MoveHBlock(1)<CR>", mode = { "v" }, desc = "Move Block Right" },
	},
	opts = {
		-- Config here
	},
}
