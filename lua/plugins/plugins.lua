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
	use("wbthomason/packer.nvim")

	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")
	use("norcalli/nvim-colorizer.lua")

	use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })

	-- Snippets
	use({ "L3MON4D3/LuaSnip", run = "make install_jsregexp" })
	use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

	use({ "neovim/nvim-lspconfig" }) -- enable LSP
	use({ "williamboman/nvim-lsp-installer" })
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "williamboman/mason.nvim" }) -- simple to use language server installer
	use({ "williamboman/mason-lspconfig.nvim" })

	use({ "nvim-telescope/telescope.nvim" })
	use({ "nvim-treesitter/nvim-treesitter" })

	-- stopped here
	use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter

	use({ "numToStr/Comment.nvim" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })

	use({ "kyazdani42/nvim-web-devicons" })
	-- use({ "kyazdani42/nvim-tree.lua" })

	use({ "akinsho/bufferline.nvim" })
	use({ "moll/vim-bbye" })

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- use { "tpope/vim-fugitive" }

	use({ "ray-x/lsp_signature.nvim" })

	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})
	-- use({
	--     'python-rope/ropevim',
	--     ft = "python"
	-- })
	-- use { 'dense-analysis/ale' }
	use({ "nacro90/numb.nvim" })
	use({ "lukas-reineke/indent-blankline.nvim" })

	use({ "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" })
	use({ "Wansmer/treesj", requires = { "nvim-treesitter" } })

	use({ "Vimjas/vim-python-pep8-indent" })

	use({ "anuvyklack/pretty-fold.nvim" })
	use({
		"utilyre/barbecue.nvim",
		tag = "*",
		requires = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		after = "nvim-web-devicons", -- keep this if you're using NvChad
		config = function()
			require("barbecue").setup()
		end,
	})
	use("toppair/reach.nvim")

	use({ "andymass/vim-matchup" })

	use({ "kevinhwang91/nvim-bqf" })
	use({
		"junegunn/fzf",
		run = function()
			vim.fn["fzf#install"]()
		end,
	})

	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use({ "theHamsta/nvim-dap-virtual-text" })
	use("folke/neodev.nvim")

	use({ "niuiic/niuiic-core.nvim" })

	-- use {
	--     'glepnir/dashboard-nvim',
	-- }
	use({ "notken12/base46-colors" })
	use({ "junegunn/fzf.vim" })
	use({ "debugloop/telescope-undo.nvim" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
	})

	use("tpope/vim-fugitive")

	use("lewis6991/gitsigns.nvim")
	use("rbong/vim-flog")
	use("jay-babu/mason-nvim-dap.nvim")
	use("ntk148v/vim-horizon")
	use({ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" })
	use("folke/tokyonight.nvim")
	use({ "ibhagwan/fzf-lua" })
	use("windwp/nvim-ts-autotag")
	use({ "kelly-lin/ranger.nvim" })
	use({ "shortcuts/no-neck-pain.nvim" })
	use({ "kevinhwang91/rnvimr" })
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
	})
	use({ "hrsh7th/cmp-cmdline" })
	use({
		"jedrzejboczar/possession.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
	if PACKER_BOOTSSTRAP then
		require("packer").sync()
	end
end)
