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
			hl(0, "FzfLuaLiveSym", { fg = "#2AC3DE", bg = "NONE" })
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
		"hrsh7th/nvim-cmp",
		dependencies = {
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
				"SergioRibera/cmp-dotenv",
				event = "InsertEnter",
			},
		},
		event = "InsertEnter",
		config = function()
			require("cmp").setup(require("plugins.cmp"))
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
			-- { mode = "n", "<A-f>", ":FzfLua files<CR>", desc = "find files", { silent = true } },
			{
				mode = "n",
				"<A-f>",
				":lua require('fzf-lua').files({fd_opts = '--color=never --type f --hidden --follow --exclude={.git,node_modules,linux-gtk-theming,nerd-fonts-linux-theming}', winopts={preview={hidden='hidden'}}})<CR>",
				desc = "find files",
				{ silent = true },
			},
			-- {
			-- 	mode = "n",
			-- 	"<A-a>",
			-- 	":lua require('fzf-lua').files({fd_opts = '--color=never --type f --hidden --follow --no-ignore'})<CR>",
			-- 	desc = "find hidden/ignored files",
			-- 	{ silent = true },
			-- },
			{
				mode = "n",
				"<A-a>",
				":lua require('fzf-lua').files({fd_opts = '--color=never --type f --hidden --follow --no-ignore', winopts={preview={hidden='hidden'}}})<CR>",
				desc = "find hidden/ignored files",
				{ silent = true },
			},
			{ mode = "n", "<leader>bb", desc = "buffers list", ":FzfLua buffers<CR>", { silent = true } },
			{ mode = "n", "<leader>ta", desc = "tabs list", ":FzfLua tabs<CR>", { silent = true } },
			{ mode = "n", "<leader>ho", desc = "old files", ":FzfLua oldfiles<CR>", { silent = true } },
			-- { mode = "n", "<leader>ll", desc = "lines from all buffers", ":FzfLua lines<CR>", { silent = true } },
			{
				mode = "n",
				"<leader>ll",
				desc = "lines from all buffers",
				":lua require('fzf-lua').lines({winopts={preview={hidden='hidden'}}})<CR>",
				{ silent = true },
			},
			{ mode = "n", "<leader>lb", ":FzfLua lgrep_curbuf<CR>", desc = "buffer lines", { silent = true } },
			{ mode = "n", "<leader>gst", desc = "git status", ":FzfLua git_status<CR>", { silent = true } },
			-- { mode = "n", "<leader>gls", desc = "git files", ":FzfLua git_files<CR>", { silent = true } },
			{
				mode = "n",
				"<leader>gls",
				desc = "git files",
				":lua require('fzf-lua').git_files({winopts={preview={hidden='hidden'}}})<CR>",
				{ silent = true },
			},
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
	-- { -- in case rnvimr no longer works, use this instead
	-- 	"kelly-lin/ranger.nvim",
	-- 	config = function()
	-- 		require("ranger-nvim").setup({ replace_netrw = true })
	-- 		vim.api.nvim_set_keymap("n", "<leader>ef", "", {
	-- 			noremap = true,
	-- 			callback = function()
	-- 				require("ranger-nvim").open(true)
	-- 			end,
	-- 		})
	-- 	end,
	-- },
	{
		"nacro90/numb.nvim",
		event = "BufReadPost",
		opts = require("plugins.numb"),
	},
	{
		"kevinhwang91/nvim-bqf",
		event = "BufReadPost",
		opts = require("plugins.bqf"),
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPost",
		opts = require("plugins.colorizer"),
	},
	{
		"numToStr/Comment.nvim",
		event = "BufReadPost",
		opts = require("plugins.comment"),
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
		opts = require("plugins.autopairs"),
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter" },
		opts = require("plugins.treesj"),
		keys = {
			{ "<leader>j", mode = "n", "<cmd>TSJToggle<cr>", desc = "toggle node split", { silent = true } },
		},
	},
	{
		"andymass/vim-matchup",
		event = "BufReadPost",
		-- config = function()
		-- vim.cmd([[highlight MatchParen guibg=#5C4E4E]])
		-- vim.cmd([[highlight MatchParen gui=NONE]])
		-- end,
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
		opts = require("plugins.session"),
	},
	{
		"debugloop/telescope-undo.nvim",
		opts = require("plugins.telescope-undo"),
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
		opts = require("plugins.todo-comments"),
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
		opts = require("plugins.nvim-ts-autotag"),
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
	-- {
	-- 	"akinsho/bufferline.nvim",
	-- 	enabled = false,
	-- 	config = function()
	-- 		require("bufferline").setup(require("plugins.bufferline"))
	-- 	end,
	-- },
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
		event = "BufReadPost",
		config = function()
			local actions = require("diffview.actions")
			require("diffview").setup({
				keymaps = {
					view = {
						{ "n", "<A-n>", "]c", { desc = "Next hunk / entry" } },
						{ "n", "<A-p>", "[c", { desc = "Prev hunk / entry" } },
					},
				},
			})
		end,
		keys = {
			{ "<leader>mt", mode = "n", ":DiffviewOpen ", desc = "open diff view" },
			{ "<leader>mf", mode = "n", ":DiffviewFileHistory ", desc = "open diff view for single file" },
			{ "<leader>mk", mode = "n", ":DiffviewClose<CR>", desc = "close diff view" },
			-- {
			-- 	"<leader>mt",
			-- 	mode = "n",
			-- 	':lua require("utility_functions").diffViewOpen()<CR>',
			-- 	desc = "open diff view",
			-- },
			-- {
			-- 	"<leader>mf",
			-- 	mode = "n",
			-- 	':lua require("utility_functions").diffViewFileHistoryOpen()<CR>',
			-- 	desc = "open diff view for single file",
			-- },
			-- {
			-- 	"<leader>mk",
			-- 	mode = "n",
			-- 	':lua require("utility_functions").diffViewClose()<CR>',
			-- 	desc = "close diff view",
			-- },
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
	},
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		opts = require("plugins.dashboard"),
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
		opts = require("plugins.devdocs"),
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
		opts = require("plugins.fundo"),
	},
	{
		"piersolenski/wtf.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {},
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
		opts = require("plugins.smart-splits"),
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
			-- visual mode, move blocks
			{ "<A-j>", ":MoveBlock(1)<CR>", mode = "v" },
			{ "<A-k>", ":MoveBlock(-1)<CR>", mode = "v" },
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
		-- lazy = false,
		build = ":TSUpdate html",
		cmd = "Leet",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- required by telescope
			"MunifTanjim/nui.nvim",
			"kyazdani42/nvim-web-devicons",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("leetcode").setup()
		end,
		opts = require("plugins.leetcode"),
	},
	{
		"folke/trouble.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		opts = require("plugins.trouble"),
		keys = {
			{ "<leader>lq", ":Trouble document_diagnostics<CR>", desc = "open document diagnostics" },
		},
	},
	{
		"vuki656/package-info.nvim",
		ft = "json",
		dependencies = "MunifTanjim/nui.nvim",
		opts = require("plugins.package-info"),
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
		"gbprod/yanky.nvim",
		dependencies = {
			{ "kkharji/sqlite.lua" },
		},
		opts = require("plugins.yanky"),
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
		opts = require("plugins.nvim-ts-context-commentstring"),
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
		opts = require("plugins.nvim-surround"),
	},
	{
		"abecodes/tabout.nvim",
		event = "InsertEnter",
		config = function()
			require("tabout").setup()
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
		opts = require("plugins.spectre"),
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
		event = "BufReadPost",
		version = "*",
		keys = {
			{ "<leader>df", ":FocusToggle<CR>", mode = "n", desc = "disable focus.nvim" },
		},
		opts = {},
	},
	{
		"b0o/schemastore.nvim",
		ft = { "json", "jsonc" },
	},
	-- {
	-- 	"sourcegraph/sg.nvim",
	-- 	event = "BufReadPost",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 	},
	-- 	keys = {
	-- 		{ "<leader>sgl", ":SourcegraphLink", mode = "n", desc = "SG: Get Link for current line" },
	-- 		{
	-- 			"<leader>sgo",
	-- 			"<cmd>lua require('sg.extensions.telescope').fuzzy_search_results()<CR>",
	-- 			mode = "n",
	-- 			desc = "SG: Get Link for current line",
	-- 		},
	-- 	},
	-- 	config = function()
	-- 		require("sg").setup()
	-- 	end,
	-- },
	{
		"rest-nvim/rest.nvim",
		ft = { "http" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("rest-nvim").setup(require("plugins.rest-nvim"))
		end,
		init = function()
			vim.api.nvim_create_user_command("RestRun", "lua require('rest-nvim').run()<CR>", { nargs = 0 })
			vim.api.nvim_create_user_command("RestLast", "lua require('rest-nvim').last()<CR>", { nargs = 0 })
			vim.api.nvim_create_user_command("RestPreview", "lua require('rest-nvim').run(true)<CR>", { nargs = 0 })
		end,
	},
	{
		-- you can install support for styled components
		-- from github plugin settings of this plugin
		"pmizio/typescript-tools.nvim",
		ft = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
		config = function()
			require("typescript-tools").setup(require("plugins.ts-tools"))
		end,
	},
	{
		"dmmulroy/ts-error-translator.nvim",
		ft = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
		config = function()
			require("ts-error-translator").setup()
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		keys = {
			{
				"<leader>lg",
				":LazyGit<CR>",
				mode = "n",
				{ silent = true, desc = "Open Lazy Git" },
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"bloznelis/before.nvim",
		event = "BufReadPost",
		config = function()
			local before = require("before")
			before.setup()
			vim.keymap.set("n", "<A-h>", before.jump_to_last_edit, {})
			vim.keymap.set("n", "<A-l>", before.jump_to_next_edit, {})
			vim.keymap.set("n", "<leader>le", before.show_edits_in_quickfix, {})
		end,
		opts = require("plugins.before"),
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{
		"kilavila/nvim-gitignore",
		cmd = { "Gitignore", "Licenses" },
	},
	{
		"LinArcX/telescope-env.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
    event = "BufReadPost",
		config = function()
			require("telescope").load_extension("env")
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
  autocmd FileType markdown,help,qf,vim,spectre_panel,httpResult,bufferlist nnoremap <buffer> q :q<CR>
augroup END
]])
