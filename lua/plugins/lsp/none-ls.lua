local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		--lua
		formatting.stylua,
		-- golang
		formatting.goimports,
		diagnostics.golangci_lint,
		-- js/ts related
		formatting.prettierd.with({
            -- extra_args = {},
			filetypes = {
				"javascript",
				"typescript",
				"json",
				"jsonc",
				"html",
				"css",
				"javascriptreact",
				"typescriptreact",
				"vue",
			},
		}),
		-- bash
		formatting.shfmt,
		-- diagnostics.shellcheck,
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

	-- this is an example how to separate different formatters for autosave format
	-- on_attach = function(client, bufnr)
	-- 	-- Auto-format on save, but only trigger it for stylua
	-- 	vim.api.nvim_create_autocmd("BufWritePre", {
	-- 		buffer = bufnr,
	-- 		callback = function()
	-- 			-- Only format with stylua for Lua files on save
	-- 			if vim.bo[bufnr].filetype == "lua" then
	-- 				null_ls.builtins.formatting.stylua._opts.async = false
	-- 				vim.lsp.buf.format({
	-- 					bufnr = bufnr,
	-- 					filter = function(c)
	-- 						return c.name == "null-ls" and c.server_capabilities.documentFormattingProvider
	-- 					end,
	-- 				})
	-- 			end
	-- 		end,
	-- 	})
	-- end,
})
