local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- shfmt
-- shellharden
-- biome
-- black
-- isort
-- prettier
-- prettierd
-- stylua

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		--formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		-- formatting.prettierd,
		-- formatting.black.with({ extra_args = { "--line-length", "200", "--skip-string-normalization", "--fast" } }),
		formatting.stylua,
		formatting.goimports,
		-- formatting.isort,
		-- formatting.shellharden,
		-- formatting.shfmt,
		-- formatting.rustywind.with({
		-- 	filetypes = {
		-- 		"javascript",
		-- 		"javascriptreact",
		-- 		"typescript",
		-- 		"typescriptreact",
		-- 		"vue",
		-- 		"svelte",
		-- 		"html",
		-- 		"htmldjango",
		-- 	},
		-- }),
		-- formatting.autopep8,
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
