-- return {}
local t_i_d = {
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
}
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Ensure these plugins are loaded before lspconfig is configured
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- This is the correct entry for mason-tool-installer.nvim
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"nvim-lua/plenary.nvim",
		"nvimtools/none-ls.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		{
			"rachartier/tiny-inline-diagnostic.nvim",
			opts = t_i_d,
		},
		{
			"L3MON4D3/LuaSnip",
			enabled = true,
			dependencies = { "rafamadriz/friendly-snippets" },
			config = function()
				local luasnip = require("luasnip")
				-- luasnip.filetype_extend("htmldjango", { "html" })
				luasnip.filetype_extend("typescriptreact", { "html" })
				luasnip.filetype_extend("javascriptreact", { "html" })
				-- require("luasnip/loaders/from_vscode").lazy_load({ paths = "~/.config/nvim/snippets/" })
				require("luasnip/loaders/from_vscode").lazy_load()
				-- enable it if you will define lua snippets
				-- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
			end,
			build = "make install_jsregexp",
		},
	},
	config = function()
		local on_attach = function(client, bufnr)
			local keymap = vim.keymap

			keymap.set(
				"n",
				"gd",
				vim.lsp.buf.definition,
				{ buffer = bufnr, remap = false, silent = true, desc = "go to defintion" }
			)
			keymap.set(
				"i",
				"<C-s>",
				vim.lsp.buf.signature_help,
				{ buffer = bufnr, remap = false, silent = true, desc = "signature help" }
			)
			keymap.set(
				"n",
				"gr",
				vim.lsp.buf.references,
				{ buffer = bufnr, remap = false, silent = true, desc = "show references" }
			)
			keymap.set(
				"n",
				"gi",
				vim.lsp.buf.implementation,
				{ buffer = bufnr, remap = false, silent = true, desc = "show implementations" }
			)
			keymap.set(
				"n",
				"<leader>D",
				vim.lsp.buf.type_definition,
				{ buffer = bufnr, remap = false, silent = true, desc = "show type definition" }
			)
			keymap.set(
				"n",
				"gD",
				vim.lsp.buf.declaration,
				{ buffer = bufnr, remap = false, silent = true, desc = "show type declaration" }
			)
			keymap.set(
				"n",
				"<leader>re",
				vim.lsp.buf.rename,
				{ buffer = bufnr, remap = false, silent = true, desc = "lsp rename" }
			)
			keymap.set(
				"n",
				"<leader>ca",
				vim.lsp.buf.code_action,
				{ buffer = bufnr, remap = false, silent = true, desc = "code actions" }
			)
			keymap.set(
				"n",
				"<leader>lq",
				vim.diagnostic.setloclist,
				{ buffer = bufnr, remap = false, silent = true, desc = "show loc list" }
			)
			-- keymap.set(
			-- 	"n",
			-- 	"<leader>oo",
			-- 	vim.lsp.buf.document_symbol,
			-- 	{ buffer = bufnr, remap = false, silent = true, desc = "show document symbols" }
			-- )
			keymap.set("n", "<leader>rr", function()
				vim.lsp.buf.format({ async = true })
			end, { buffer = bufnr, remap = false, silent = true, desc = "lsp format file" })
			keymap.set("n", "K", function()
				vim.lsp.buf.hover({
					border = "rounded",
				})
			end, { buffer = bufnr, remap = false, silent = true, desc = "hover" })
			-- keymap.set("n", "ge", function()
			-- 	vim.diagnostic.jump({ count = 1, float = false })
			-- end, { buffer = bufnr, remap = false, silent = true, desc = "show next diagnostic" })
			-- keymap.set("n", "gE", function()
			-- 	vim.diagnostic.jump({ count = 1, float = false })
			-- end, { buffer = bufnr, remap = false, silent = true, desc = "show previous diagnostic" })
			keymap.set(
				"n",
				"<leader>fl",
				vim.diagnostic.open_float,
				{ buffer = bufnr, remap = false, silent = true, desc = "show diagnostic window" }
			)
			keymap.set("n", "<leader>ls", function()
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
		end

		require("mason").setup()
		require("mason-tool-installer").setup({
			ensure_installed = {
				"lua_ls",
				-- "gopls",
				"jsonls",
				-- "golangci-lint",
				-- "goimports",
				"stylua",
				"pyright",
				"ruff",
				"mypy",
			},
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "jsonls", "pyright" },
			-- automatic_installation = true,,,
			-- automatic_enable = true,
		})

		vim.lsp.config("lua_ls", require("lsp.lua")(on_attach, capabilities))
		vim.lsp.config("pyright", require("lsp.pyright")(on_attach, capabilities)) -- replace with ty when released
		vim.lsp.config("ruff", require("lsp.ruff")(on_attach, capabilities))

		vim.diagnostic.config({
			virtual_text = false,
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
				-- null_ls.builtins.diagnostics.golangci_lint,
				null_ls.builtins.formatting.stylua,
				-- null_ls.builtins.formatting.ruff,
				-- null_ls.builtins.formatting.goimports,
				null_ls.builtins.diagnostics.mypy,
			},

			on_attach = function(client, bufnr)
				if client.server_capabilities.documentFormattingProvider then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})
	end,
}
