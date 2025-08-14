return {
	"piersolenski/telescope-import.nvim",
	enabled = true,
	dependencies = "nvim-telescope/telescope.nvim",
	keys = {
		{ "<leader>ii", "<cmd>Telescope import<CR>", desc = "open imports", silent = true },
	},
	config = function()
		require("telescope").load_extension("import")
	end,
}
