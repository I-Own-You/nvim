return function(on_attach, capabilities)
	return {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
				completion = {
					callSnippet = "Replace",
				},
			},
			telemetry = { enable = false },
		},
	}
end
