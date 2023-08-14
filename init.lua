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
    config = function() vim.cmd([[colorscheme nordic]]) end,
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
	{ "hrsh7th/cmp-emoji" },
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
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require("nvim-treesitter.configs").setup(require 'plugins.treesiter')
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
    enabled = true,
    config = function()
      require("indent_blankline").setup(require 'plugins.indent_blankline')
      vim.cmd([[highlight IndentBlanklineContextStart guisp=#8FBCBB gui=underline]])
      vim.g.indent_blankline_filetype_exclude = {'dashboard'}
    end
  },
  {
    "shellRaining/hlchunk.nvim",
    enabled = false,
    event = { "UIEnter" },
    config = function()
      require("hlchunk").setup(require 'plugins.hlchunk')
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
    config = function()
      vim.cmd([[highlight MatchParen guibg=#5C4E4E]])
      vim.cmd([[highlight MatchParen gui=NONE]])
    end
  },
  {
    "kylechui/nvim-surround",
    tag = "*",
    event = "VeryLazy",
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
    enabled = false,
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
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup(require 'plugins.inc_rename')
    end,
  },
  {
    'VidocqH/lsp-lens.nvim',
    enabled = false,
    config = function()
      require("lsp-lens").setup(require 'plugins.lsp-lens')
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
  },
  {
    "xiantang/darcula-dark.nvim",
  },
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require 'nordic' .setup(require 'plugins.nordic')
    end
  },
  {
    'sindrets/diffview.nvim'
  },
  {
    'kevinhwang91/nvim-ufo',
    -- look into handlers.lua/keymaps.lua there is code for ufo.nvim, in case you delete the pluign
    dependencies = {
      'kevinhwang91/promise-async',
      {
        "luukvbaal/statuscol.nvim", -- tweak for right columnt that shows redundant digits
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup(
            {
              relculright = true,
              segments = {
                {text = {builtin.foldfunc}, click = "v:lua.ScFa"},
                {text = {"%s"}, click = "v:lua.ScSa"},
                {text = {builtin.lnumfunc, " "}, click = "v:lua.ScLa"}
              }
            }
          )
        end
      }
    },
    init = function()
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.opt.foldcolumn = '1' -- '0' is not bad
      vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.opt.foldlevelstart = 99
      vim.opt.foldenable = true
    end,
    config = function()
      require('ufo').setup(require 'plugins.ufo')
    end
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "kyazdani42/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup(require 'plugins.dashboard')
    end,
    dependencies = { {'kyazdani42/nvim-web-devicons'}}
  },
  {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require('nvim-devdocs').setup(require 'plugins.devdocs')
    end,
  },
  {
    "ellisonleao/glow.nvim",
    lazy = false,
    config = function ()
      require('glow').setup(require 'plugins.glow')
    end,
    cmd = "Glow",
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

vim.api.nvim_exec("autocmd BufWritePost * source ~/.config/nvim/lua/plugins/lualine.lua", false)
vim.api.nvim_exec("autocmd Filetype rnvimr tnoremap <buffer><nowait> j j", false)
vim.api.nvim_exec("autocmd Filetype rnvimr tnoremap <buffer><nowait> k k", false)
vim.api.nvim_exec("autocmd Filetype rnvimr tnoremap <buffer><nowait> <Space> <Space>", false)

vim.cmd([[
augroup DjangoHtmlHighlight
  autocmd!
  autocmd FileType htmldjango highlight MatchParen guibg=NONE
augroup END
]])

-- vim.diagnostic.config({ virtual_lines = false })
-- vim.diagnostic.config({ virtual_lines = true })
-- vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
