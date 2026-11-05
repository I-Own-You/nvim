if true then
	vim.pack.add({
		"https://github.com/rafamadriz/friendly-snippets", -- dep
		"https://github.com/mikavilpas/blink-ripgrep.nvim", -- dep
		"https://github.com/xzbdmw/colorful-menu.nvim", -- dep
		"https://github.com/saghen/blink.lib",
		"https://github.com/saghen/blink.cmp",
	})

	require("colorful-menu").setup()
	local blink_cmp = require("blink.cmp")
	blink_cmp.build():pwait()
	blink_cmp.setup({
		keymap = {
			preset = "none",
			-- "fallback" should be removed if you have another identic keymap as below somehwere else,
			-- and its triggering after the blink cmp fire
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
			-- ["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-b>"] = {
				function(cmp)
					if cmp.is_documentation_visible() then
						cmp.scroll_documentation_up(4) -- scroll by 4 up
						return true -- dont give ^B into buffer
					end
				end,
				"fallback",
			},
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<TAB>"] = { "accept", "fallback" },
			["<C-u>"] = { "scroll_signature_up", "fallback" },
			["<C-d>"] = { "scroll_signature_down", "fallback" },
			["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
			["<C-g>"] = {
				function(cmp)
					cmp.show({ providers = { "ripgrep" } })
				end,
			},
		},
		completion = {
			menu = {
				-- min_width = 20,
				max_height = 15,
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
						kind_icon = {
							ellipsis = false,
							text = function(ctx)
								return ctx.kind_icon .. ctx.icon_gap
							end,
							highlight = function(ctx)
								return "BlinkCmpKind" .. ctx.kind
							end,
						},
						kind = {
							ellipsis = false,
							text = function(ctx)
								return ctx.kind
							end,
							highlight = function(ctx)
								return "BlinkCmpKind" .. ctx.kind
							end,
						},
					},
				},
				-- border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
				-- border = { "◤", "∿", "◥", "⌇", "◢", "∿", "◣", "⌇" },
				border = "rounded",
				scrollbar = false,
				auto_show = true,
			},
			list = {
				selection = {
					preselect = true,
					auto_insert = false,
				},
			},
			documentation = {
				window = {
					scrollbar = true,
					-- border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
					border = "rounded",
				},
				auto_show = true,
				auto_show_delay_ms = 200,
			},
			ghost_text = { enabled = true },
		},
		sources = {
			-- default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				ripgrep = {
					module = "blink-ripgrep",
					name = "Ripgrep",
					opts = {
						prefix_min_len = 0,
						-- project_root_marker = ".git" -- you could specify more: { ".git", "package.json", ".root" }
						-- fallback_to_regex_highlihgting = true
						-- toggles = {}, -- toggle plugin with keymap
						backend = {
							-- use = "ripgrep", -- ripgrep, gitgrep, gitgrep-or-ripgrep
							-- customize_icon_highlight = true,
							ripgrep = {
								context_size = 5, -- how many lines to show before/after the match in window
								-- max_filesize = "1M" -- largest file to search against
								-- project_root_fallback = true -- default to neovim cwd
								search_casing = "--ignore-case", -- more options rg --help for all the options
								additional_rg_options = {
									"--hidden",
									"--glob=!.git/", -- an example how to filter a folder
									"--glob=!.node_modules/", -- an example how to filter a folder
									-- "--glob=!*.log", -- an example how to filter a file
								}, 
								-- ignore_paths = {}, -- blink-rigprep specific ignore instead of .gitignore, .rg
								-- additional_paths = {} -- incude more paths to search agains, like outside root
							},
						},
						-- git_grep = {
						--     additional_gitgrep_options = {} -- opts for git grep command in clie
						-- }
						-- debug = false -- show info in :messages
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
				path = {
					opts = {
						show_hidden_files_by_default = true,
					},
				},
			},
		},
		cmdline = {
			completion = { menu = { auto_show = false } },
		}, 
		snippets = {
			-- preset = "luasnip",
		},
		signature = {
			enabled = true,
			window = {
				-- border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
				border = "rounded",
			},
			trigger = {
				show_on_trigger_character = false,
				show_on_insert_on_trigger_character = false,
			},
		},
	})
end
