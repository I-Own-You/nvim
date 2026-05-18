return function(on_attach, capabilities)
	-- table.insert(capabilities, {}) -- in case i need to edit lsp settings for C
	return {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end
