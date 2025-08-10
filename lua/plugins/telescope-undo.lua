local opts = {
	extensions = {
		import = {
			insert_at_top = true,
		},
	},
}

return {

	"debugloop/telescope-undo.nvim",
	enabled = true,
	opts = opts,
	dependencies = {
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
	},
	keys = {
		{
			"<leader>tu",
			"<cmd>Telescope undo<cr>",
			desc = "undo history",
			silent = true,
		},
	},
	config = function(_, opts)
		require("telescope").setup(options)
		require("telescope").load_extension("undo")
	end,
}
