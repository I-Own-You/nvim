require("user.options")
require("user.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- {
	-- 	"notken12/base46-colors",
	-- 	lazy = false,
	-- 	-- priority = 1000,
	-- 	config = function()
	-- 		vim.cmd([[colorscheme everblush]])
	--
	-- 		local hl = vim.api.nvim_set_hl
	-- 		hl(0, "FoldColumn", { fg = "#68B9B9", bg = "#141B1E" })
	-- 		hl(0, "PackageInfoOutdatedVersion", { fg = "#CDC61E", bg = "#141B1E" })
	-- 		hl(0, "Identifier", { fg = "#dadada", bg = "NONE", sp = "NONE" })
	-- 	end,
	-- },
	-- {
	-- 	"Everblush/nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd([[colorscheme everblush]])
	--
	-- 		local hl = vim.api.nvim_set_hl
	-- 		hl(0, "CmpItemAbbrMatch", { fg = "#67cbe7", bg = "NONE" })
	-- 		hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#67cbe7", bg = "NONE" })
	-- 		hl(0, "CmpItemAbbrDeprecated", { fg = "#8CCF7E", bg = "NONE", strikethrough = true })
	-- 		hl(0, "CmpItemAbbr", { fg = "NONE", bg = "NONE" })
	-- 		hl(0, "GitSignsAdd", { fg = "#8CCF7E", bg = "#141B1E" })
	-- 		hl(0, "GitSignsChange", { fg = "#67b0e8", bg = "#141B1E" })
	-- 		hl(0, "diffAdded", { fg = "#8CCF7E", bg = "#141B1E" })
	-- 		hl(0, "diffChanged", { fg = "#67b0e8", bg = "#141B1E" })
	-- 		hl(0, "DiffAdd", { fg = "#8CCF7E", bg = "#141B1E" })
	-- 		hl(0, "DiffChange", { fg = "#67b0e8", bg = "#141B1E" })
	-- 		hl(0, "TelescopeSelection", { fg = "NONE", bg = "#2c3333" })
	-- 		hl(0, "CursorLineNr", { fg = "#ffffff", bg = "NONE" })
	-- 		hl(0, "FlashLabel", { fg = "#ffffff", bg = "#FF007C" })
	-- 		hl(0, "FlashMatch", { fg = "#B1C0EF", bg = "#3E68D7" })
	-- 		hl(0, "FlashCurrent", { fg = "#443135", bg = "#FF966C" })
	-- 		hl(0, "GitSignsAddInline", { fg = "#8CCF7E", bg = "NONE" })
	-- 		hl(0, "GitSignsAddLnInline", { fg = "#8CCF7E", bg = "NONE" })
	-- 		hl(0, "GitSignsChangeInline", { fg = "#67b0e8", bg = "NONE" })
	-- 		hl(0, "GitSignsChangeLnInline", { fg = "#67b0e8", bg = "NONE" })
	-- 		hl(0, "GitSignsDeleteInline", { fg = "#e57474", bg = "NONE" })
	-- 		hl(0, "GitSignsDeleteLnInline", { fg = "#e57474", bg = "NONE" })
	-- 		hl(0, "GitSignsDeleteVirtLnInline", { fg = "#e57474", bg = "NONE" })
	-- 		hl(0, "@operator", { fg = "#67cbe7", bg = "NONE" })
	-- 		hl(0, "@exception", { fg = "#e57474", bg = "NONE" })
	-- 		hl(0, "Search", { fg = "#B1C0EF", bg = "#3E68D7" })
	-- 		hl(0, "IncSearch", { fg = "#ffffff", bg = "#FF007C" })
	-- 		hl(0, "QuickFixLine", { fg = "NONE", bg = "NONE" })
	-- 		hl(0, "QfLineNr", { fg = "#C4DE72", bg = "NONE" })
	-- 		hl(0, "Visual", { fg = "NONE", bg = "#2c3333" })
	-- 		hl(0, "CustomSpectreSearch", { fg = "#FF007C", bg = "NONE" })
	-- 		hl(0, "CustomSpectreReplace", { fg = "#5ACB43", bg = "NONE" })
	-- 	end,
	-- },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "moon",
				-- transparent = true, -- Enable this to disable setting the background color
			})
			vim.cmd([[colorscheme tokyonight-night]])

			local hl = vim.api.nvim_set_hl
			hl(0, "CustomSpectreSearch", { fg = "#FF007C", bg = "NONE" })
			hl(0, "CustomSpectreReplace", { fg = "#5ACB43", bg = "NONE" })
			hl(0, "TelescopeBorder", { fg = "#16161E", bg = "#16161E" })
			-- hl(0, "TelescopeNormal", { fg = "#5ACB43", bg = "NONE" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPost",
		config = function()
			require("plugins.lsp.handlers").setup()
		end,
	},
	{
		"williamboman/mason.nvim",
		event = "BufReadPost",
		-- use({ "williamboman/nvim-lsp-installer" }) -- lsp installer
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		build = ":MasonUpdate",
		config = function()
			require("plugins.lsp.mason")
		end,
	},
	{
		-- "jose-elias-alvarez/null-ls.nvim",
		"nvimtools/none-ls.nvim",
		event = "BufReadPost",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.lsp.null-ls")
		end,
	},
	{
		"hrsh7th/cmp-cmdline",
		event = "CmdlineEnter",
	},
	{
		"hrsh7th/cmp-buffer",
		event = "CmdlineEnter",
	},
	{
		"hrsh7th/cmp-path",
		event = "InsertEnter",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		event = "InsertEnter",
	},
	{
		"saadparwaiz1/cmp_luasnip",
		event = "InsertEnter",
	},
	{
		"lukas-reineke/cmp-rg",
		event = "InsertEnter",
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("cmp").setup(require("plugins.cmp"))
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		commit = "07f217ff03be671e7ec0f2f226e2b80c587a3f6c", -- NOTE: change it when plugin works again
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			local luasnip = require("luasnip")
			luasnip.filetype_extend("htmldjango", { "html" })
			luasnip.filetype_extend("typescript", { "javascript" })
			require("luasnip/loaders/from_vscode").lazy_load()
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
		end,
		build = "make install_jsregexp",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		config = function()
			require("nvim-treesitter.configs").setup(require("plugins.treesiter"))
		end,
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
			"nvim-telescope/telescope.nvim",
		},
		cmd = "FzfLua",
		keys = {
			{ mode = "n", "<A-f>", ":FzfLua files<CR>", desc = "find files", { silent = true } },
			{
				mode = "n",
				"<A-a>",
				":lua require('fzf-lua').files({fd_opts = '--color=never --type f --hidden --follow --no-ignore'})<CR>",
				desc = "find hidden/ignored files",
				{ silent = true },
			},
			{ mode = "n", "<leader>bb", desc = "buffers list", ":FzfLua buffers<CR>", { silent = true } },
			{ mode = "n", "<leader>ta", desc = "tabs list", ":FzfLua tabs<CR>", { silent = true } },
			{ mode = "n", "<leader>ho", desc = "old files", ":FzfLua oldfiles<CR>", { silent = true } },
			{ mode = "n", "<leader>ll", desc = "lines from all buffers", ":FzfLua lines<CR>", { silent = true } },
			{ mode = "n", "<leader>gst", desc = "git status", ":FzfLua git_status<CR>", { silent = true } },
			{ mode = "n", "<leader>gls", desc = "git files", ":FzfLua git_files<CR>", { silent = true } },
			{ mode = "n", "<leader>fgl", desc = "project commits", ":FzfLua git_commits<CR>", { silent = true } },
			{ mode = "n", "<leader>fgb", desc = "buffer commits", ":FzfLua git_bcommits<CR>", { silent = true } },
			{ mode = "n", "<leader>gbb", desc = "git branches", ":FzfLua git_branches<CR>", { silent = true } },
			{ mode = "n", "<leader>gsh", desc = "git stash list", ":FzfLua git_stash<CR>", { silent = true } },
			{ mode = "n", "<leader>gt", desc = "git tags", ":FzfLua git_tags<CR>", { silent = true } },
			{ mode = "n", "<leader>oo", desc = "lsp symbols", ":FzfLua lsp_document_symbols<CR>", { silent = true } },
			{
				mode = "n",
				"<leader>tt",
				":lua require('fzf-lua').lsp_live_workspace_symbols({ file_ignore_patterns = { '^node_modules/' }, })<CR>",
				desc = "live workspace symbols",
				{ silent = true },
			},
			{ mode = "n", "<leader>ka", desc = "code actions", ":FzfLua lsp_code_actions<CR>", { silent = true } },
			{ mode = "n", "gR", ":FzfLua lsp_finder<CR>", desc = "all lsp refs", { silent = true } },
			{
				mode = "n",
				"<leader>lw",
				desc = "project diagnostics",
				":FzfLua lsp_workspace_diagnostics<CR>",
				{ silent = true },
			},
			{ mode = "n", "<leader>bt", desc = "fzflua builtins", ":FzfLua builtin<CR>", { silent = true } },
			{ mode = "n", "<leader>ht", desc = "help tags", ":FzfLua help_tags<CR>", { silent = true } },
			{ mode = "n", "<leader>hc", desc = "comand history", ":FzfLua command_history<CR>", { silent = true } },
			{ mode = "n", "<leader>hs", desc = "search history", ":FzfLua search_history<CR>", { silent = true } },
			{ mode = "n", "<leader>fk", desc = "keymaps", ":FzfLua keymaps<CR>", { silent = true } },
			{ mode = "n", "<leader>ol", desc = "project tags", ":FzfLua tags<CR>", { silent = true } },
			{ mode = "n", "<leader>tb", desc = "buffer tags", ":FzfLua btags<CR>", { silent = true } },
			{ mode = "n", "<leader>tw", desc = "grep tag word", ":FzfLua tags_grep_cword<CR>", { silent = true } },
			{ mode = "n", "<leader>tl", desc = "live tag", ":FzfLua tags_live_grep<CR>", { silent = true } },
			{ mode = "n", "<leader><leader>", ":FzfLua grep_project<CR>", desc = "grep with rules", { silent = true } },
			{
				mode = "n",
				"<leader>a",
				":lua require('fzf-lua').grep_project({rg_opts = '--hidden --no-ignore --column --line-number --no-heading --color=always --smart-case --max-columns=4096'})<CR>",
				desc = "grep all",
				{ silent = true },
			},
			{ mode = "n", "<leader>gw", ":FzfLua grep_cword<CR>", desc = "grep word", { silent = true } },
			{ mode = "n", "<leader>lb", ":FzfLua lgrep_curbuf<CR>", desc = "buffer lines", { silent = true } },
		},
		config = function()
			require("fzf-lua").setup(require("plugins.fzf-lua"))
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "BufReadPost",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("lualine").setup(require("plugins.lualine"))
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		enabled = true,
		commit = "9637670896b68805430e2f72cf5d16be5b97a22a",
		config = function()
			require("indent_blankline").setup(require("plugins.indent_blankline"))
			-- vim.cmd([[highlight IndentBlanklineContextStart guisp=#8FBCBB gui=underline]])
			vim.g.indent_blankline_filetype_exclude = { "dashboard" }
			vim.keymap.set("n", "<leader>kk", function()
				local ok, start = require("indent_blankline.utils").get_current_context(
					vim.g.indent_blankline_context_patterns,
					vim.g.indent_blankline_use_treesitter_scope
				)

				if ok then
					vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
					vim.cmd([[normal! _]])
				end
			end, { silent = true, desc = "go to parent node" })
		end,
	},
	{
		"kevinhwang91/rnvimr",
		keys = {
			{ "<leader>e", mode = "n", ":RnvimrToggle<cr>", desc = "open ranger" },
		},
		init = function()
			vim.g.rnvimr_enable_ex = 1 -- Make Ranger to be hidden after picking a file--
			vim.g.rnvimr_enable_picker = 1 -- Replace `$EDITOR` candidate with this command to open the selected file"
			vim.g.rnvimr_edit_cmd = "drop"
			vim.g.rnvimr_draw_border = 0 -- Disable a border for floating window"
			vim.g.rnvimr_hide_gitignore = 1 -- Hide the files included in gitignore"
			vim.g.rnvimr_border_attr = { fg = 14, bg = -1 } -- Change the border's color"
			vim.g.rnvimr_enable_bw = 1 -- Make Neovim wipe the buffers corresponding to the files deleted by Ranger"
			vim.g.rnvimr_shadow_winblend = 70 -- Add a shadow window, value is equal to 100 will disable shadow"
			vim.g.rnvimr_ranger_cmd = { "ranger", "--cmd=set draw_borders true" } -- Draw border with both"

			vim.g.rnvimr_layout = {
				relative = "editor",
				width = vim.o.columns,
				height = vim.o.lines - 2,
				col = 0,
				row = 0,
				style = "minimal",
			}
		end,
	},
	{
		"nacro90/numb.nvim",
		event = "BufReadPost",
		opts = {
			-- show_numbers = true, -- Enable 'number' for the window while peeking
			-- show_cursorline = true, -- Enable 'cursorline' for the window while peeking
			-- hide_relativenumbers = true -- Enable turning off 'relativenumber' for the window while peeking
			number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
			centered_peeking = true, -- Peeked line will be centered relative to window
		},
	},
	{
		"kevinhwang91/nvim-bqf",
		event = "BufReadPost",
		opts = {
			preview = {
				winblend = 0,
			},
		},
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPost",
		opts = {
			filetypes = {
				-- "lua",
				"typescript",
				"javascript",
				"typescriptreact",
				"javascriptreact",
				"css",
				"scss",
				"sass",
				"text",
			},
			user_default_options = {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = true, -- "Name" codes like Blue or blue
				RRGGBBAA = false, -- #RRGGBBAA hex codes
				AARRGGBB = false, -- 0xAARRGGBB hex codes
				rgb_fn = false, -- CSS rgb() and rgba() functions
				hsl_fn = false, -- CSS hsl() and hsla() functions
				css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes for `mode`: foreground, background,  virtualtext
				mode = "background", -- Set the display mode.
				-- Available methods are false / true / "normal" / "lsp" / "both"
				-- True is same as normal
				tailwind = true, -- Enable tailwind colors
				-- parsers can contain values used in |user_default_options|
				sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
				virtualtext = "■",
				-- update color values even if buffer is not focused
				-- example use: cmp_menu, cmp_docs
				always_update = false,
			},
			-- all the sub-options of filetypes apply to buftypes
			buftypes = {},
		},
	},
	{
		"numToStr/Comment.nvim",
		event = "BufReadPost",
		opts = {
			ignore = "^$",
		},
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
			local ft = require("Comment.ft")
			ft.scss = { "// %s", "/* %s */" }
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPost",
		keys = {
			{
				mode = "n",
				"<A-n>",
				":Gitsigns next_hunk<cr>",
				desc = "next git change",
				{ silent = true },
			},
			{
				mode = "n",
				"<A-p>",
				":Gitsigns prev_hunk<cr>",
				desc = "previous git change",
				{ silent = true },
			},
			{ mode = "n", "<leader>bl", ":Gitsigns blame_line<cr>", desc = "blame line", { silent = true } },
			{
				mode = "n",
				"<leader>ph",
				":Gitsigns preview_hunk<cr>",
				desc = "preview float window change",
				{ silent = true },
			},
			{
				mode = "n",
				"<leader>pih",
				":Gitsigns preview_hunk_inline<cr>",
				desc = "preview inline change",
				{ silent = true },
			},
			{
				mode = "n",
				"<leader>sh",
				":Gitsigns stage_hunk<cr>",
				desc = "stage inline change",
				{ silent = true },
			},
			{ mode = "n", "<leader>sb", ":Gitsigns stage_buffer<cr>", desc = "stage buffer", { silent = true } },
			{
				mode = "n",
				"<leader>ush",
				":Gitsigns undo_stage_hunk<cr>",
				desc = "unstage inline change",
				{ silent = true },
			},
			{
				mode = "n",
				"<leader>rbb",
				":Gitsigns reset_buffer<cr>",
				desc = "redo git buffer changes",
				{ silent = true },
			},
			{
				mode = "n",
				"<leader>rbi",
				":Gitsigns reset_buffer_index<cr>",
				desc = "unstage buffer",
				{ silent = true },
			},
			{
				mode = "n",
				"<leader>rh",
				":Gitsigns reset_hunk<cr>",
				desc = "redo git inline change",
				{ silent = true },
			},
			{ mode = "n", "<leader>gsw", ":Gitsigns show ", desc = "git show", { noremap = true } },
			{ mode = "n", "<leader>gid", ":Gitsigns diffthis ", desc = "git diff", { noremap = true } },
		},
		config = function()
			require("gitsigns").setup(require("plugins.gitsigns"))
		end,
	},
	{
		"moll/vim-bbye",
		keys = {
			{ "<leader>q", mode = "n", ":Bdelete!<cr>", desc = "delete buffer" },
		},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
			ts_config = {
				lua = { "string", "source" },
				javascript = { "string", "template_string" },
			},
			disable_filetype = { "TelescopePrompt", "spectre_panel", "vim" },
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
				offset = 0, -- Offset from pattern match
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "PmenuSel",
				highlight_grey = "LineNr",
			},
		},
		-- config = function()
		-- 	require("nvim-autopairs").setup(require("plugins.autopairs"))
		-- local cmp_autopairs = require "nvim-autopairs.completion.cmp"
		-- local cmp = require('cmp')
		-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {})
		-- end,
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter" },
		opts = {
			use_default_keymaps = false,
			max_join_length = 999,
		},
		keys = {
			{ "<leader>j", mode = "n", "<cmd>TSJToggle<cr>", desc = "toggle node split", { silent = true } },
		},
	},
	{
		"andymass/vim-matchup",
		event = "BufReadPost",
		config = function()
			-- vim.cmd([[highlight MatchParen guibg=#5C4E4E]])
			-- vim.cmd([[highlight MatchParen gui=NONE]])
		end,
	},
	{
		"jedrzejboczar/possession.nvim",
		keys = {
			{
				"<leader>sl",
				mode = "n",
				":Telescope possession list<CR>",
				desc = "Open sessions list",
				{ noremap = true, silent = true },
			},
			{ "<leader>ss", mode = "n", ":PossessionSave ", desc = "save session", { noremap = true } },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			silent = false,
			load_silent = true,
			debug = false,
			logfile = false,
			prompt_no_cr = false,
			autosave = {
				current = true, -- or fun(name): boolean
				tmp = false, -- or fun(): boolean
				tmp_name = "tmp", -- or fun(): string
				on_load = true,
				on_quit = true,
			},
			commands = {
				save = "PossessionSave",
				load = "PossessionLoad",
				rename = "PossessionRename",
				close = "PossessionClose",
				delete = "PossessionDelete",
				show = "PossessionShow",
				list = "PossessionList",
				migrate = "PossessionMigrate",
			},
			hooks = {
				before_save = function(name)
					return {}
				end,
				after_save = function(name, user_data, aborted) end,
				before_load = function(name, user_data)
					return user_data
				end,
				after_load = function(name, user_data) end,
			},
			plugins = {
				close_windows = {
					hooks = { "before_save", "before_load" },
					preserve_layout = true, -- or fun(win): boolean
					match = {
						floating = true,
						buftype = {},
						filetype = {},
						custom = false, -- or fun(win): boolean
					},
				},
				-- delete_hidden_buffers = {
				-- 	hooks = {
				-- 		"before_load",
				-- 		vim.o.sessionoptions:match("buffer") and "before_save",
				-- 	},
				-- 	force = false, -- or fun(buf): boolean
				-- },
				nvim_tree = true,
				tabby = true,
				dap = true,
				delete_buffers = true,
				delete_hidden_buffers = false,
			},
			telescope = {
				list = {
					default_action = "load",
					mappings = {
						save = { n = "<c-s>", i = "<c-s>" },
						load = { n = "<CR>", i = "<CR>" },
						delete = { n = "<c-x>", i = "<c-x>" },
						rename = { n = "<c-r>", i = "<c-r>" },
					},
				},
			},
		},
	},
	{
		"debugloop/telescope-undo.nvim",
		opts = {
			extensions = {
				import = {
					insert_at_top = true,
				},
			},
		},
		dependencies = {
			{
				"nvim-telescope/telescope.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
		},
		keys = {
			{
				"<leader>tu",
				"<cmd>Telescope undo<cr>",
				desc = "undo history",
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("undo")
		end,
	},
	{
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup()
		end,
		keys = {
			{ "<leader>td", mode = "n", ":TodoQuickFix<CR>", desc = "open todos", { noremap = true } },
		},
	},
	{
		"rbong/vim-flog",
		dependencies = { "tpope/vim-fugitive" },
		keys = {
			{ "<leader>fgg", mode = "n", ":Flog ", desc = "open floggit", { noremap = true } },
			{ "<leader>fb", mode = "n", ":Floggit ", desc = "open flog branch", { noremap = true } },
			{
				"<leader>gc",
				mode = "n",
				':Floggit commit -m ""<left>',
				desc = "open flog branch commit",
				{ noremap = true },
			},
			{ "<leader>gp", mode = "n", ":Floggit push<CR>", desc = "floggit push", { silent = true } },
			{ "<leader>fs", mode = "n", ":Flogsplit ", desc = "flog split", { noremap = true } },
		},
	},
	{
		"windwp/nvim-ts-autotag",
		ft = {
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"tsx",
			"jsx",
			"rescript",
			"xml",
			"php",
			"markdown",
			"astro",
			"glimmer",
			"handlebars",
			"hbs",
			"djangohtml",
			"htmldjango",
		},
		opts = {
			filetypes = {
				"html",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				"svelte",
				"vue",
				"tsx",
				"jsx",
				"rescript",
				"xml",
				"php",
				"markdown",
				"astro",
				"glimmer",
				"handlebars",
				"hbs",
				"djangohtml",
				"htmldjango",
			},
			skip_tags = {
				"area",
				"base",
				"br",
				"col",
				"command",
				"embed",
				"hr",
				"img",
				"slot",
				"input",
				"keygen",
				"link",
				"meta",
				"param",
				"source",
				"track",
				"wbr",
				"menuitem",
			},
		},
	},
	-- {
	-- 	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	-- 	enabled = true,
	-- 	config = function()
	-- 		-- virtual_text is disabled in handlers.lua
	-- 		-- vim.diagnostic.config({ virtual_text = false })
	-- 		-- vim.diagnostic.config({ virtual_lines = true })
	-- 		-- vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
	-- 		vim.diagnostic.config({ virtual_lines = { highlight_whole_line = false } })
	-- 		require("lsp_lines").setup({})
	-- 	end,
	-- },
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		config = function()
			require("lsp_signature").setup(require("plugins.lsp-signature"))
		end,
	},
	-- {
	-- 	"akinsho/bufferline.nvim",
	-- 	enabled = false,
	-- 	config = function()
	-- 		require("bufferline").setup(require("plugins.bufferline"))
	-- 	end,
	-- },
	{
		"smjonas/inc-rename.nvim",
		event = "InsertEnter",
		opts = {
			cmd_name = "IncRename", -- the name of the command
			hl_group = "Substitute", -- the highlight group used for highlighting the identifier's new name
			preview_empty_name = false, -- whether an empty new name should be previewed; if false the command preview will be cancelled instead
			show_message = true, -- whether to display a `Renamed m instances in n files` message after a rename operation
			input_buffer_type = nil, -- the type of the external input buffer to use (the only supported value is currently "dressing")
			post_hook = nil, -- callback to run after renaming, receives the result table (from LSP handler) as an argument
		},
	},
	{
		"folke/flash.nvim",
		event = "BufReadPost",
		---@type Flash.Config
		keys = {
			{ "s", mode = "n", "<cmd>lua require('flash').jump()<CR>", { noremap = true } },
			{ "s", mode = "x", "<cmd>lua require('flash').jump()<CR>", { noremap = true } },
			{ "s", mode = "o", "<cmd>lua require('flash').jump()<CR>", { noremap = true } },
			{ "S", mode = "n", "<cmd>lua require('flash').treesitter()<CR>", { noremap = true } },
			{ "S", mode = "o", "<cmd>lua require('flash').treesitter()<CR>", { noremap = true } },
			-- { "S", mode = "x", "<cmd>lua require('flash').treesitter()<CR>", { noremap = true } },
			{ "r", mode = "o", "<cmd>lua require('flash').remote()<CR>", { noremap = true } },
		},
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			local actions = require("diffview.actions")
			require("diffview").setup({
				keymaps = {
					view = {
						{ "n", "<A-n>", "]c", { desc = "Next hunk / entry" } },
						{ "n", "<A-p>", "[c", { desc = "Prev hunk / entry" } },
					},
					file_history_panel = {
						{
							"n",
							"<cr>",
							actions.focus_entry,
							{ desc = "Open and focus the diff for the selected entry." },
						},
						{
							"n",
							"o",
							actions.focus_entry,
							{ desc = "Open and focus the diff for the selected entry." },
						},
						{
							"n",
							"l",
							actions.focus_entry,
							{ desc = "Open and focus the diff for the selected entry." },
						},
						{
							"n",
							"<2-LeftMouse>",
							actions.focus_entry,
							{ desc = "Open and focus the diff for the selected entry." },
						},
					},
				},
			})
		end,
		keys = {
			-- { "<leader>mt", mode = "n", ":DiffviewOpen<CR>", desc = "open diff view" },
			-- { "<leader>mf", mode = "n", ":DiffviewFileHistory<CR>", desc = "open diff view for single file" },
			-- { "<leader>mk", mode = "n", ":DiffviewClose<CR>", desc = "close diff view" },

			{
				"<leader>mt",
				mode = "n",
				':lua require("utility_functions").diffViewOpen()<CR>',
				desc = "open diff view",
			},
			{
				"<leader>mf",
				mode = "n",
				':lua require("utility_functions").diffViewFileHistoryOpen()<CR>',
				desc = "open diff view for single file",
			},
			{
				"<leader>mk",
				mode = "n",
				':lua require("utility_functions").diffViewClose()<CR>',
				desc = "close diff view",
			},
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		event = "BufReadPost",
		-- look into handlers.lua/keymaps.lua there is code for ufo.nvim, in case you delete the pluign
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim", -- tweak for right columnt that shows redundant digits
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						segments = {
							{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
							{ text = { "%s" }, click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
						},
					})
				end,
			},
		},
		init = function()
			vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
			vim.opt.foldcolumn = "1" -- '0' is not bad
			vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.opt.foldlevelstart = 99
			vim.opt.foldenable = true
		end,
		config = function()
			require("ufo").setup(require("plugins.ufo"))
			vim.keymap.set("n", "zR", function()
				require("ufo").openAllFolds()
			end, { silent = true })
			vim.keymap.set("n", "zM", function()
				require("ufo").closeAllFolds()
			end, { silent = true })
		end,
	},
	{
		"utilyre/barbecue.nvim",
		event = "BufReadPost",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"kyazdani42/nvim-web-devicons",
		},
		opts = {},
		keys = {
			{
				"<leader>kl",
				mode = "n",
				":lua require('barbecue.ui').navigate(-)<left>",
				desc = "go up context",
				{ silent = true },
			},
		},
	},
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		opts = {
			theme = "hyper", --  theme is doom and hyper default is hyper
			-- disable_move = false    --  default is false disable move keymap for hyper
			-- shortcut_type = 'letter'   --  shorcut type 'letter' or 'number'
			-- change_to_vcs_root =  -- default is false,for open file in hyper mru. it will change to the root of vcs
			config = {
				-- header -- type is table def
				-- week_header = {
				--   enable  --boolean use a week header
				--   concat  --concat string after time string line
				--   append  --table append after time string line
				-- },
				-- disable_move  -- boolean default is false disable move key

				-- week_header = {
				--   enable = true,
				-- },
				header = {
					"",
					" ⣿⣿⣷⡁⢆⠈⠕⢕⢂⢕⢂⢕⢂⢔⢂⢕⢄⠂⣂⠂⠆⢂⢕⢂⢕⢂⢕⢂⢕⢂ ",
					" ⣿⣿⣿⡷⠊⡢⡹⣦⡑⢂⢕⢂⢕⢂⢕⢂⠕⠔⠌⠝⠛⠶⠶⢶⣦⣄⢂⢕⢂⢕ ",
					" ⣿⣿⠏⣠⣾⣦⡐⢌⢿⣷⣦⣅⡑⠕⠡⠐⢿⠿⣛⠟⠛⠛⠛⠛⠡⢷⡈⢂⢕⢂ ",
					" ⠟⣡⣾⣿⣿⣿⣿⣦⣑⠝⢿⣿⣿⣿⣿⣿⡵⢁⣤⣶⣶⣿⢿⢿⢿⡟⢻⣤⢑⢂ ",
					" ⣾⣿⣿⡿⢟⣛⣻⣿⣿⣿⣦⣬⣙⣻⣿⣿⣷⣿⣿⢟⢝⢕⢕⢕⢕⢽⣿⣿⣷⣔ ",
					" ⣿⣿⠵⠚⠉⢀⣀⣀⣈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣗⢕⢕⢕⢕⢕⢕⣽⣿⣿⣿⣿ ",
					" ⢷⣂⣠⣴⣾⡿⡿⡻⡻⣿⣿⣴⣿⣿⣿⣿⣿⣿⣷⣵⣵⣵⣷⣿⣿⣿⣿⣿⣿⡿ ",
					" ⢌⠻⣿⡿⡫⡪⡪⡪⡪⣺⣿⣿⣿⣿⣿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃ ",
					" ⠣⡁⠹⡪⡪⡪⡪⣪⣾⣿⣿⣿⣿⠋⠐⢉⢍⢄⢌⠻⣿⣿⣿⣿⣿⣿⣿⣿⠏⠈ ",
					" ⡣⡘⢄⠙⣾⣾⣾⣿⣿⣿⣿⣿⣿⡀⢐⢕⢕⢕⢕⢕⡘⣿⣿⣿⣿⣿⣿⠏⠠⠈ ",
					" ⠌⢊⢂⢣⠹⣿⣿⣿⣿⣿⣿⣿⣿⣧⢐⢕⢕⢕⢕⢕⢅⣿⣿⣿⣿⡿⢋⢜⠠⠈ ",
					" ⠄⠁⠕⢝⡢⠈⠻⣿⣿⣿⣿⣿⣿⣿⣷⣕⣑⣑⣑⣵⣿⣿⣿⡿⢋⢔⢕⣿⠠⠈ ",
					" ⠨⡂⡀⢑⢕⡅⠂⠄⠉⠛⠻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢋⢔⢕⢕⣿⣿⠠⠈ ",
					" ⠄⠪⣂⠁⢕⠆⠄⠂⠄⠁⡀⠂⡀⠄⢈⠉⢍⢛⢛⢛⢋⢔⢕⢕⢕⣽⣿⣿⠠⠈ ",
					"",
				},
				shortcut = {
					{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
					{
						icon = " ",
						icon_hl = "@variable",
						desc = "Files",
						group = "Label",
						action = "FzfLua files",
						key = "f",
					},
					-- {
					--   desc = ' Apps',
					--   group = 'DiagnosticHint',
					--   action = 'Telescope app',
					--   key = 'a',
					-- },
					{
						desc = " sessions",
						group = "Number",
						action = "Telescope possession list",
						key = "s",
					},
					{
						desc = "󰳭 bye bye",
						group = "DevIconScheme",
						action = "exit",
						key = "q",
					},
				},
			}, --  config used for theme
			-- hide = {
			--   statusline = true,    -- hide statusline default is true
			--   tabline = true,       -- hide the tabline
			--   winbar = true,        -- hide winbar
			-- },
			-- preview = {
			-- command       -- preview command
			-- file_path     -- preview file path
			-- file_height   -- preview file height
			-- file_width    -- preview file width
			-- },
		},
		dependencies = { { "kyazdani42/nvim-web-devicons" } },
	},
	{
		"luckasRanarison/nvim-devdocs",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{ "<leader>dd", ":DevdocsOpenFloat ", desc = "open devdocs" },
		},
		opts = {
			-- dir_path = vim.fn.stdpath("data") .. "/devdocs", -- installation directory
			telescope = {}, -- passed to the telescope picker
			telescope_alt = { -- when searching globally without preview
				layout_config = {
					width = 75,
				},
			},
			float_win = { -- passed to nvim_open_win(), see :h api-floatwin
				relative = "editor",
				height = 25,
				width = 100,
				border = "rounded",
			},
			wrap = true, -- text wrap, only applies to floating window
			--  install them: html, javascript, npm, react, express, react-router, css, typescript, python, django, tailwindcss, dom
			-- previewer_cmd = "glow",
			cmd_args = { "-s", "dark", "-w", "80" },
			cmd_ignore = {}, -- ignore cmd rendering for the listed docs
			picker_cmd = false, -- use cmd previewer in picker preview
			picker_cmd_args = {}, -- example using glow: { "-s", "dark", "-w", "50" }
			mappings = { -- keymaps for the doc buffer
				open_in_browser = "",
			},
			ensure_installed = {}, -- get automatically installed
			after_open = function(bufnr)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", ":close<CR>", {})
			end, -- callback that runs after the Devdocs window is opened. Devdocs buffer ID will be passed in
		},
	},
	{
		"ellisonleao/glow.nvim",
		opts = {
			-- glow_path = "", -- will be filled automatically with your glow bin in $PATH, if any
			-- install_path = "~/.local/bin", -- default path for installing glow binary
			border = "solid", -- floating window border: | 'shadow' | 'none' | 'double' | 'rounded' | 'solid' | 'single' | 'rounded'
			-- style = "dark|light", -- filled automatically with your current editor background, you can override using glow json style
			pager = false,
			width = 100,
			height = 100,
			width_ratio = 0.7, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
			height_ratio = 0.7,
		},
		cmd = "Glow",
	},
	{
		"kevinhwang91/nvim-fundo",
		dependencies = { "kevinhwang91/promise-async" },
		event = "BufReadPost",
		init = function()
			vim.o.undofile = true
		end,
		build = function()
			require("fundo").install()
		end,
		opts = {
			-- archives_dir = vim.fn.stdpath("cache") .. path.separator .. "fundo", -- default
			limit_archives_size = 64, --defualt was 512
			-- fdssfsd
		},
	},
	{
		"piersolenski/wtf.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		-- init = function ()
		--   vim.g["wtf_hooks"] = {
		--     request_started = function()
		--       vim.cmd("hi StatusLine ctermbg=NONE ctermfg=yellow")
		--     end,
		--     request_finished = vim.schedule_wrap(function()
		--       vim.cmd("hi StatusLine ctermbg=NONE ctermfg=NONE")
		--     end)
		--   }
		-- end, -- for gpt, the future
		-- also look for lualine hook in the docs, when you will setup chatgpt
		opts = {
			-- Default AI popup type
			popup_type = "popup", -- "popup" | "horizontal" | "vertical",
			-- An alternative way to set your OpenAI api key
			-- openai_api_key = "sk-xxxxxxxxxxxxxx",
			-- ChatGPT Model
			-- openai_model_id = "gpt-3.5-turbo",
			-- Set your preferred language for the response
			language = "english",
			-- Any additional instructions
			-- additional_instructions = "Start the reply with 'OH HAI THERE'",
			-- Default search engine, can be overridden by passing an option to WtfSeatch
			-- search_engine = "google" | "duck_duck_go" | "stack_overflow" | "github",
		},
		keys = {
			{ "<leader>wt", ":WtfSearch ", desc = "open wtf search" },
		},
	},
	{
		-- NOTE: you can also make for another lang the import, look at github of the extension, in case
		"piersolenski/telescope-import.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = {
			{ "<leader>ii", "<cmd>Telescope import<CR>", desc = "open imports" },
		},
		config = function()
			require("telescope").load_extension("import")
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
		build = "./kitty/install-kittens.bash",
		opts = {
			cursor_follows_swapped_bufs = true,
			-- at_edge = 'stop',
		},
		keys = {
			-- move between buffers
			-- commented because i dont need the cycle option, so it has a delay anyway, so its slower than neovim builtin
			-- { "<C-h>", '<cmd>lua require("smart-splits").move_cursor_left()<CR>' },
			-- { "<C-j>", '<cmd>lua require("smart-splits").move_cursor_down()<CR>' },
			-- { "<C-k>", '<cmd>lua require("smart-splits").move_cursor_up()<CR>' },
			-- { "<C-l>", '<cmd>lua require("smart-splits").move_cursor_right()<CR>' },
			-- resize buffers
			-- { "<C-Left>", '<cmd>lua require("smart-splits").resize_left()<CR>' },
			-- { "<C-Down>", '<cmd>lua require("smart-splits").resize_down()<CR>' },
			-- { "<C-Up>", '<cmd>lua require("smart-splits").resize_up()<CR>' },
			-- { "<C-Right>", '<cmd>lua require("smart-splits").resize_right()<CR>' },
			{ "<A-S-h>", '<cmd>lua require("smart-splits").resize_left()<CR>' },
			{ "<A-S-l>", '<cmd>lua require("smart-splits").resize_right()<CR>' },
			{ "<A-S-j>", '<cmd>lua require("smart-splits").resize_down()<CR>' },
			{ "<A-S-k>", '<cmd>lua require("smart-splits").resize_up()<CR>' },
			-- swapping buffers
			{ "<C-Space>h", '<cmd>lua require("smart-splits").swap_buf_left()<CR>' },
			{ "<C-Space>j", '<cmd>lua require("smart-splits").swap_buf_down()<CR>' },
			{ "<C-Space>k", '<cmd>lua require("smart-splits").swap_buf_up()<CR>' },
			{ "<C-Space>l", '<cmd>lua require("smart-splits").swap_buf_right()<CR>' },
		},
	},
	{
		"fedepujol/move.nvim",
		keys = {
			-- normal mode, move lines/words
			{ "<A-j>", ":MoveLine(1)<CR>" },
			{ "<A-k>", ":MoveLine(-1)<CR>" },
			{ "<A-h>", ":MoveWord(-1)<CR>" },
			{ "<A-l>", ":MoveWord(1)<CR>" },
			-- visual mode, move blocks
			{ "<A-j>", ":MoveBlock(1)<CR>", mode = "v" },
			{ "<A-k>", ":MoveBlock(-1)<CR>", mode = "v" },
			{ "<A-h>", ":MoveHBlock(-1)<CR>", mode = "v" },
			{ "<A-l>", ":MoveHBlock(1)<CR>", mode = "v" },
		},
		opts = {},
	},
	{
		"kevinhwang91/nvim-hlslens",
		event = "BufReadPost",
		config = function()
			require("hlslens").setup()
		end,
		keys = {
			{
				"n",
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				mode = "n",
				{ noremap = true, silent = true },
			},
			{
				"N",
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				mode = "n",
				{ noremap = true, silent = true },
			},
			{ mode = "n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true } },
			{ mode = "n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true } },
			{
				mode = "n",
				"g*",
				[[g*<Cmd>lua require('hlslens').start()<CR>]],
				desc = "search forward word",
				{ noremap = true, silent = true },
			},
			{
				mode = "n",
				"g#",
				[[g#<Cmd>lua require('hlslens').start()<CR>]],
				desc = "search backgward word",
				{ noremap = true, silent = true },
			},
		},
	},
	{
		"2kabhishek/nerdy.nvim",
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-telescope/telescope.nvim",
		},
		cmd = "Nerdy",
	},
	{
		"kawre/leetcode.nvim",
		cmd = "Leetcode",
		build = ":TSUpdate html",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- required by telescope
			"MunifTanjim/nui.nvim",
			"kyazdani42/nvim-web-devicons",
			"rcarriga/nvim-notify",
		},
		opts = {
			-- configuration goes here
			lang = "typescript",
			-- console = {
			-- 	size = {
			-- 		width = "75%", ---@type string | integer
			-- 		height = "75%", ---@type string | integer
			-- 	},
			-- 	dir = "row", ---@type "col" | "row"
			-- },

			-- description = {
			-- 	width = "40%", ---@type string | integer
			-- },
		},
	},
	{
		"folke/trouble.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		opts = {
			cycle_results = false,
			action_keys = {
				jump = { "<cr>" },
				open_tab = { "t" },
				toggle_fold = { "zz" },
			},
		},
		keys = {
			{ "<leader>lq", ":Trouble document_diagnostics<CR>", desc = "open document diagnostics" },
		},
	},
	-- {
	-- 	"ms-jpq/coq_nvim",
	-- 	branch = "coq",
	-- 	event = "BufReadPost",
	-- }, -- main one
	-- {
	-- 	"ms-jpq/coq.artifacts",
	-- 	branch = "artifacts",
	-- 	event = "BufReadPost",
	-- }, -- 9000+ Snippets
	-- { 'ms-jpq/coq.thirdparty', branch= '3p' } -- lua & third party sources, See https://github.com/ms-jpq/coq.thirdparty
	{
		"vuki656/package-info.nvim",
		ft = "json",
		dependencies = "MunifTanjim/nui.nvim",
		opts = {
			hide_up_to_date = true,
			icons = {
				style = {
					outdated = "| 󰎔 ",
				},
			},
		},
		keys = {
			-- { "<leader>nps", require("package-info").show },
			-- { "<leader>nph", require("package-info").hide },
			{
				"<leader>nps",
				mode = "n",
				":lua require('package-info').toggle()<CR>",
				desc = "toggle pkg json hide/show",
				{ silent = true },
			},
			{
				"<leader>npu",
				mode = "n",
				":lua require('package-info').update()<CR>",
				desc = "pkg json update",
				{ silent = true },
			},
			{
				"<leader>npd",
				mode = "n",
				":lua require('package-info').delete()<CR>",
				desc = "pkg json delete",
				{ silent = true },
			},
			{
				"<leader>npi",
				mode = "n",
				":lua require('package-info').install()<CR>",
				desc = "pkg json install",
				{ silent = true },
			},
			{
				"<leader>npc",
				mode = "n",
				":lua require('package-info').change_version()<CR>",
				desc = "pkg json change version",
				{ silent = true },
			},
		},
	},
	{
		"nvim-zh/colorful-winsep.nvim",
		config = true,
		event = { "WinNew" },
	},
	{
		"gbprod/yanky.nvim",
		dependencies = {
			{ "kkharji/sqlite.lua" },
		},
		opts = {
			ring = { storage = "sqlite" },
			highlight = {
				on_put = false,
				on_yank = false,
				-- timer = 500,
			},
		},
		keys = {
			{ "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
			-- { "p", mode = "x", '"_d<Plug>(YankyPutAfter)', { silent = true } },
			-- { "P", mode = "x", '"_d<Plug>(YankyPutBefore)', { silent = true } },
			{
				"p",
				"<Plug>(YankyPutAfter)",
				mode = { "n", "x" },
				desc = "Put yanked text after cursor",
				{ silent = true },
			},
			{
				"P",
				"<Plug>(YankyPutBefore)",
				mode = { "n", "x" },
				desc = "Put yanked text before cursor",
				{ silent = true },
			},
			{ "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
			{ "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
		},
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "BufReadPost",
		init = function()
			vim.g.skip_ts_context_commentstring_module = true
		end,
		opts = {
			enable_autocmd = false,
		},
	},
	-- {
	-- 	"Exafunction/codeium.nvim",
	-- 	event = "InsertEnter",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"hrsh7th/nvim-cmp",
	-- 	},
	-- 	config = function()
	-- 		require("codeium").setup({})
	-- 	end,
	-- },
	-- {
	-- 	"Exafunction/codeium.vim",
	-- 	enabled = false,
	-- 	event = "BufReadPost",
	-- 	init = function()
	-- 		vim.g.codeium_disable_bindings = 1
	-- 		vim.g.codeium_enabled = true
	-- 	end,
	-- 	config = function()
	-- 		vim.keymap.set("i", "<A-l>", function()
	-- 			return vim.fn["codeium#CycleCompletions"](1)
	-- 		end, { expr = true })
	-- 		vim.keymap.set("i", "<A-h>", function()
	-- 			return vim.fn["codeium#CycleCompletions"](-1)
	-- 		end, { expr = true })
	-- 		vim.keymap.set("i", "<c-x>", function()
	-- 			return vim.fn["codeium#Clear"]()
	-- 		end, { expr = true })
	-- 		vim.keymap.set("i", "<c-cr>", function()
	-- 			return vim.fn["codeium#Accept"]()
	-- 		end, { expr = true })
	-- 	end,
	-- },
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"0xAdk/full_visual_line.nvim",
		keys = "V",
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		tag = "*",
		event = "BufReadPost",
		opts = {
			move_cursor = false,
		},
	},
	{
		"abecodes/tabout.nvim",
		event = "InsertEnter",
		config = function()
			require("tabout").setup({
				tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
				backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
				act_as_tab = true, -- shift content if tab out is not possible
				act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
				default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
				default_shift_tab = "<C-d>", -- reverse shift default action,
				enable_backwards = true, -- well ...
				completion = true, -- if the tabkey is used in a completion pum
				tabouts = {
					{ open = "'", close = "'" },
					{ open = '"', close = '"' },
					{ open = "`", close = "`" },
					{ open = "(", close = ")" },
					{ open = "[", close = "]" },
					{ open = "{", close = "}" },
				},
				ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
				exclude = {}, -- tabout will ignore these filetypes
			})
		end,
		wants = { "nvim-treesitter" }, -- or require if not used so far
		after = { "nvim-cmp" }, -- if a completion plugin is using tabs load it before
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
	-- {
	-- 	"Bekaboo/dropbar.nvim", --use when neovim is 10 version
	-- 	dependencies = {
	-- 		"nvim-telescope/telescope-fzf-native.nvim",
	-- 	},
	-- },
	{
		"nvim-pack/nvim-spectre",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("spectre").setup({
				mapping = {
					["open_in_vsplit"] = {
						map = "<c-v>",
						cmd = "<cmd>lua vim.cmd('vsplit ' .. require('spectre.actions').get_current_entry().filename)<CR>",
						desc = "open in vertical split",
					},
					["open_in_split"] = {
						map = "<c-s>",
						cmd = "<cmd>lua vim.cmd('split ' .. require('spectre.actions').get_current_entry().filename)<CR>",
						desc = "open in horizontal split",
					},
					["open_in_tab"] = {
						map = "<c-t>",
						cmd = "<cmd>lua vim.cmd('tab split ' .. require('spectre.actions').get_current_entry().filename)<CR>",
						desc = "open in new tab",
					},
				},
				highlight = {
					ui = "String",
					search = "CustomSpectreSearch",
					replace = "CustomSpectreReplace",
				},
			})
		end,
		keys = {
			{ "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', mode = "n", desc = "Toggle Spectre" },
			{
				"<leader>sw",
				'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
				mode = "n",
				desc = "Search and replace current word",
			},
			{
				"<leader>sw",
				'<esc><cmd>lua require("spectre").open_visual()<CR>',
				mode = "v",
				desc = "Search and replace current selection",
			},
			-- {
			-- 	"<leader>sp",
			-- 	'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
			-- 	mode = "n",
			-- 	desc = "Toggle Spectre for current file",
			-- },
		},
	},
	{
		"nvim-focus/focus.nvim",
		event = "WinEnter",
		version = "*",
		opts = {
			enable = true, -- Enable module
			commands = true, -- Create Focus commands
			autoresize = {
				enable = true, -- Enable or disable auto-resizing of splits
				width = 0, -- Force width for the focused window
				height = 0, -- Force height for the focused window
				minwidth = 0, -- Force minimum width for the unfocused window
				minheight = 0, -- Force minimum height for the unfocused window
				height_quickfix = 10, -- Set the height of quickfix panel
			},
			split = {
				bufnew = false, -- Create blank buffer for new split windows
				tmux = false, -- Create tmux splits instead of neovim splits
			},
			ui = {
				number = false, -- Display line numbers in the focussed window only
				relativenumber = false, -- Display relative line numbers in the focussed window only
				hybridnumber = false, -- Display hybrid line numbers in the focussed window only
				absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows

				cursorline = false, -- Display a cursorline in the focussed window only
				cursorcolumn = false, -- Display cursorcolumn in the focussed window only
				colorcolumn = {
					enable = false, -- Display colorcolumn in the foccused window only
					list = "+1", -- Set the comma-saperated list for the colorcolumn
				},
				signcolumn = true, -- Display signcolumn in the focussed window only
				winhighlight = false, -- Auto highlighting for focussed/unfocussed windows
			},
		},
	},
	{
		"b0o/schemastore.nvim",
		ft = { "json", "jsonc" },
	},
	{
		"sourcegraph/sg.nvim",
		event = "BufReadPost",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{ "<leader>sgl", ":SourcegraphLink", mode = "n", desc = "SG: Get Link for current line" },
			{
				"<leader>sgo",
				"<cmd>lua require('sg.extensions.telescope').fuzzy_search_results()<CR>",
				mode = "n",
				desc = "SG: Get Link for current line",
			},
		},
		config = function()
			require("sg").setup()
		end,
	},
})

-- vim.cmd('highlight Search guifg=#F24211  guibg=#000000')
-- vim.cmd('highlight IncSearch guifg=#F24211 guibg=#000000')
-- vim.cmd('highlight Substitute guifg=#F24211  guibg=#000000')

-- vim.api.nvim_exec("autocmd BufWritePost * source ~/.config/nvim/lua/plugins/lualine.lua", false)
vim.api.nvim_exec("autocmd Filetype rnvimr tnoremap <buffer><nowait> j j", false)
vim.api.nvim_exec("autocmd Filetype rnvimr tnoremap <buffer><nowait> k k", false)
vim.api.nvim_exec("autocmd Filetype rnvimr tnoremap <buffer><nowait> <Space> <Space>", false)

-- vim.cmd([[
-- augroup DjangoHtmlHighlight
--   autocmd!
--   autocmd FileType htmldjango highlight MatchParen guibg=NONE
-- augroup END
-- ]]) -- for htmldjango, it conflicted with rustywind lsp

vim.cmd([[
augroup AutoCloseHelpers
  autocmd!
  autocmd FileType markdown,help,qf,vim,spectre_panel nnoremap <buffer> qq :q<CR>
augroup END
]])
