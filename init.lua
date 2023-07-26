require 'user.options'
require 'user.keymaps'

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
    'notken12/base46-colors',
    lazy = false,
    priority = 1000,
    config = function() vim.cmd([[colorscheme gatekeeper]]) end,
  },
	{
    "neovim/nvim-lspconfig",
    config = function()
      require 'plugins.lsp.handlers'.setup()
    end
  },
	{
    "williamboman/mason.nvim",
    -- use({ "williamboman/nvim-lsp-installer" }) -- lsp installer
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    build = ":MasonUpdate",
    config = function()
      require 'plugins.lsp.mason'
    end
  },
	{
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'plugins.lsp.null-ls'
    end
  },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "saadparwaiz1/cmp_luasnip" },
	{
    "hrsh7th/nvim-cmp",
    config = function()
      require('cmp').setup(require 'plugins.cmp')
      local cmp = require('cmp')

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- `?` cmdline setup.
      cmp.setup.cmdline('?', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = {}
            }
          }
        })
      })
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require("nvim-treesitter.configs").setup(require 'plugins.treesiter')
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require("treesitter-context").setup(require 'plugins.treesitter-context')
    end
  },
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require("fzf-lua").setup(require 'plugins.fzf-lua')
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require("lualine").setup(require 'plugins.lualine')
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("indent_blankline").setup(require 'plugins.indent_blankline')
    end
  },
  {
    'kevinhwang91/rnvimr',
    config = function()
      require 'plugins.rnvimr'
    end
  },
  {
    'nacro90/numb.nvim',
    config = function()
      require("numb").setup(require 'plugins.numb')
    end
  },
  {
    'kevinhwang91/nvim-bqf',
  },
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require("colorizer").setup(require 'plugins.colorizer')
    end
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require 'plugins.comment'
    end
  },
	{
		"phaazon/hop.nvim",
    config = function()
      require'hop'.setup()
    end
	},
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup(require 'plugins.gitsigns')
    end
  },
  {
    "moll/vim-bbye",
  },

  {
    "windwp/nvim-autopairs" ,
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup(require 'plugins.autopairs')
      -- local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      -- local cmp = require('cmp')
      -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {})
    end
  },
  {
    "Wansmer/treesj",
    dependencies = { 'nvim-treesitter' },
    opts = { use_default_keymaps = false, max_join_length = 999 },
  },
	{
    "Vimjas/vim-python-pep8-indent",
  },
	{
    "andymass/vim-matchup",
  },
  {
    "kylechui/nvim-surround",
    tag = "*",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
	{
		"jedrzejboczar/possession.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('possession').setup(require 'plugins.session')
    end
	},
	{
    "nvim-telescope/telescope.nvim",
    dependencies = { "debugloop/telescope-undo.nvim" },
    config = function()
      require('telescope').setup(require 'plugins.telescope')
      require("telescope").load_extension("undo")
      require('telescope').load_extension('possession')
    end
  },
  {
    "folke/todo-comments.nvim",
    config = function()
      require('todo-comments').setup(require 'plugins.todo-comments')
    end
  },
	{
    "rbong/vim-flog",
    dependencies = {'tpope/vim-fugitive'}
  },
	{
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-ts-autotag').setup(require 'plugins.nvim-ts-autotag')
    end
  },
	{
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require('lsp_lines').setup({})
    end
  },
	{
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = function()
      require "lsp_signature".setup(require 'plugins.lsp-signature')
    end
  },
	{
    "akinsho/bufferline.nvim",
    enabled = false,
    config = function()
      require "bufferline".setup(require 'plugins.bufferline')
    end
  },
	{
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
  },
})

-- vim.cmd('highlight Search guifg=#F24211  guibg=#000000')
-- vim.cmd('highlight IncSearch guifg=#F24211 guibg=#000000')
-- vim.cmd('highlight Substitute guifg=#F24211  guibg=#000000')

vim.api.nvim_set_hl(0, "dap_breakpoint_red",   { fg = "#ff0011" })
vim.api.nvim_set_hl(0, "dap_log_point",  { fg = "#31353f" })
vim.api.nvim_set_hl(0, "dap_stopped", { fg = "#00E756" })
vim.api.nvim_set_hl(0, "dap_condition", { fg = "#F24211" })


vim.fn.sign_define('DapBreakpoint',          { text='', texthl='dap_breakpoint_red',   linehl='', numhl='', priority = 1000})
vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='dap_condition',   linehl='', numhl='' })
vim.fn.sign_define('DapBreakpointRejected',  { text='', texthl='dap_breakpoint_red', linehl='', numhl='' })
vim.fn.sign_define('DapStopped',             { text='', texthl='dap_stopped',  linehl='', numhl='' })
vim.fn.sign_define('DapLogPoint',            { text='', texthl='dap_log_point', linehl='', numhl='' })

vim.api.nvim_exec("autocmd BufWritePost * source ~/.config/nvim/lua/plugins/lualine.lua", false)
vim.api.nvim_exec("autocmd Filetype rnvimr tnoremap <buffer><nowait> j j", false)
vim.api.nvim_exec("autocmd Filetype rnvimr tnoremap <buffer><nowait> k k", false)
vim.api.nvim_exec("autocmd Filetype rnvimr tnoremap <buffer><nowait> <Space> <Space>", false)

-- vim.diagnostic.config({ virtual_lines = false })
-- vim.diagnostic.config({ virtual_lines = true })
-- vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
