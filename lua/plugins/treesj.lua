local opts = {
	use_default_keymaps = false,
	max_join_length = 999,
}

return {

	"Wansmer/treesj",
	enabled = true,
	dependencies = { "nvim-treesitter" },
	opts = opts,
	keys = { { "<leader>j", mode = "n", "<cmd>TSJToggle<cr>", desc = "toggle node split", silent = true } },
}
