local opts = { silent = true }

local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ' '

keymap('n', ';', ":", {noremap = true})
keymap('v', ';', ":", {noremap = true})
keymap('x', ';', ":", {noremap = true})
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)
keymap('n', '<leader>to', ':terminal<CR>', opts)
keymap('t', '<leader>tc', '<C-\\><C-n>', opts)

keymap('n', '<leader>td', ':TodoTelescope<CR>', opts)

keymap('n', '<leader>e', ':RnvimrToggle<cr>', opts)

keymap('n', 'q', '<Nop>', opts)

keymap('n', '<C-Up>', ':resize +2<CR>', opts)
keymap('n', '<C-Down>', ':resize -2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize +2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize -2<CR>', opts)

keymap('n', '<TAB>', ':bnext<CR>', opts)
keymap('n', '<S-TAB>', ':bprevious<CR>', opts)

keymap('i', 'jk', '<ESC>', opts)
keymap('i', 'kk', '<ESC>', opts)

keymap('n', '<leader>j', "<cmd>TSJToggle<cr>", opts)

keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

keymap('v', 'p', '"_dP', opts)
keymap('n', '<leader>ip', ':normal! gg0"0P<CR><C-o>', opts)
vim.api.nvim_set_keymap('n', '<Space>ii', 'yiw:lua require("custom_imports").centered_window()<CR>', { noremap = true, silent = true })

keymap('n', '<A-j>', ':m .+1<CR>==', opts)
keymap('n', '<A-k>', ':m .-2<CR>==', opts)
keymap('i', '<A-j>', '<ESC>:m .+1<CR>==gi', opts)
keymap('i', '<A-k>', '<ESC>:m .-2<CR>==gi', opts)
keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)
keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)

keymap('n', '<leader>vv', ':vsplit<CR>', opts)
keymap('n', '<leader>hh', ':split<CR>', opts)
keymap('n', '<leader>vd', ':vert diffsplit ', opts)

keymap('n', '<leader>mt', ':DiffviewOpen<CR>', opts)
keymap('n', '<leader>mk', ':DiffviewClose<CR>', opts)
keymap('n', '<leader>mf', ':DiffviewFileHistory<CR>', opts)

keymap("n", "<C-[>", "[m", opts)
keymap("n", "<C-]>", "]m", opts)

keymap("n", "<leader>ww", ":set invwrap<CR>:set wrap?<CR>", opts)
keymap("n", "!", ":!", { noremap = true })

keymap("n", "s", "<cmd>lua require('flash').jump()<CR>", { noremap = true })
keymap("x", "s", "<cmd>lua require('flash').jump()<CR>", { noremap = true })
keymap("o", "s", "<cmd>lua require('flash').jump()<CR>", { noremap = true })
keymap("n", "S", "<cmd>lua require('flash').treesitter()<CR>", { noremap = true })
keymap("o", "S", "<cmd>lua require('flash').treesitter()<CR>", { noremap = true })
keymap("x", "S", "<cmd>lua require('flash').treesitter()<CR>", { noremap = true })
keymap("o", "r", "<cmd>lua require('flash').remote()<CR>", { noremap = true })

keymap("n", "+", "<C-a>", { noremap = true, silent = true })
keymap("n", "-", "<C-x>", { noremap = true, silent = true })
keymap("v", "+", "<C-a>gv=gv", { noremap = true, silent = true })
keymap("v", "-", "<C-x>gv=gv", { noremap = true, silent = true })
keymap("x", "+", "<C-a>", { noremap = true, silent = true })
keymap("x", "-", "<C-x>", { noremap = true, silent = true })

keymap('n', '<C-c>', ":%y<CR>", opts)
keymap('n', '<C-a>', "ggVG", opts)
keymap('n', '<C-x>', ":%d<CR>", opts)

vim.keymap.set("n", "<leader>kk",
    function()
        local ok, start = require("indent_blankline.utils").get_current_context(
            vim.g.indent_blankline_context_patterns,
            vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
            vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
            vim.cmd [[normal! _]]
        end
    end,
    opts
)
keymap("n", "<leader>kl", ":lua require('barbecue.ui').navigate(-)<left>", {noremap = true})

keymap("n", "<leader>dd", ":DevdocsOpenCurrentFloat<CR>", {noremap = true})

vim.keymap.set('n', 'zR', function() require('ufo').openAllFolds() end, {silent = true})
vim.keymap.set('n', 'zM', function() require('ufo').closeAllFolds() end, {silent = true})

keymap("n", "<leader>nh", ":nohlsearch<CR>", opts)

keymap("n", "<leader>bo", ":only<CR>", opts)
keymap("n", "<leader>bda", ":%bdelete<CR>", opts)
keymap('n', '<leader>bdo', ':%bd|e#|bd#<CR>|\'\"', { noremap = true, silent = true })

-- session keymaps
keymap('n', '<leader>sl', ':Telescope possession list<CR>', { noremap = true, silent = true })
keymap('n', '<leader>ss', ':PossessionSave ', {noremap = true})

keymap('n', '<leader>dj', ':set filetype=htmldjango<CR>', { noremap = true, silent = true })
keymap('n', '<leader>dh', ':set filetype=html<CR>', { noremap = true, silent = true })
-- Open/close quickfix window faster
-- keymap("n", ",qc", ":cclose<CR>", opts)
-- keymap("n", ",qo", ":copen<CR>", opts)

-- keymap("n", "<leader><leader>", "<cmd>Telescope live_grep<cr>", opts)
-- keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
-- keymap("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <cr>", opts)
-- keymap("n", "<leader>fb", "<cmd>Telescope buffers <cr>", opts)
keymap("n", "<leader>tu", "<cmd>Telescope undo <cr>", opts)
-- keymap("n", "<leader>ft", "<cmd>Telescope help_tags <cr>", opts)
-- keymap("n", "<leader>fo", "<cmd>Telescope oldfiles <cr>", opts)
-- keymap("n", "<leader>fk", "<cmd>Telescope keymaps <cr>", opts)
-- keymap("n", "<leader>gsh", "<cmd>Telescope git_stash <cr>", opts)
-- keymap("n", "<leader>gbb", "<cmd>Telescope git_branches <cr>", opts)
-- keymap("n", "<leader>gf", "<cmd>Telescope git_files <cr>", opts)
-- keymap("n", "<leader>tgc", "<cmd>Telescope git_commits <cr>", opts)
-- keymap("n", "<leader>gst", "<cmd>Telescope git_status <cr>", opts)
-- keymap("n", "<leader>gbc", "<cmd>Telescope git_bcommits <cr>", opts)

-- flog vim
keymap("n", "<leader>fgg", ":Flog ", {noremap = true})
keymap("n", "<leader>fb", ":Floggit ", {noremap = true})
keymap("n", "<leader>gc", ":Floggit commit -m \"\"<left>", {noremap = true})
keymap("n", "<leader>gp", ":Floggit push<CR>", opts)
keymap("n", "<leader>fs", ":Flogsplit ", {noremap = true})

-- FzfLua buffers and files
keymap("n", "<leader>ff", ":FzfLua files<CR>", opts)
keymap("n", "<leader>fa", ":lua require('fzf-lua').files({fd_opts = '--color=never --type f --hidden --follow --no-ignore'})<CR>", opts)
keymap('n', '<leader>bb', ":FzfLua buffers<CR>", opts)
keymap('n', '<leader>ho', ":FzfLua oldfiles<CR>", opts)
keymap('n', '<leader>ll', ":FzfLua lines<CR>", opts)
-- keymap('n', '<leader>lb', ":FzfLua blines<CR>", opts) used in search categore because of speed
-- quickfix
-- quickfix_stack
-- loclist
-- loclist_stack
-- args
-- tabs
-- FzfLua git
keymap("n", "<leader>gst", ":FzfLua git_status<CR>", opts)
keymap("n", "<leader>gls", ":FzfLua git_files<CR>", opts)
keymap("n", "<leader>fgl", ":FzfLua git_commits<CR>", opts)
keymap("n", "<leader>fgb", ":FzfLua git_bcommits<CR>", opts)
keymap("n", "<leader>gbb", ":FzfLua git_branches<CR>", opts)
keymap("n", "<leader>gsh", ":FzfLua git_stash<CR>", opts)
-- FzfLua lsp/diagnostics
keymap("n", "gr", ":FzfLua lsp_references<CR>", opts)

keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
-- keymap("n", "gd", ":FzfLua lsp_definitions<CR>", opts)
-- keymap("n", "gD", ":FzfLua lsp_declarations<CR>", opts)
-- keymap("n", "<leader>D", ":FzfLua lsp_typedefs<CR>", opts)
-- keymap("n", "gi", ":FzfLua lsp_implementations<CR>", opts)
keymap("n", "<leader>oo", ":FzfLua lsp_document_symbols<CR>", opts)
keymap("n", "<leader>ow", ":FzfLua lsp_workspace_symbols<CR>", opts)
keymap("n", "<leader>ol", ":FzfLua lsp_live_workspace_symbols<CR>", opts)
keymap("n", "<leader>ca", ":FzfLua lsp_code_actions<CR>", opts)
keymap("n", "gR", ":FzfLua lsp_finder<CR>", opts)
keymap('n', '<leader>lq', ":FzfLua lsp_document_diagnostics<CR>", opts)
keymap('n', '<leader>lw', ":FzfLua lsp_workspace_diagnostics<CR>", opts)
-- lsp_incoming_calls
-- lsp_outgoing_calls
-- FzfLua misc
keymap('n', '<leader>bt', ":FzfLua builtin<CR>", opts)
keymap('n', '<leader>ht', ":FzfLua help_tags<CR>", opts)
keymap('n', '<leader>hc', ":FzfLua command_history<CR>", opts)
keymap('n', '<leader>hs', ":FzfLua search_history<CR>", opts)
keymap('n', '<leader>fk', ":FzfLua keymaps<CR>", opts)
-- resume
-- profiles
-- man_pages
-- colorschemes
-- highlights
-- commands
-- marks
-- jumps
-- changes
-- registers
-- tagstack
-- autocmds
-- filetypes
-- menus
-- spell_suggest
-- packadd
-- FzfLua tags
keymap('n', '<leader>tt', ":FzfLua tags<CR>", opts)
keymap('n', '<leader>tb', ":FzfLua btags<CR>", opts)
keymap('n', '<leader>tw', ":FzfLua tags_grep_cword<CR>", opts)
keymap('n', '<leader>tl', ":FzfLua tags_live_grep<CR>", opts)
-- tags_grep
-- tags_grep_cWORD
-- tags_grep_visual
-- FzfLua search
keymap("n", "<leader><leader>", ":FzfLua grep_project<CR>", opts)
keymap("n", "<leader>a", ":lua require('fzf-lua').grep_project({rg_opts = '--hidden --no-ignore --column --line-number --no-heading --color=always --smart-case --max-columns=4096'})<CR>", opts)
keymap("n", "<leader>gw", ":FzfLua grep_cword<CR>", opts)
keymap('n', '<leader>lb', ":FzfLua lgrep_curbuf<CR>", opts)
-- grep
-- grep_last
-- grep_cword
-- grep_cWORD
-- grep_visual
-- lgrep_curbuf
-- live_grep
-- live_grep_resume
-- live_grep_glob
-- live_grep_native

-- nvim-dap didnt add
-- problems with lsp_workspace_symbols

keymap('n', '<leader>q', ':Bdelete!<cr>', opts)

-- keymap('n', '<leader>o', ':SymbolsOutline<cr>', opts)

keymap('n', '<leader>nb', ':enew<cr>', opts)

keymap('n', '<C-d>', '15j', opts)
keymap('n', '<C-u>', '15k', opts)

vim.keymap.set('n', '<leader>/', function() require("Comment.api").toggle.linewise.current() end, opts)
keymap('v', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)


keymap("n", "<leader>hw", ":HopWord<CR>", opts)

-- git section
keymap("n", "<leader>nn", ":Gitsigns next_hunk<cr>",  opts)
keymap("n", "<leader>pp", ":Gitsigns prev_hunk<cr>",  opts)
keymap("n", "<leader>bl", ":Gitsigns blame_line<cr>",  opts)
keymap("n", "<leader>ph", ":Gitsigns preview_hunk<cr>",  opts)
keymap("n", "<leader>pih", ":Gitsigns preview_hunk_inline<cr>",  opts)
keymap("n", "<leader>sh", ":Gitsigns stage_hunk<cr>",  opts)
keymap("n", "<leader>sb", ":Gitsigns stage_buffer<cr>",  opts)
keymap("n", "<leader>ush", ":Gitsigns undo_stage_hunk<cr>",  opts)
keymap("n", "<leader>rbb", ":Gitsigns reset_buffer<cr>",  opts)
keymap("n", "<leader>rbi", ":Gitsigns reset_buffer_index<cr>",  opts)
keymap("n", "<leader>rh", ":Gitsigns reset_hunk<cr>",  opts)
keymap("n", "<leader>gsw", ":Gitsigns show ",  {noremap = true})
-- keymap("n", "<leader>gcb", ":Gitsigns change_base ",  opts)
keymap("n", "<leader>gid", ":Gitsigns diffthis ",  {noremap = true})

-- STAGE THIS
-- keymap("n", "<leader>dru", ":lua require('dap').continue()<CR>", opts)
-- keymap("n", "<C-n>", ":lua require('dap').step_into()<CR>", opts)
-- keymap("n", "<Leader>dov", ":lua require('dap').step_over()<CR>", opts)
-- keymap("n", "<Leader>dou", ":lua require('dap').step_out()<CR>", opts)
-- keymap("n", "<Leader>dst", ":lua require('dap').terminate()<CR>", opts)
-- keymap("n", "<Leader>drr", ":lua require('dap').run_last()<CR>", opts)


-- keymap("n", "<Leader>dro", ":lua require('dap').repl.toggle()<CR>", opts)

-- keymap("n", "<Leader>bpe", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
-- keymap("n", "<Leader>bpm", ":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
-- keymap("n", "<Leader>bpc", ":lua require('dap').clear_breakpoints()<CR>:lua require('debugger_signs_adjust').ontl()<CR>", opts)
-- keymap("n", "<Leader>bpp", ":lua require('dap').toggle_breakpoint()<CR>:lua require('debugger_signs_adjust').offtl()<CR>", opts)

-- keymap("n", "<Leader>dii", ":lua require('dapui').toggle()<CR>", opts)

-- keymap("n", "<Leader>sv", ":lua require('dap.ui.widgets').hover()<CR>", opts)
-- keymap("n", "<Leader>sv", ":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", opts)

keymap("n", "<Leader>xo", ":!dolphin %:p:h &<CR><CR>", opts)
keymap("n", "<Leader>xt", ':let @+=expand("%:p:h")<CR>', opts)

-- keymap("n", ":w<CR>", ":w<CR>:so ~/.config/nvim/lua/plugins/lualine.lua<CR>", opts)
-- za - toggle fold
-- zf(line numbers)j|k - fold up or down
-- zf/ - fold till the line where you type the string
-- zj - next fold
-- zk - previous fold
-- zO - opens all folds
-- zM - close all folds
-- zE - deletes all folds
-- zd - deletes fold at current cursor
-- [z - start of fold
-- ]z - end of fold
