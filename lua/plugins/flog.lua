return {
	"rbong/vim-flog",
	enabled = true,
	dependencies = { "tpope/vim-fugitive" },
	keys = {
		{ "<leader>fgg", mode = "n", ":Flog ", desc = "open floggit", noremap = true, silent = true },
		{ "<leader>fs", mode = "n", ":Flogsplit ", desc = "flog split", noremap = true, silent = true },
	},
}
