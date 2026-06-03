-- terminal
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = false
	end,
})

vim.api.nvim_create_user_command("TabRename", function(opts)
	if opts.args and opts.args ~= "" then
		local current_tab = vim.api.nvim_get_current_tabpage()
		vim.api.nvim_tabpage_set_var(current_tab, "tab_title", opts.args)
		vim.cmd("redrawtabline")
	else
		print("Error: Please provide a name. Usage: :tr <name>")
	end
end, {
	nargs = 1,
})
vim.cmd("cabbrev tabrename TabRename")
