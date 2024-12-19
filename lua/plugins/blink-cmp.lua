return {
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
		["<TAB>"] = { "select_next", "snippet_forward", "fallback" },
		["<S-TAB>"] = { "select_prev", "snippet_backward", "fallback" },
	},
}
