vim.api.nvim_create_user_command("ZR", function()
	vim.cmd(":restart")
end, {})
