local hooks = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind
	if name == "blink.cmp" and (kind == "install" or kind == "update") then
		if not ev.data.active then
			vim.cmd.packadd("blink.cmp")
			vim.cmd.packadd("blink.lib")
		end
		require("blink.cmp").build():wait(60000)
	end
end
vim.api.nvim_create_autocmd("PackChanged", { callback = hooks })

vim.pack.add({
	"https://github.com/rafamadriz/friendly-snippets", -- dep
	"https://github.com/mikavilpas/blink-ripgrep.nvim", -- dep
	"https://github.com/xzbdmw/colorful-menu.nvim", -- dep
	"https://github.com/saghen/blink.lib",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
})

local kinds = {
	Function = "Function",
	Method = "Function",
	Constructor = "Structure",
	Field = "Identifier",
	Variable = "Identifier",
	Property = "Identifier",
	Class = "Type",
	Interface = "Type",
	Struct = "Structure",
	Enum = "Type",
	EnumMember = "Constant",
	Constant = "Constant",
	Keyword = "Keyword",
	Text = "String",
	Module = "Include",
	File = "Directory",
	Folder = "Directory",
	Snippet = "Macro",
}

for blink_kind, nvim_hl in pairs(kinds) do
	vim.api.nvim_set_hl(0, "BlinkCmpKind" .. blink_kind, { link = nvim_hl, default = true })
end

require("blink.cmp").build():wait(60000)

require("colorful-menu").setup()
require("blink-cmp").setup({
	keymap = {
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide" },
		["<CR>"] = { "accept", "fallback" },
		["<C-p>"] = { "select_prev" },
		["<C-n>"] = { "select_next" },
		["<C-k>"] = { "select_prev" },
		["<C-j>"] = { "select_next" },
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
		["<TAB>"] = { "select_next", "snippet_forward", "fallback" },
		["<S-TAB>"] = { "select_prev", "snippet_backward", "fallback" },
	},
	completion = {
		menu = {
			-- min_width = 100,
			max_height = 9999,
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
	cmdline = {
		completion = { menu = { auto_show = true } },
	}, -- will disable cmdline completions
	snippets = {
		-- preset = "luasnip",
	},
	signature = {
		enabled = true,
		window = {
			-- border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
			border = "rounded",
		},
	},
})

vim.keymap.set("i", "<C-g>", function()
	require("blink-cmp").show({ providers = { "ripgrep" } })
end, { desc = "", silent = true })

vim.api.nvim_set_hl(0, "BlinkCmpLabelDeprecated", { fg = "#2f3639", strikethrough = true })
--
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#111111", fg = "NONE", force = true })
vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#1e222a", fg = "NONE", force = true })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = "NONE", force = true })
--
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = "#111111", fg = "NONE", force = true })
vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", { bg = "NONE", force = true })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = "NONE", force = true })
