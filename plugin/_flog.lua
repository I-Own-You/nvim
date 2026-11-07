if true then
	vim.pack.add({
		"https://github.com/tpope/vim-fugitive", -- dep
		"https://github.com/rbong/vim-flog",
	})
	vim.keymap.set("n", "<leader>fgg", "<cmd>Flog ", { desc = "open floggit" })
	vim.keymap.set("n", "<leader>fs", "<cmd>Flogsplit ", { desc = "flog split" })
end
