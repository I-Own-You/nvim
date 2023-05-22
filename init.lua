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
-- require "plugins.symbols-outline"
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
require "plugins.mason-nvim-dap"
require "plugins.nvim-dap-ui"
require "plugins.lsp_lines"
require "plugins.colorscheme"
require "plugins.fzf-lua"
require "plugins.nvim-ts-autotag"

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



-- ITS FOR OLD FZF, :FZF, NOT FOR FZF-LUA
-- vim.g.fzf_preview_window = {'--preview', 'bat --style=numbers', '--color=always{}', 'ctrl-/'}
vim.g.fzf_preview_window = { 'right,50%', 'ctrl-/' }
vim.g.fzf_layout = {
    up='~90%',
    window= {
        width= 0.8,
        height= 0.8,
        offset=0.5,
        xoffset= 0.5,
        highlight= 'Todo',
        border= 'sharp',
    },
}

require "plugins.rnvimr"
vim.api.nvim_exec("autocmd BufWritePost * source ~/.config/nvim/lua/plugins/lualine.lua", false)
vim.api.nvim_exec("autocmd Filetype rnvimr tnoremap <buffer><nowait> j j", false)
vim.api.nvim_exec("autocmd Filetype rnvimr tnoremap <buffer><nowait> k k", false)
vim.api.nvim_exec("autocmd Filetype rnvimr tnoremap <buffer><nowait> <Space> <Space>", false)
-- vim.env.FZF_DEFAULT_COMMAND = "rg --files --hidden" --its for old fzf
-- vim.cmd('command! -bang -nargs=* Rg call fzf#vim#grep(\'rg --hidden --column --line-number --no-heading --color=always --smart-case -- \' . shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)') --its for old fzf
--

-- vim.diagnostic.config({ virtual_lines = false })
-- vim.diagnostic.config({ virtual_lines = true })
-- vim.diagnostic.config({ virtual_lines = { only_current_line = true } })

require("nvim-treesitter.install").prefer_git = true

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
