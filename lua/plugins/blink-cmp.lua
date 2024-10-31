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
					cmp.select_prev()
				end
			end,
			"fallback",
		},
	},
	-- auto show doesnt work for me, idk why
	-- documentation = {
	-- 	auto_show = true,
	-- 	auto_show_delay_ms = 100,
	-- },
	highlight = {
		-- sets the fallback highlight groups to nvim-cmp's highlight groups
		-- useful for when your theme doesn't support blink.cmp
		-- will be removed in a future release, assuming themes add support
		use_nvim_cmp_as_default = true,
	},
	-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
	-- adjusts spacing to ensure icons are aligned
	nerd_font_variant = "mono",

	-- experimental auto-brackets support
	accept = { auto_brackets = { enabled = true } },

	-- experimental signature help support
	-- trigger = { signature_help = { enabled = true } },
}
