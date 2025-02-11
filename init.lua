require("user.options")
require("user.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("user.nvchad-custom-options")

require("lazy").setup({
	-- ui related
	{
		{
			"nvchad/ui",
			enabled = true,
			event = "VimEnter",
			config = function()
				require("nvchad")
			end,
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
		},
		{
			"nvchad/base46",
			enabled = true,
			event = "VimEnter",
			build = function()
				require("base46").load_all_highlights()
			end,
			config = function()
				local hl = vim.api.nvim_set_hl
				-- general
				-- hl(0, "FoldColumn", { fg = "#68B9B9", bg = "#141B1E" })
				-- hl(0, "String", { fg = "#85de73", bg = "NONE" })
				hl(0, "Search", { fg = "#000000", bg = "#8CCF7E" })
				hl(0, "IncSearch", { fg = "#000000", bg = "#8CCF7E" })
				-- hlslens
				hl(0, "HlSearchNear", { fg = "#000000", bg = "#8CCF7E" })
				hl(0, "HlSearchLens", { bg = "#141B1E", fg = "#141B1E" })
				hl(0, "HlSearchLensNear", { fg = "#000000", bg = "#8CCF7E" })
				-- telescope
				hl(0, "TelescopeMatching", { fg = "#2AC3DE", bg = "NONE" })
				-- fzf lua
				hl(0, "FzfLuaLiveSym", { fg = "#2AC3DE", bg = "NONE" })
				-- blink.cmp
				hl(0, "BlinkCmpMenu", { bg = "#141b1e" })
				hl(0, "BlinkCmpMenuBorder", { fg = "#2f3639", bg = "#141b1e" })
				hl(0, "BlinkCmpDoc", { bg = "#141b1e" })
				hl(0, "BlinkCmpDocBorder", { fg = "#2f3639", bg = "#141b1e" })
				hl(0, "BlinkCmpDocSeparator", { fg = "#2f3639", bg = "#141b1e" })
				hl(0, "BlinkCmpSignatureHelp", { bg = "#141b1e" })
				hl(0, "BlinkCmpSignatureHelpBorder", { fg = "#2f3639", bg = "#141b1e" })
				-- add here strikethrough again if you remove colorful-menu plugin from blink
				hl(0, "BlinkCmpLabelDeprecated", { fg = "#2f3639" })
				-- dropbar
				hl(0, "DropBarMenuCurrentContext", { fg = "#2f3639", bg = "#141b1e" })
				hl(0, "DropBarMenuHoverEntry", { fg = "#dadada", bg = "#1a2124" })
				hl(0, "DropBarMenuFloatBorder", { fg = "#2f3639", bg = "#141b1e" })
				hl(0, "DropBarMenuNormalFloat", { bg = "#141b1e" })
			end,
		},
	},

	-- lsp, cmp, none-ls, mason related
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
		"nvimtools/none-ls.nvim",
		enabled = true,
		event = "BufReadPost",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.lsp.none-ls")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		enabled = true,
		event = "InsertEnter",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			local luasnip = require("luasnip")
			-- luasnip.filetype_extend("htmldjango", { "html" })
			luasnip.filetype_extend("typescriptreact", { "html" })
			luasnip.filetype_extend("javascriptreact", { "html" })
			-- require("luasnip/loaders/from_vscode").lazy_load({ paths = "~/.config/nvim/snippets/" })
			require("luasnip/loaders/from_vscode").lazy_load()
			-- enable it if you will define lua snippets
			-- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
		end,
		build = "make install_jsregexp",
	},
	{
		"saghen/blink.cmp",
		enabled = true,
		lazy = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"mikavilpas/blink-ripgrep.nvim",
			{
				"xzbdmw/colorful-menu.nvim",
				enabled = true,
				event = "BufReadPost",
			},
			"saghen/blink.compat",
			{
				"supermaven-inc/supermaven-nvim",
				opts = {
					keymaps = {
						accept_suggestion = nil,
					},
					disable_inline_completion = true,
				},
			},
		},
		-- use a release tag to download pre-built binaries
		version = "*",
		opts = require("plugins.blink-cmp"),
		keys = {
			{
				mode = "i",
				"<C-g>",
				function()
					require("blink-cmp").show({ providers = { "ripgrep" } })
				end,
				desc = "",
				silent = true,
			},
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
	-- 		vim.diagnostic.config({ virtual_text = false })
	-- 		require("lsp_lines").setup({})
	-- 	end,
	-- },
	-- { "folke/neodev.nvim", enabled = false, opts = {} }, -- also enable in mason.lua line before mlspconfig to work
	{
		"j-hui/fidget.nvim",
		enabled = true,
		event = "VeryLazy",
		opts = {},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		enabled = true,
		event = "VeryLazy",
		priority = 1000,
		opts = require("plugins.tiny-inline-diagnostic"),
	},
	{
		"Wansmer/treesj",
		enabled = true,
		dependencies = { "nvim-treesitter" },
		opts = require("plugins.treesj"),
		keys = { { "<leader>j", mode = "n", "<cmd>TSJToggle<cr>", desc = "toggle node split", silent = true } },
	},

	-- git related
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
		"tpope/vim-fugitive",
		enabled = true,
		event = "CmdlineEnter",
		keys = {
			{ "<leader>gg", mode = "n", ":Git ", desc = "open git", noremap = true, silent = true },
			{

				"<leader>gc",
				mode = "n",
				":Git commit<CR>",
				desc = "git commit",
				noremap = true,
				silent = true,
			},
			{ "<leader>gp", mode = "n", ":Git push<CR>", desc = "git push", silent = true },
			{ "<leader>bl", mode = "n", ":Git blame<CR>", desc = "git blame", noremap = true, silent = true },
		},
	},
	{
		"rbong/vim-flog",
		enabled = true,
		dependencies = { "tpope/vim-fugitive" },
		keys = {
			{ "<leader>fgg", mode = "n", ":Flog ", desc = "open floggit", noremap = true, silent = true },
			{ "<leader>fs", mode = "n", ":Flogsplit ", desc = "flog split", noremap = true, silent = true },
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

	-- utilities
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
			-- { mode = "n", "<leader>ka", desc = "code actions", ":FzfLua lsp_code_actions<CR>", silent = true },
			{
				mode = "n",
				"<leader>ka",
				desc = "code actions",
				":lua require('fzf-lua').lsp_code_actions({winopts={preview={hidden='hidden'}}})<CR>",
				silent = true,
			},
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
	-- {
	-- 	"nvim-lualine/lualine.nvim",
	-- 	enabled = false,
	-- 	event = "BufReadPost",
	-- 	dependencies = { "kyazdani42/nvim-web-devicons" },
	-- 	config = function()
	-- 		require("lualine").setup(require("plugins.lualine"))
	-- 	end,
	-- },
	{
		"kevinhwang91/nvim-bqf",
		enabled = true,
		event = "BufReadPost",
		opts = require("plugins.bqf"),
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
		event = "BufReadPost",
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
		opts = {},
	},
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
	-- {
	-- 	"piersolenski/telescope-import.nvim",
	-- 	enabled = true,
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
				mode = { "n", "x" },
				"<Plug>(YankyPreviousEntry)",
				desc = "Select previous entry through yank history",
				silent = true,
			},
			{
				"<c-n>",
				mode = { "n", "x" },
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
		"dnlhc/glance.nvim",
		event = "BufReadPost",
		enabled = true,
		config = function()
			require("glance").setup(require("plugins.glance"))
		end,
	},
	-- {
	-- 	"barrett-ruth/import-cost.nvim",
	-- 	enabled = true,
	-- 	build = "sh install.sh npm", -- change if you need, npm/yarn/bun/.etc
	-- 	ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
	-- 	config = true,
	-- },
	{
		"Bekaboo/dropbar.nvim",
		enalbed = true,
		event = "BufReadPost",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		config = function()
			require("plugins.dropbar-keymaps")
			require("dropbar").setup(require("plugins.dropbar-settings"))
		end,
	},
}, require("plugins.lazy"))
