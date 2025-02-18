-- terminal
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = false
	end,
})

-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
-- 	pattern = "term://*",
-- 	callback = function()
-- 		vim.cmd("startinsert")
-- 	end,
-- })
