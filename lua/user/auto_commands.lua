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

vim.api.nvim_create_user_command("LspStart", function()
	vim.api.nvim_exec_autocmds("FileType", { buffer = 0 })
	print("lAUNCH LSP SERVER")
end, {})

vim.api.nvim_create_user_command("LspRestart", function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		print("NO LSP SERVER TO RESTART")
		return
	end

	local restarted_any = false
	for _, client in ipairs(clients) do
		if client.name ~= "null-ls" and client.name ~= "none-ls" then
			client.stop(client)
			restarted_any = true
		end
	end

	if restarted_any then
		local original_notify = vim.notify
		vim.notify = function() end

		vim.cmd("edit!")

		vim.defer_fn(function()
			vim.notify = original_notify
		end, 200)

		print("LSP SERVER IS RESTARTED")
	else
		print("NULL LS ONLY ACTIVE")
	end
end, {})

vim.api.nvim_create_user_command("LspStop", function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	for _, client in ipairs(clients) do
		client.stop(client)
	end
	print("LSP SERVERS TURNED OFF")
end, {})

vim.api.nvim_create_user_command("LspInfo", function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		print("❌ No active LPS Servers")
		return
	end

	local lines = { "  === Active LSP Servers ===  ", "" }
	for _, client in ipairs(clients) do
		table.insert(lines, string.format(" 🤖 Name:           %s (ID: %d)", client.name, client.id))
		table.insert(lines, string.format(" 📁 Root folder:   %s", client.root_dir or "Not defined"))
		if client.config and client.config["filetypes"] then
			table.insert(lines, string.format(" 📄 File types:   %s", table.concat(client.config["filetypes"], ", ")))
		end
		table.insert(lines, " ----------------------------------------- ")
	end

	local buf, _ = vim.lsp.util.open_floating_preview(lines, "markdown", {
		border = "rounded",
		focusable = true,
		focus_id = "lsp_info_popup",
	})

	vim.keymap.set("n", "q", ":close<CR>", { buffer = buf, silent = true, nowait = true })
	vim.keymap.set("n", "<Esc>", ":close<CR>", { buffer = buf, silent = true, nowait = true })
end, {})

vim.cmd("cabbrev tabrename TabRename")

vim.cmd("cabbrev lspstart LspStart")
vim.cmd("cabbrev lsprestart LspRestart")
vim.cmd("cabbrev lspstop LspStop")
vim.cmd("cabbrev lspinfo LspInfo")
