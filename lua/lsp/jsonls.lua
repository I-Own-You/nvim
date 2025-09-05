return function(on_attach, capabilities)
	return {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
		-- setup = {
		-- 	commands = {
		-- 		Format = {
		-- 			function()
		-- 				vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
		-- 			end,
		-- 		},
		-- 	},
		-- },
	}
end
