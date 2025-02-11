return {
	keymap = {
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide" },
		["<CR>"] = { "accept", "fallback" },
		["<C-p>"] = { "select_prev" },
		["<C-n>"] = { "select_next" },
		["<C-k>"] = { "select_prev" },
		["<C-j>"] = { "select_next" },
		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },
		["<TAB>"] = { "select_next", "snippet_forward", "fallback" },
		["<S-TAB>"] = { "select_prev", "snippet_backward", "fallback" },
	},
	completion = {
		menu = {
			draw = {
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind", gap = 1 },
				},
				-- uncomment this when you will remove colorful-menu plugin and below function
				treesitter = { "lsp" },
			},
			border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
			scrollbar = false,
		},
		documentation = {
			window = {
				scrollbar = false,
				border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
			},
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		ghost_text = { enabled = true },
		list = {
			selection = {
				preselect = function(ctx)
					return ctx.mode ~= "cmdline"
					-- return ctx.mode ~= "cmdline" and not require("blink.cmp").snippet_active({ direction = 1 })
				end,
			},
		},
	},
	sources = {
		-- default = { "lsp", "path", "snippets", "buffer" },
		-- cmdline = {}, -- will disable cmdline completions
		providers = {
			ripgrep = {
				module = "blink-ripgrep",
				name = "Ripgrep",
				opts = {
					-- prefix_min_len = 3
					-- context_size = 5
					-- max_filesize = "1M"
					-- project_root_marker = ".git" -- you could specify more: { ".git", "package.json", ".root" }
					-- search_casing = "--ignore-case" -- "case-sensitive", "--smart-case"
					-- additional_rg_options = {},
					-- fallback_to_regex_highlihgting = true
					-- debug = false
				},
				transform_items = function(_, items)
					for _, item in ipairs(items) do
						item.labelDetails = {
							description = " 󰥨 ",
						}
					end
					return items
				end,
			},
		},
	},
	snippets = {
		-- preset = "luasnip",
	},
	signature = {
		enabled = true,
		window = {
			border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
		},
	},
}
