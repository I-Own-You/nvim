return {
	timeout = vim.o.timeoutlen,
	default_mappings = true,
	mappings = {
		i = {
			j = {
				-- These can all also be functions
				k = "<Esc>",
				j = "<Esc>",
			},
		},
		c = {
			j = {
				k = "<Esc>",
				j = "<Esc>",
			},
		},
		t = {
			j = {
				k = false,
			},
		},
		v = {
			j = {
				k = false,
			},
		},
		s = {
			j = {
				k = "<Esc>",
			},
		},
	},
}
