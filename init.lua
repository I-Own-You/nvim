vim.g.python_pep8_indent_multiline_string = -2
vim.g.python_pep8_indent_hang_closing = 0
-- vim.g.pymode_indent = 0
-- vim.g.navic_silence = true
vim.g.matchup_matchparen_offscreen = { method = "popup" }
vim.g.matchup_enabled = 1

-- vim.g.python_highlight_builtin_objs = 1
-- vim.g.python_highlight_builtin_types = 1
-- vim.g.python_highlight_exceptions = 1
-- vim.g.python_highlight_string_formatting = 1
-- vim.g.python_highlight_string_format = 1
-- vim.g.python_highlight_string_templates = 1
-- vim.g.python_highlight_doctests = 1
vim.g.python_highlight_func_calls = 1
-- vim.g.python_highlight_class_vars = 1
-- vim.g.python_highlight_operators = 1



require 'user.colorscheme'
require 'user.options'
require 'user.keymaps'
require 'user.plugins'
require 'user.colorizer'
require 'user.cmp'
require 'user.lsp'
require 'user.telescope'
require 'user.treesiter'
require 'user.autopairs'
require "user.comment"
require "user.gitsigns"
require "user.nvim-tree"
require "user.bufferline"
require "user.toggleterm"
require "user.lualine"
require "user.symbols-outline"
require "user.lsp-signature"
require "user.colorful-winsep"
require "user.wilder"
require "user.indent_blankline"
require "user.todo-comments"
require "user.treesj"
require "user.numb"
require "user.pretty-fold"
require "user.reach"
require "user.nvim-dap-virtual-text"
require "user.multiple-session"
require "user.hop"
require "user.luasnip-config"
-- require "user.custom_imports"


-- require "user.dashboard"

-- vim.api.nvim_command("autocmd VimEnter * Dashboard")


-- before configs and plugins
-- vim.cmd("command-to-be-executed")l
-- function SetLineNumbers()
--   vim.cmd("set number")
-- end
-- SetLineNumbers()


-- after configs and plugins
-- vim.api.nvim_command("command-to-be-executed")
-- function SetLineNumbers()
--   vim.api.nvim_command("set number")
-- end
-- vim.api.nvim_command("autocmd VimEnter * lua SetLineNumbers()")
