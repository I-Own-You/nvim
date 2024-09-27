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
		enabled = true,
		lazy = false,
		-- priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight]])
			local hl = vim.api.nvim_set_hl
			hl(0, "FoldColumn", { fg = "#68B9B9", bg = "#141B1E" })
			-- hl(0, "Identifier", { fg = "#dadada", bg = "NONE", sp = "NONE" })
			hl(0, "FzfLuaLiveSym", { fg = "#2AC3DE", bg = "NONE" })
			hl(0, "String", { fg = "#85de73", bg = "NONE" })
			hl(0, "TelescopeMatching", { fg = "#2AC3DE", bg = "NONE" })
			-- hl(0, "HlSearchNear", { fg = "#ffffff", bg = "#000000" })
			hl(0, "Search", { fg = "#000000", bg = "#85DE73" })
			hl(0, "IncSearch", { fg = "#000000", bg = "#85DE73" })
			hl(0, "HlSearchLens", { bg = "#1A1B26", fg = "#1A1B26" }) -- the unmatched
			hl(0, "HlSearchLensNear", { fg = "#000000", bg = "#73DACA" }) -- the matched
		end,
	},
	{
		"neovim/nvim-lspconfig",
		enabled = true,
		event = "BufReadPost",
		config = function()
			require("plugins.lsp.handlers").setup()
		end,
	},
	{
		"williamboman/mason.nvim",
		enabled = true,
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
		enabled = true,
		event = "BufReadPost",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.lsp.none-ls")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		enabled = true,
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
			-- {
			-- 	"lukas-reineke/cmp-rg",
			-- 	event = "InsertEnter",
			-- },
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
		enabled = true,
		event = "InsertEnter",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			-- local luasnip = require("luasnip")
			-- luasnip.filetype_extend("htmldjango", { "html" })
			-- luasnip.filetype_extend("typescript", { "javascript" })
			require("luasnip/loaders/from_vscode").lazy_load()
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
		end,
		build = "make install_jsregexp",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		enabled = true,
		build = ":TSUpdate",
		event = "BufReadPost",
		config = function()
			require("nvim-treesitter.configs").setup(require("plugins.treesiter"))
		end,
	},
	{
		"ibhagwan/fzf-lua",
		enabled = true,
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
				":lua require('fzf-lua').files({winopts={preview={hidden='hidden'}}})<cr>",
				desc = "find files",
				silent = true,
			},
			{
				mode = "n",
				"<A-a>",
				":lua require('fzf-lua').files({fd_opts = '--color=never --type f --hidden --follow --no-ignore', winopts={preview={hidden='hidden'}}})<CR>",
				desc = "find hidden/ignored files",
				silent = true,
			},
			{ mode = "n", "<leader>bb", desc = "buffers list", ":FzfLua buffers<CR>", silent = true },
			{ mode = "n", "<leader>ta", desc = "tabs list", ":FzfLua tabs<CR>", silent = true },
			{ mode = "n", "<leader>ho", desc = "old files", ":FzfLua oldfiles<CR>", silent = true },
			-- { mode = "n", "<leader>ll", desc = "lines from all buffers", ":FzfLua lines<CR>", { silent = true } },
			{
				mode = "n",
				"<leader>ll",
				desc = "lines from all buffers",
				":lua require('fzf-lua').lines({winopts={preview={hidden='hidden'}}})<CR>",
				silent = true,
			},
			{ mode = "n", "<leader>lb", ":FzfLua lgrep_curbuf<CR>", desc = "buffer lines", silent = true },
			{ mode = "n", "<leader>gst", desc = "git status", ":FzfLua git_status<CR>", silent = true },
			-- { mode = "n", "<leader>gls", desc = "git files", ":FzfLua git_files<CR>", silent = true },
			{
				mode = "n",
				"<leader>gls",
				desc = "git files",
				":lua require('fzf-lua').git_files({winopts={preview={hidden='hidden'}}})<CR>",
				silent = true,
			},
			{ mode = "n", "<leader>fgl", desc = "project commits", ":FzfLua git_commits<CR>", silent = true },
			{ mode = "n", "<leader>fgb", desc = "buffer commits", ":FzfLua git_bcommits<CR>", silent = true },
			{ mode = "n", "<leader>gbb", desc = "git branches", ":FzfLua git_branches<CR>", silent = true },
			{ mode = "n", "<leader>gsh", desc = "git stash list", ":FzfLua git_stash<CR>", silent = true },
			{ mode = "n", "<leader>gt", desc = "git tags", ":FzfLua git_tags<CR>", silent = true },
			{ mode = "n", "<leader>oo", desc = "lsp symbols", ":FzfLua lsp_document_symbols<CR>", silent = true },
			{
				mode = "n",
				"<leader>tt",
				":lua require('fzf-lua').lsp_live_workspace_symbols({ file_ignore_patterns = { '^node_modules/' }, })<CR>",
				desc = "live workspace symbols",
				silent = true,
			},
			{ mode = "n", "<leader>ka", desc = "code actions", ":FzfLua lsp_code_actions<CR>", silent = true },
			{ mode = "n", "gR", ":FzfLua lsp_finder<CR>", desc = "all lsp refs", silent = true },
			{
				mode = "n",
				"<leader>lw",
				desc = "project diagnostics",
				":FzfLua lsp_workspace_diagnostics<CR>",
				silent = true,
			},
			{ mode = "n", "<leader>bt", desc = "fzflua builtins", ":FzfLua builtin<CR>", silent = true },
			{ mode = "n", "<leader>ht", desc = "help tags", ":FzfLua help_tags<CR>", silent = true },
			{ mode = "n", "<leader>hc", desc = "comand history", ":FzfLua command_history<CR>", silent = true },
			{ mode = "n", "<leader>hs", desc = "search history", ":FzfLua search_history<CR>", silent = true },
			{ mode = "n", "<leader>fk", desc = "keymaps", ":FzfLua keymaps<CR>", silent = true },
			{ mode = "n", "<leader>ol", desc = "project tags", ":FzfLua tags<CR>", silent = true },
			{ mode = "n", "<leader>tb", desc = "buffer tags", ":FzfLua btags<CR>", silent = true },
			{ mode = "n", "<leader>tw", desc = "grep tag word", ":FzfLua tags_grep_cword<CR>", silent = true },
			{ mode = "n", "<leader>tl", desc = "live tag", ":FzfLua tags_live_grep<CR>", silent = true },
			{ mode = "n", "<leader><leader>", ":FzfLua grep_project<CR>", desc = "grep with rules", silent = true },
			{
				mode = "n",
				"<leader>a",
				":lua require('fzf-lua').grep_project({rg_opts = '--hidden --no-ignore --column --line-number --no-heading --color=always --smart-case --max-columns=4096'})<CR>",
				desc = "grep all",
				silent = true,
			},
			{ mode = "n", "<leader>gw", ":FzfLua grep_cword<CR>", desc = "grep word", silent = true },
		},
		config = function()
			require("fzf-lua").setup(require("plugins.fzf-lua"))
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		enabled = true,
		event = "BufReadPost",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("lualine").setup(require("plugins.lualine"))
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		enabled = true,
		event = "BufReadPost",
		opts = require("plugins.bqf"),
	},
	-- {
	-- 	"NvChad/nvim-colorizer.lua",
	-- 	enabled = false,
	-- 	event = "BufReadPost",
	-- 	opts = require("plugins.colorizer"),
	-- },
	{
		"lewis6991/gitsigns.nvim",
		enabled = true,
		event = "BufReadPost",
		keys = {
			{
				mode = "n",
				"<A-n>",
				":Gitsigns next_hunk<cr>",
				desc = "next git change",
				silent = true,
			},
			{
				mode = "n",
				"<A-p>",
				":Gitsigns prev_hunk<cr>",
				desc = "previous git change",
				silent = true,
			},
			-- { mode = "n", "<leader>bl", ":Gitsigns blame_line<cr>", desc = "blame line", silent = true },
			{
				mode = "n",
				"<leader>ph",
				":Gitsigns preview_hunk<cr>",
				desc = "preview float window change",
				silent = true,
			},
			{
				mode = "n",
				"<leader>pih",
				":Gitsigns preview_hunk_inline<cr>",
				desc = "preview inline change",
				silent = true,
			},
			{
				mode = "n",
				"<leader>sh",
				":Gitsigns stage_hunk<cr>",
				desc = "stage inline change",
				silent = true,
			},
			{ mode = "n", "<leader>sb", ":Gitsigns stage_buffer<cr>", desc = "stage buffer", silent = true },
			{
				mode = "n",
				"<leader>ush",
				":Gitsigns undo_stage_hunk<cr>",
				desc = "unstage inline change",
				silent = true,
			},
			{
				mode = "n",
				"<leader>rbb",
				":Gitsigns reset_buffer<cr>",
				desc = "redo git buffer changes",
				silent = true,
			},
			{
				mode = "n",
				"<leader>rbi",
				":Gitsigns reset_buffer_index<cr>",
				desc = "unstage buffer",
				silent = true,
			},
			{
				mode = "n",
				"<leader>rh",
				":Gitsigns reset_hunk<cr>",
				desc = "redo git inline change",
				silent = true,
			},
			{ mode = "n", "<leader>gsw", ":Gitsigns show ", desc = "git show", noremap = true, silent = true },
			{ mode = "n", "<leader>gid", ":Gitsigns diffthis ", desc = "git diff", noremap = true, silent = true },
		},
		config = function()
			require("gitsigns").setup(require("plugins.gitsigns"))
		end,
	},
	{
		"moll/vim-bbye",
		enabled = true,
		keys = {
			{ "<leader>q", mode = "n", ":Bdelete!<cr>", desc = "delete buffer", silent = true },
		},
	},
	{
		"windwp/nvim-autopairs",
		enabled = true,
		event = "InsertEnter",
		opts = require("plugins.autopairs"),
	},
	{
		"Wansmer/treesj",
		enabled = true,
		dependencies = { "nvim-treesitter" },
		opts = require("plugins.treesj"),
		keys = { { "<leader>j", mode = "n", "<cmd>TSJToggle<cr>", desc = "toggle node split", silent = true } },
	},
	{
		"andymass/vim-matchup",
		enabled = true,
		event = "BufReadPost",
		config = function()
			vim.g.matchup_matchparen_enabled = 0
			-- vim.cmd([[highlight MatchParen guibg=#000000]])
			-- vim.cmd([[highlight MatchParen gui=NONE]])
		end,
	},
	{
		"jedrzejboczar/possession.nvim",
		enabled = true,
		keys = {
			{
				"<leader>sl",
				mode = "n",
				":Telescope possession list<CR>",
				desc = "Open sessions list",
				noremap = true,
				silent = true,
			},
			{ "<leader>ss", mode = "n", ":PossessionSave ", desc = "save session", noremap = true },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		opts = require("plugins.session"),
	},
	{
		"debugloop/telescope-undo.nvim",
		enabled = true,
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
				silent = true,
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("undo")
		end,
	},
	{
		"folke/todo-comments.nvim",
		enabled = true,
		config = function()
			require("todo-comments").setup()
		end,
		keys = {
			{ "<leader>td", mode = "n", ":TodoQuickFix<CR>", desc = "open todos", noremap = true, silent = true },
		},
		opts = require("plugins.todo-comments"),
	},
	{
		"rbong/vim-flog",
		enabled = true,
		dependencies = { "tpope/vim-fugitive" },
		keys = {
			{ "<leader>fgg", mode = "n", ":Flog ", desc = "open floggit", noremap = true, silent = true },
			{ "<leader>fb", mode = "n", ":Floggit ", desc = "open flog branch", noremap = true, silent = true },
			{
				"<leader>gc",
				mode = "n",
				':Floggit commit -m ""<left>',
				desc = "open flog branch commit",
				noremap = true,
				silent = true,
			},
			{ "<leader>gp", mode = "n", ":Floggit push<CR>", desc = "floggit push", silent = true },
			{ "<leader>fs", mode = "n", ":Flogsplit ", desc = "flog split", noremap = true, silent = true },
		},
	},
	-- {
	-- 	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	-- 	enabled = false,
	-- 	event = "BufReadPost",
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
		"folke/flash.nvim",
		enabled = true,
		event = "BufReadPost",
		---@type Flash.Config
		keys = {
			{ "s", mode = "n", "<cmd>lua require('flash').jump()<CR>", noremap = true, silent = true },
			{ "s", mode = "x", "<cmd>lua require('flash').jump()<CR>", noremap = true, silent = true },
			{ "s", mode = "o", "<cmd>lua require('flash').jump()<CR>", noremap = true, silent = true },
			{ "S", mode = "n", "<cmd>lua require('flash').treesitter()<CR>", noremap = true, silent = true },
			{ "S", mode = "o", "<cmd>lua require('flash').treesitter()<CR>", noremap = true, silent = true },
			-- { "S", mode = "x", "<cmd>lua require('flash').treesitter()<CR>", noremap = true ,silent=true},
			{ "r", mode = "o", "<cmd>lua require('flash').remote()<CR>", noremap = true, silent = true },
		},
	},
	{
		"sindrets/diffview.nvim",
		enabled = true,
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
			{ "<leader>mt", mode = "n", ":DiffviewOpen ", desc = "open diff view", silent = true },
			{
				"<leader>mf",
				mode = "n",
				":DiffviewFileHistory ",
				desc = "open diff view for single file",
				silent = true,
			},
			{ "<leader>mk", mode = "n", ":DiffviewClose<CR>", desc = "close diff view", silent = true },
		},
	},
	-- {
	-- 	"utilyre/barbecue.nvim",
	-- 	enabled = false,
	-- 	event = "VimEnter",
	-- 	name = "barbecue",
	-- 	version = "*",
	-- 	dependencies = {
	-- 		"SmiteshP/nvim-navic",
	-- 		"kyazdani42/nvim-web-devicons",
	-- 	},
	-- 	opts = {},
	-- },
	-- {
	-- 	"glepnir/dashboard-nvim",
	-- 	enabled = false,
	-- 	event = "VimEnter",
	-- 	opts = require("plugins.dashboard"),
	-- 	dependencies = { { "kyazdani42/nvim-web-devicons" } },
	-- },
	{
		"kevinhwang91/nvim-fundo",
		enabled = true,
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
		enabled = true,
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {},
		keys = {
			{ "<leader>wt", ":WtfSearch ", desc = "open wtf search", silent = true },
		},
	},
	-- {
	-- 	-- NOTE: you can also make for another lang the import, look at github of the extension, in case
	-- 	"piersolenski/telescope-import.nvim",
	-- 	enabled = false,
	-- 	dependencies = "nvim-telescope/telescope.nvim",
	-- 	keys = {
	-- 		{ "<leader>ii", "<cmd>Telescope import<CR>", desc = "open imports", silent = true },
	-- 	},
	-- 	config = function()
	-- 		require("telescope").load_extension("import")
	-- 	end,
	-- },
	{
		"mrjones2014/smart-splits.nvim",
		enabled = true,
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
		"kevinhwang91/nvim-hlslens",
		enabled = true,
		event = "BufReadPost",
		config = function()
			require("hlslens").setup()
		end,
		keys = {
			{
				"n",
				"<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zz",
				mode = "n",
				noremap = true,
				silent = true,
			},
			{
				"N",
				"<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zz",
				mode = "n",
				noremap = true,
				silent = true,
			},
			{ mode = "n", "*", "*<Cmd>lua require('hlslens').start()<CR>zz", noremap = true, silent = true },
			{ mode = "n", "#", "#<Cmd>lua require('hlslens').start()<CR>zz", noremap = true, silent = true },
			{
				mode = "n",
				"g*",
				"g*<Cmd>lua require('hlslens').start()<CR>zz",
				desc = "search forward word",
				noremap = true,
				silent = true,
			},
			{
				mode = "n",
				"g#",
				"g#<Cmd>lua require('hlslens').start()<CR>zz",
				desc = "search backgward word",
				noremap = true,
				silent = true,
			},
		},
	},
	-- {
	-- 	"kawre/leetcode.nvim",
	-- 	-- lazy = false,
	-- 	enabled = false,
	-- 	build = ":TSUpdate html",
	-- 	cmd = "Leet",
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"nvim-telescope/telescope.nvim",
	-- 		"nvim-lua/plenary.nvim", -- required by telescope
	-- 		"MunifTanjim/nui.nvim",
	-- 		"kyazdani42/nvim-web-devicons",
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- 	config = function()
	-- 		require("leetcode").setup()
	-- 	end,
	--    opts = {}
	-- },
	{
		"gbprod/yanky.nvim",
		enabled = true,
		dependencies = {
			{ "kkharji/sqlite.lua" },
		},
		opts = require("plugins.yanky"),
		keys = {
			{
				"<leader>yy",
				function()
					require("telescope").extensions.yank_history.yank_history({})
				end,
				desc = "Open Yank History",
				silent = true,
			},
			{ "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text", silent = true },
			{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor", silent = true },
			{
				"P",
				"<Plug>(YankyPutBefore)",
				mode = { "n", "x" },
				desc = "Put yanked text before cursor",
				silent = true,
			},
			{
				"<c-p>",
				"<Plug>(YankyPreviousEntry)",
				desc = "Select previous entry through yank history",
				silent = true,
			},
			{
				"<c-n>",
				"<Plug>(YankyNextEntry)",
				desc = "Select next entry through yank history",
				silent = true,
			},
		},
	},
	{
		"max397574/better-escape.nvim",
		enabled = true,
		event = "InsertEnter",
		opts = require("plugins.better_escape"),
		-- config = function()
		-- 	require("better_escape").setup({
		--     })
		-- end,
	},
	{
		"kylechui/nvim-surround",
		enabled = true,
		tag = "*",
		event = "BufReadPost",
		opts = require("plugins.nvim-surround"),
	},
	{
		"folke/which-key.nvim",
		enabled = true,
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
	{
		"nvim-focus/focus.nvim",
		enabled = true,
		event = "BufReadPost",
		version = "*",
		keys = {
			{ "<leader>df", ":FocusToggle<CR>", mode = "n", desc = "disable focus.nvim", silent = true },
		},
		opts = {},
	},
	{
		"b0o/schemastore.nvim",
		enabled = true,
		ft = { "json", "jsonc" },
	},
	{
		"FabijanZulj/blame.nvim",
		enabled = true,
		opts = {},
		keys = {
			{
				"<leader>bl",
				":BlameToggle<CR>",
				mode = "n",
				desc = "git blame lines",
				silent = true,
			},
		},
	},
	{
		"mikavilpas/yazi.nvim",
		enabled = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "VeryLazy",
		keys = {
			{
				"<leader>e",
				function()
					require("yazi").yazi()
				end,
				desc = "Open the file manager",
			},
		},
	},
	{
		"yutkat/wb-only-current-line.nvim",
		enabled = true,
		event = "BufReadPost",
	},
	-- { "folke/neodev.nvim", enabled = false, opts = {} }, -- also enable in mason.lua line before mlspconfig to work
	{
		"j-hui/fidget.nvim",
		enabled = true,
		event = "VeryLazy",
		opts = {},
	},
	{
		"olexsmir/gopher.nvim",
		ft = { "go", "gomod", "gotmpl", "gohtmltmpl" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- "mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
		},
		opts = {},
	},
	{
		"nvim-zh/colorful-winsep.nvim",
		config = true,
		event = { "WinLeave" },
	},
	{
		"mistweaverco/kulala.nvim",
		ft = "http",
		opts = require("plugins.kulala"),
		init = function()
			vim.filetype.add({
				extension = {
					["http"] = "http",
				},
			})
		end,
	},
}, require("plugins.lazy"))
