return {
	"fredrikaverpil/godoc.nvim",
	version = "*",
	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
		{ "ibhagwan/fzf-lua" },
		{ "nvim-treesitter/nvim-treesitter" },
	},
	keys = {
		{
			"<leader>ig",
			":GoDoc<CR>",
			desc = "open golang imports info",
			silent = true,
		},
	},
	build = "go install github.com/lotusirous/gostdsym/stdsym@latest", -- optional
	opts = {
		picker = {
			type = "fzf_lua", -- native (vim.ui.select) | telescope | snacks | mini | fzf_lua
		},
	}, -- see further down below for configuration
}
