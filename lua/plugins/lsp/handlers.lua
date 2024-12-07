local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
-- for ufo.nvim folding
M.capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
		-- { name = "DiagnosticSignWarn", text = "" },
		-- { name = "DiagnosticSignHint", text = "" },
		-- { name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local border = {
		{ "┏", "FloatBorder" },
		{ "━", "FloatBorder" },
		{ "┓", "FloatBorder" },
		{ "┃", "FloatBorder" },
		{ "┛", "FloatBorder" },
		{ "━", "FloatBorder" },
		{ "┗", "FloatBorder" },
		{ "┃", "FloatBorder" },
	}

	local config = {
		-- virtual_text = {
		-- 	prefix = "󱓻 ",
		-- }, -- disable virtual text
		virtual_text = false,
		signs = false,
		-- signs = {
		-- 	active = signs, -- show signs
		-- },
		update_in_insert = false,
		underline = false,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = border,
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		-- border = "rounded",
		border = border,
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = border, -- this doesnt want to work, i wonder why ?
		-- border = "rounded",
	})
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap

	keymap(bufnr, "n", "gd", ":Glance definitions<CR>", opts)
	keymap(bufnr, "n", "gr", ":Glance references<CR>", opts)
	keymap(bufnr, "n", "gi", ":Glance implementations<CR>", opts)
	keymap(bufnr, "n", "<leader>D", ":Glance type_definitions<CR>", opts)
	keymap(bufnr, "n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)

	-- keymap(bufnr, "n", "<leader>D", ":lua vim.lsp.buf.type_definition()<CR>", opts)
	-- keymap(bufnr, "n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
	-- keymap(bufnr, "n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts) --keymaps.lua
	-- keymap(bufnr, "n", "gr", ":lua vim.lsp.buf.references()<CR>", opts) --keymaps.lua

	-- keymap(bufnr, "n", "<leader>wa", ":lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	-- keymap(bufnr, "n", "<leader>wr", ":lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	-- keymap(bufnr, "n", "<leader>wl", ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	-- keymap(bufnr, "n", "<leader>re", ":lua vim.lsp.buf.rename()<CR>", opts)
	keymap(
		bufnr,
		"n",
		"<leader>re",
		':lua require("nvchad.lsp.renamer")()<CR>',
		{ silent = true, desc = "LSP Rename symbol" }
	)
	-- keymap(bufnr, "n", "<leader>ca", ":lua vim.lsp.buf.code_action()<cr>", opts) --keymaps.lua
	-- keymap(bufnr, "n", "<leader>lq", ":lua vim.diagnostic.setloclist()<CR>", opts) --keymaps.lua
	-- keymap(bufnr, "n", "<leader>oo", ":lua vim.lsp.buf.document_symbol()<CR>", opts)
	keymap(bufnr, "n", "<leader>rr", ":lua vim.lsp.buf.format{ async = true }<cr>", { silent = true })
	keymap(bufnr, "n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "ge", ":lua vim.diagnostic.goto_next({buffer=0, float=false})<cr>", opts)
	keymap(bufnr, "n", "<leader>lq", ":lua vim.diagnostic.setloclist()<cr>", opts)
	keymap(bufnr, "n", "gE", ":lua vim.diagnostic.goto_prev({buffer=0, float=false})<cr>", opts)
	keymap(bufnr, "n", "<leader>fl", ":lua vim.diagnostic.open_float()<cr>", opts)
	keymap(bufnr, "n", "<leader>ls", ":lua vim.lsp.buf.signature_help()<CR>", opts)
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "lua_ls" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "pylsp" then
		-- this is needed if you setup 2 lsp (pyright and pylsp)
		client.server_capabilities.documentSymbolProvider = false
	end

	if client.name == "gopls" then
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end

	lsp_keymaps(bufnr)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end
return M
