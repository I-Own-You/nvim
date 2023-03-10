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



require "plugins.colorscheme"
require "plugins.plugins"
require "user.options"
require "user.keymaps"
require "plugins.colorizer"
require "plugins.cmp"
require "plugins.lsp"
require "plugins.telescope"
require "plugins.treesiter"
require "plugins.autopairs"
require "plugins.comment"
require "plugins.gitsigns"
require "plugins.nvim-tree"
require "plugins.bufferline"
require "plugins.toggleterm"
require "plugins.lualine"
require "plugins.symbols-outline"
-- require "plugins.lsp-signature"
require "plugins.colorful-winsep"
require "plugins.wilder"
require "plugins.indent_blankline"
require "plugins.todo-comments"
require "plugins.treesj"
require "plugins.numb"
require "plugins.pretty-fold"
require "plugins.reach"
require "plugins.nvim-dap-virtual-text"
require "plugins.multiple-session"
require "plugins.hop"
require "plugins.luasnip-config"
require "plugins.true-zen"

-- require "plugins.dashboard"

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
