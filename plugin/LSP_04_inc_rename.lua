if true then
	vim.pack.add({
		"https://github.com/smjonas/inc-rename.nvim",
	})
	require("inc_rename").setup()

	-- vim.keymap.set("n", "<leader>re", "<cmd>IncRename ")

	vim.keymap.set("n", "grn", ":IncRename <C-r><C-w>")
end
