return {
	"mikavilpas/yazi.nvim",
	enabled = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = "VeryLazy",
	keys = {
		{
			"<leader>e",
			function()
				require("yazi").yazi()
			end,
			desc = "Open the file manager",
		},
	},
	opts = {
		floating_window_scaling_factor = 0.8,
	},
}
