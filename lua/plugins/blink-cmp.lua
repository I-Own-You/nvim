return {
	-- keymap = "default",
	keymap = {
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide" },
		["<CR>"] = { "select_and_accept", "fallback" },
		["<C-p>"] = { "select_prev" }, -- in case here is a problem, put 'fallback' after options
		["<C-n>"] = { "select_next" },
		["<C-k>"] = { "select_prev" }, -- in case here is a problem, put 'fallback' after options
		["<C-j>"] = { "select_next" },
		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },
		["<TAB>"] = {
			function(cmp)
				if cmp.is_in_snippet() then
					return cmp.snippet_forward()
				else
					return cmp.select_next()
				end
			end,
			"fallback",
		},
		["<S-TAB>"] = {
			function(cmp)
				if cmp.is_in_snippet() then
					return cmp.snippet_backward()
				else
					return cmp.select_prev()
				end
			end,
			"fallback",
		},
	},
}
