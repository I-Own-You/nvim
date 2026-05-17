vim.pack.add({
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvimtools/none-ls.nvim",
	"https://github.com/j-hui/fidget.nvim",
	"https://github.com/rachartier/tiny-inline-diagnostic.nvim",
	"https://github.com/neovim/nvim-lspconfig",
})

require("fidget").setup()
require("tiny-inline-diagnostic").setup({
	preset = "powerline",
	options = {
		use_icons_from_diagnostic = true,
		show_all_diags_on_cursorline = true,
		multilines = {
			enabled = true,
			always_show = true,
		},
		multiple_diag_under_cursor = true,
	},
})

local on_attach = function(client, bufnr)
	vim.keymap.set(
		"n",
		"gd",
		vim.lsp.buf.definition,
		{ buffer = bufnr, remap = false, silent = true, desc = "go to defintion" }
	)
	vim.keymap.set(
		"i",
		"<C-s>",
		vim.lsp.buf.signature_help,
		{ buffer = bufnr, remap = false, silent = true, desc = "signature help" }
	)
	vim.keymap.set(
		"n",
		"gr",
		vim.lsp.buf.references,
		{ buffer = bufnr, remap = false, silent = true, desc = "show references" }
	)
	vim.keymap.set(
		"n",
		"gi",
		vim.lsp.buf.implementation,
		{ buffer = bufnr, remap = false, silent = true, desc = "show implementations" }
	)
	vim.keymap.set(
		"n",
		"<leader>D",
		vim.lsp.buf.type_definition,
		{ buffer = bufnr, remap = false, silent = true, desc = "show type definition" }
	)
	vim.keymap.set(
		"n",
		"gD",
		vim.lsp.buf.declaration,
		{ buffer = bufnr, remap = false, silent = true, desc = "show type declaration" }
	)
	vim.keymap.set(
		"n",
		"<leader>re",
		vim.lsp.buf.rename,
		{ buffer = bufnr, remap = false, silent = true, desc = "lsp rename" }
	)
	vim.keymap.set(
		"n",
		"<leader>ca",
		vim.lsp.buf.code_action,
		{ buffer = bufnr, remap = false, silent = true, desc = "code actions" }
	)
	vim.keymap.set(
		"n",
		"<leader>lq",
		vim.diagnostic.setloclist,
		{ buffer = bufnr, remap = false, silent = true, desc = "show loc list" }
	)
	vim.keymap.set("n", "<leader>rr", function()
		vim.lsp.buf.format({ async = true })
	end, { buffer = bufnr, remap = false, silent = true, desc = "lsp format file" })
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover({
			border = "rounded",
		})
	end, { buffer = bufnr, remap = false, silent = true, desc = "hover" })
	vim.keymap.set(
		"n",
		"<leader>fl",
		vim.diagnostic.open_float,
		{ buffer = bufnr, remap = false, silent = true, desc = "show diagnostic window" }
	)
	vim.keymap.set("n", "<leader>ls", function()
		vim.lsp.buf.signature_help({ border = "rounded" })
	end, { buffer = bufnr, remap = false, silent = true, desc = "show signature help" })

	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "lua_ls" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "pyright" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "jsonls" then
		client.server_capabilities.documentFormattingProvider = false
	end
end

require("mason").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua_ls",
		-- "gopls",
		-- "jsonls",
		-- "golangci-lint",
		-- "goimports",
		"stylua",
		-- "pyright",
		-- "ruff",
		-- "mypy",
		-- "biome",
	},
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls" },
	-- automatic_installation = true,,,
	-- automatic_enable = true,
})

vim.lsp.config("lua_ls", require("lsp.lua")(on_attach, capabilities))

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = false,
	signs = {
		active = true,
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = "󱩏 ",
			[vim.diagnostic.severity.HINT] = " ",
		},
		-- highlight = {
		--    [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
		--    [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
		--    [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
		--    [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
		-- }
	},
	underline = false,
	update_in_insert = false, -- Don’t update diagnostics while typing
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
		focusable = true,
		style = "minimal",
	},
})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		-- lua
		null_ls.builtins.formatting.stylua,
	},

	-- on_attach = function(client, bufnr)
	--     if client.server_capabilities.documentFormattingProvider then
	--         vim.api.nvim_create_autocmd("BufWritePre", {
	--             buffer = bufnr,
	--             callback = function()
	--                 vim.lsp.buf.format({ bufnr = bufnr })
	--             end,
	--         })
	--     end
	-- end,
})
