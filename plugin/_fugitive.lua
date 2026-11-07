if true then
	vim.pack.add({ "https://github.com/tpope/vim-fugitive" })
	vim.keymap.set("n", "<leader>gg", "<cmd>Git ", { desc = "open git", noremap = true, silent = true })
	vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "git commit", noremap = true, silent = true })
	vim.keymap.set("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "git push", silent = true })
	vim.keymap.set("n", "<leader>bl", "<cmd>Git blame<CR>", { desc = "git blame", noremap = true, silent = true })
end
