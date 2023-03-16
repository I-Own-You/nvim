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
require "plugins.mason-nvim-dap"
require "plugins.nvim-dap-ui"

vim.cmd('highlight Search guifg=#F24211  guibg=#000000')
vim.cmd('highlight IncSearch guifg=#F24211 guibg=#000000')
vim.cmd('highlight Substitute guifg=#F24211  guibg=#000000')


vim.api.nvim_set_hl(0, "dap_breakpoint_red",   { fg = "#ff0011" })
vim.api.nvim_set_hl(0, "dap_log_point",  { fg = "#31353f" })
vim.api.nvim_set_hl(0, "dap_stopped", { fg = "#00E756" })
vim.api.nvim_set_hl(0, "dap_condition", { fg = "#F24211" })


vim.fn.sign_define('DapBreakpoint',          { text='', texthl='dap_breakpoint_red',   linehl='', numhl='', priority = 1000})
vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='dap_condition',   linehl='', numhl='' })
vim.fn.sign_define('DapBreakpointRejected',  { text='', texthl='dap_breakpoint_red', linehl='', numhl='' })
vim.fn.sign_define('DapStopped',             { text='', texthl='dap_stopped',  linehl='', numhl='' })
vim.fn.sign_define('DapLogPoint',            { text='', texthl='dap_log_point', linehl='', numhl='' })

vim.g.show_lsp_signs = true

vim.api.nvim_exec("autocmd BufWritePost * source ~/.config/nvim/lua/plugins/lualine.lua", false)

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
