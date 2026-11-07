if true then
	vim.pack.add({ "https://github.com/folke/todo-comments.nvim" })
	require("todo-comments").setup()

	vim.keymap.set("n", "<leader>td", "<cmd>TodoQuickFix<CR>", { desc = "open todos", silent = true })
end
