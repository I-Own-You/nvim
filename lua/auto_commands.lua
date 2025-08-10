-- terminal
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = false
	end,
})
