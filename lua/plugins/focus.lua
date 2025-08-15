return {
	"nvim-focus/focus.nvim",
	enabled = false,
	event = "BufReadPost",
	version = "*",
	keys = {
		{ "<leader>df", ":FocusToggle<CR>", mode = "n", desc = "disable focus.nvim", silent = true },
	},
	opts = {},
}
