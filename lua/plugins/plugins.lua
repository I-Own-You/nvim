local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim ...")
	vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
    ]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
	max_jobs = 70,
})

return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- plugin manager

	use("NvChad/nvim-colorizer.lua") -- colorizer for colors

	use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp" }) -- cmp stuff
	use({ "hrsh7th/cmp-nvim-lua" }) -- cmp stuff

	-- Snippets
	use({ "L3MON4D3/LuaSnip", run = "make install_jsregexp" }) -- snippets
	use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

	use({ "neovim/nvim-lspconfig" }) -- enable LSP
	use({ "williamboman/nvim-lsp-installer" }) -- lsp installer
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- utility to install packages liek mason
	use({ "williamboman/mason.nvim" }) -- simple to use language server installer
	use({ "williamboman/mason-lspconfig.nvim" }) -- mason helper

	use({ "nvim-telescope/telescope.nvim" }) -- telescope
	use({ "nvim-treesitter/nvim-treesitter" }) -- nvim treesitter
	use({ "nvim-treesitter/nvim-treesitter-context" })

	use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter

	use({ "numToStr/Comment.nvim" }) -- comment utility
	use({ "JoosepAlviste/nvim-ts-context-commentstring" }) -- for templates

	use({ "kyazdani42/nvim-web-devicons" }) -- icons

	-- use({ "akinsho/bufferline.nvim" })
	use({ "moll/vim-bbye" }) -- buffer utility for close, etc.

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	}) -- status line

	use({ "ray-x/lsp_signature.nvim" })

	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	}) -- nvim key combinations for editing
	-- use({
	--     'python-rope/ropevim',
	--     ft = "python"
	-- })
	-- use { 'dense-analysis/ale' }
	use({ "nacro90/numb.nvim" }) -- move focus to the center when searching a line from command mode
	use({ "lukas-reineke/indent-blankline.nvim" }) -- indentation view

	use({ "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" }) -- mroe beautiful comments
	use({ "Wansmer/treesj", requires = { "nvim-treesitter" } }) -- toggle ({[]}) in half

	use({ "Vimjas/vim-python-pep8-indent" }) -- python indentation

	use({ "anuvyklack/pretty-fold.nvim" }) -- more beautiful fold view

	use({ "andymass/vim-matchup" }) -- vim match more character liek html tags, quotes, etc.

	use({ "kevinhwang91/nvim-bqf" }) -- more beautiful preview

	-- use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	-- use({ "theHamsta/nvim-dap-virtual-text" })
	-- use("jay-babu/mason-nvim-dap.nvim")

	use({ "notken12/base46-colors" }) -- themes from nvchad
	use({ "junegunn/fzf.vim" }) -- old fzf
	use({ "debugloop/telescope-undo.nvim" }) -- telescope undo things
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- make telescope faster
	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
	}) -- jump everywhere in the porject

	use("lewis6991/gitsigns.nvim") -- git signs
	use("rbong/vim-flog") -- git graph and functionality
	use("tpope/vim-fugitive")
	use({ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" }) -- more beautiful lsp signs
	use({ "ibhagwan/fzf-lua" }) -- fzf lua, the new fzf
	use("windwp/nvim-ts-autotag") -- autotag for idk what
	use({ "shortcuts/no-neck-pain.nvim" }) -- zen modes
	use({ "kevinhwang91/rnvimr" }) -- file manager
	use({
		"Exafunction/codeium.vim",
		config = function()
			vim.keymap.set("i", "<A-i>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<A-l>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
			vim.keymap.set("i", "<A-h>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })
		end,
	}) -- codeium like copilot
	use({ "hrsh7th/cmp-cmdline" }) -- auto show hints form command/search mode
	use({
		"jedrzejboczar/possession.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	}) -- session manager
	if PACKER_BOOTSSTRAP then
		require("packer").sync()
	end
end)
