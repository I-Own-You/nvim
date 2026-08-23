return function(on_attach, capabilities)
	return {
		cmd = { "tsc", "--lsp", "--stdio" },
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
		},
		root_markers = {
			"tsconfig.json",
			"jsconfig.json",
			"package.json",
			".git",
		},
		on_attach = on_attach,
		capabilities = capabilities,
	}
end
