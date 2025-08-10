return {
	"nvim-focus/focus.nvim",
	enabled = true,
	event = "BufReadPost",
	version = "*",
	keys = {
		{ "<leader>df", ":FocusToggle<CR>", mode = "n", desc = "disable focus.nvim", silent = true },
	},
	opts = {},
}
