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
				-- treesitter = { "lsp" },
				components = {
					label = {
						width = { fill = true, max = 60 },
						text = function(ctx)
							local highlights_info = require("colorful-menu").blink_highlights(ctx)
							if highlights_info ~= nil then
								-- Or you want to add more item to label
								return highlights_info.label
							else
								return ctx.label
							end
						end,
						highlight = function(ctx)
							local highlights = {}
							local highlights_info = require("colorful-menu").blink_highlights(ctx)
							if highlights_info ~= nil then
								highlights = highlights_info.highlights
							end
							for _, idx in ipairs(ctx.label_matched_indices) do
								table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
							end
							return highlights
						end,
					},
				},
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
		default = { "lsp", "path", "snippets", "buffer", "supermaven" },
		-- cmdline = {}, -- will disable cmdline completions
		providers = {
			supermaven = {
				name = "supermaven",
				module = "blink.compat.source",
				score_offset = 3,
				transform_items = function(_, items)
					for _, item in ipairs(items) do
						item.labelDetails = {
							description = "󱜙 ",
						}
					end
					return items
				end,
			},
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
		preset = "luasnip",
	},
	signature = {
		enabled = true,
		window = {
			border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
		},
	},
}
