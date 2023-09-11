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
	{
		"notken12/base46-colors",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme github_dark]])
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.lsp.handlers").setup()
		end,
	},
	{
		"williamboman/mason.nvim",
		-- use({ "williamboman/nvim-lsp-installer" }) -- lsp installer
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		build = ":MasonUpdate",
		config = function()
			require("plugins.lsp.mason")
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.lsp.null-ls")
		end,
	},
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "hrsh7th/cmp-emoji" },
	{ "saadparwaiz1/cmp_luasnip" },
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("cmp").setup(require("plugins.cmp"))
			local cmp = require("cmp")

			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- `?` cmdline setup.
			cmp.setup.cmdline("?", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- `:` cmdline setup.
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = {},
						},
					},
				}),
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			local luasnip = require("luasnip")
			luasnip.filetype_extend("htmldjango", { "html" })
			luasnip.filetype_extend("typescript", { "javascript" })
			require("luasnip/loaders/from_vscode").lazy_load()
		end,
		build = "make install_jsregexp",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup(require("plugins.treesiter"))
		end,
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("fzf-lua").setup(require("plugins.fzf-lua"))
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("lualine").setup(require("plugins.lualine"))
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		enabled = true,
		config = function()
			require("indent_blankline").setup(require("plugins.indent_blankline"))
			-- vim.cmd([[highlight IndentBlanklineContextStart guisp=#8FBCBB gui=underline]])
			vim.g.indent_blankline_filetype_exclude = { "dashboard" }
		end,
	},
	{
		"shellRaining/hlchunk.nvim",
		enabled = false,
		event = { "UIEnter" },
		config = function()
			require("hlchunk").setup(require("plugins.hlchunk"))
		end,
	},
	{
		"kevinhwang91/rnvimr",
		keys = {
			{ "<leader>e", ":RnvimrToggle<cr>" },
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
			vim.g.rnvimr_ranger_cmd = { "ranger", "--cmd=set draw_borders false" } -- Draw border with both"

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
		config = function()
			require("numb").setup(require("plugins.numb"))
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup(require("plugins.colorizer"))
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.comment")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup(require("plugins.gitsigns"))
		end,
	},
	{
		"moll/vim-bbye",
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup(require("plugins.autopairs"))
			-- local cmp_autopairs = require "nvim-autopairs.completion.cmp"
			-- local cmp = require('cmp')
			-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {})
		end,
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter" },
		opts = { use_default_keymaps = false, max_join_length = 999 },
	},
	{
		"Vimjas/vim-python-pep8-indent",
	},
	{
		"andymass/vim-matchup",
		config = function()
			-- vim.cmd([[highlight MatchParen guibg=#5C4E4E]])
			-- vim.cmd([[highlight MatchParen gui=NONE]])
		end,
	},
	{
		"kylechui/nvim-surround",
		tag = "*",
		event = "VeryLazy",
		opts = {
			move_cursor = false,
		},
	},
	{
		"jedrzejboczar/possession.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("possession").setup(require("plugins.session"))
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "debugloop/telescope-undo.nvim" },
		config = function()
			require("telescope").setup(require("plugins.telescope"))
			require("telescope").load_extension("undo")
			require("telescope").load_extension("possession")
		end,
	},
	{
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup(require("plugins.todo-comments"))
		end,
	},
	{
		"rbong/vim-flog",
		dependencies = { "tpope/vim-fugitive" },
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup(require("plugins.nvim-ts-autotag"))
		end,
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		enabled = false,
		config = function()
			require("lsp_lines").setup({})
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		config = function()
			require("lsp_signature").setup(require("plugins.lsp-signature"))
		end,
	},
	{
		"akinsho/bufferline.nvim",
		enabled = false,
		config = function()
			require("bufferline").setup(require("plugins.bufferline"))
		end,
	},
	{
		"smjonas/inc-rename.nvim",
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
		event = "VeryLazy",
		---@type Flash.Config
	},
	{
		"AlexvZyl/nordic.nvim",
		enabled = true,
		lazy = false,
		priority = 1000,
		opts = {
			italic_comments = false,
			transparent_bg = false,
			bold_keywords = true,
			override = {
				FoldColumn = { bg = "#242933", fg = "#28A761" }, -- 'foldcolumn'
			},
		},
	},
	{
		"sindrets/diffview.nvim",
		keys = {
			{ "<leader>mt", ":DiffviewOpen<CR>" },
			{ "<leader>mf", ":DiffviewFileHistory<CR>" },
			{ "<leader>mk", ":DiffviewClose<CR>" },
		},
	},
	{
		"kevinhwang91/nvim-ufo",
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
		end,
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"kyazdani42/nvim-web-devicons", -- optional dependency
		},
		opts = {},
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
			{ "<leader>dd", ":DevdocsOpenCurrentFloat<CR>" },
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
			wrap = false, -- text wrap, only applies to floating window
			-- ensure_installed = { "html", "javascript", "typescript", "go", "lua-5.4", "python-3.11", "django-4.2", "tailwindcss" }, -- get automatically installed
			previewer_cmd = "glow",
			cmd_args = { "-s", "dark", "-w", "80" },
			-- cmd_ignore = {}, -- ignore cmd rendering for the listed docs
			-- picker_cmd = false, -- use cmd previewer in picker preview
			-- picker_cmd_args = {}, -- example using glow: { "-p" }
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
		"NStefan002/speedtyper.nvim",
		branch = "main",
		cmd = "Speedtyper",
		opts = {
			window = {
				height = 5, -- integer >= 5 | float in range (0, 1)
				width = 0.55, -- integer | float in range (0, 1)
				border = "rounded", -- "none" | "single" | "double" | "rounded" | "shadow" | "solid"
			},
			language = "en", -- currently only only supports English
			game_modes = { -- prefered settings for different game modes
				-- type until time expires
				countdown = {
					time = 30,
				},
				-- type until you complete one page
				stopwatch = {
					hide_time = true, -- hide time while typing
				},
			},
			-- MORE COMING SOON
		},
	},
	{
		"kevinhwang91/nvim-fundo",
		dependencies = { "kevinhwang91/promise-async" },
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
		event = "VeryLazy",
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
			{ "<leader>wt", ":WtfSearch " },
		},
	},
	{
		-- NOTE: now my cpu is too slow, it lags using cpu/ram/wifi, use when upgrade the pc
		"Pheon-Dev/pigeon",
		event = "VimEnter",
		enabled = false,
		opts = {
			enabled = true,
			os = "linux", -- windows, osx
			plugin_manager = "lazy", -- packer, paq, vim-plug
			callbacks = {
				killing_pigeon = nil,
				respawning_pigeon = nil,
			},
		},
	},
	{
		-- NOTE: you can also make for another lang the import, look at github of the extension, in case
		"piersolenski/telescope-import.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = {
			{ "<leader>ii", "<cmd>Telescope import<CR>" },
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
    },
		keys = {
			-- move between buffers
			{ "<C-h>", '<cmd>lua require("smart-splits").move_cursor_left()<CR>' },
			{ "<C-j>", '<cmd>lua require("smart-splits").move_cursor_down()<CR>' },
			{ "<C-k>", '<cmd>lua require("smart-splits").move_cursor_up()<CR>' },
			{ "<C-l>", '<cmd>lua require("smart-splits").move_cursor_right()<CR>' },
			-- resize buffers
			{ "<C-Left>", '<cmd>lua require("smart-splits").resize_left()<CR>' },
			{ "<C-Down>", '<cmd>lua require("smart-splits").resize_down()<CR>' },
			{ "<C-Up>", '<cmd>lua require("smart-splits").resize_up()<CR>' },
			{ "<C-Right>", '<cmd>lua require("smart-splits").resize_right()<CR>' },
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
	},
})

-- vim.cmd('highlight Search guifg=#F24211  guibg=#000000')
-- vim.cmd('highlight IncSearch guifg=#F24211 guibg=#000000')
-- vim.cmd('highlight Substitute guifg=#F24211  guibg=#000000')

-- vim.api.nvim_set_hl(0, "dap_breakpoint_red",   { fg = "#ff0011" })
-- vim.api.nvim_set_hl(0, "dap_log_point",  { fg = "#31353f" })
-- vim.api.nvim_set_hl(0, "dap_stopped", { fg = "#00E756" })
-- vim.api.nvim_set_hl(0, "dap_condition", { fg = "#F24211" })

-- vim.fn.sign_define('DapBreakpoint',          { text='', texthl='dap_breakpoint_red',   linehl='', numhl='', priority = 1000})
-- vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='dap_condition',   linehl='', numhl='' })
-- vim.fn.sign_define('DapBreakpointRejected',  { text='', texthl='dap_breakpoint_red', linehl='', numhl='' })
-- vim.fn.sign_define('DapStopped',             { text='', texthl='dap_stopped',  linehl='', numhl='' })
-- vim.fn.sign_define('DapLogPoint',            { text='', texthl='dap_log_point', linehl='', numhl='' })

-- vim.api.nvim_exec("autocmd BufWritePost * source ~/.config/nvim/lua/plugins/lualine.lua", false)
vim.api.nvim_exec("autocmd Filetype rnvimr tnoremap <buffer><nowait> j j", false)
vim.api.nvim_exec("autocmd Filetype rnvimr tnoremap <buffer><nowait> k k", false)
vim.api.nvim_exec("autocmd Filetype rnvimr tnoremap <buffer><nowait> <Space> <Space>", false)

vim.cmd([[
augroup DjangoHtmlHighlight
  autocmd!
  autocmd FileType htmldjango highlight MatchParen guibg=NONE
augroup END
]])

vim.cmd([[
augroup AutoCloseMarkdownGlow
  autocmd!
  autocmd FileType glow nnoremap <buffer> q :q<CR>
augroup END
]])

-- vim.diagnostic.config({ virtual_lines = false })
-- vim.diagnostic.config({ virtual_lines = true })
-- vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
