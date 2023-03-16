local opts = { silent = true }

local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

local options_buff = {
  handle = 'dynamic',              -- 'bufnr' or 'dynamic' or 'auto'
  show_icons = true,
  show_current = false,         -- Include current buffer in the list
  show_modified = true,         -- Show buffer modified indicator
  modified_icon = '⬤',          -- Character to use as modified indicator
  grayout_current = true,       -- Wheter to gray out current buffer entry
  force_delete = {},            -- List of filetypes / buftypes to use
                                -- 'bdelete!' on, e.g. { 'terminal' }
  filter = nil,                 -- Function taking bufnr as parameter,
                                -- returning true or false
  sort = nil,                   -- Comparator function (bufnr, bufnr) -> bool
  terminal_char = '\\',         -- Character to use for terminal buffer handles
                                -- when options.handle is 'dynamic'
  grayout = true,               -- Gray out non matching entries

  -- A list of characters to use as handles when options.handle == 'auto'
 auto_handles = require('reach.buffers.constant').auto_handles,
  auto_exclude_handles = {},    -- A list of characters not to use as handles when
                                -- options.handle == 'auto', e.g. { '8', '9', 'j', 'k' }
  previous = {
    enable = true,              -- Mark last used buffers with specified chars and colors
    depth = 2,                  -- Maximum number of buffers to mark
    chars = { '•' },            -- Characters to use as markers,
                                -- last one is used when depth > #chars
    groups = {                  -- Highlight groups for markers,
      'String',                 -- last one is used when depth > #groups
      'Comment',
    },
  },
  -- A map of action to key that should be used to invoke it
  actions = {
    split = '-',
    vertsplit = '|',
    tabsplit = ']',
    delete = '<Space>',
    priority = '=',
  },
}

local options_marks = {
  filter = function(mark)
    return mark:match('[a-zA-Z]') -- return true to disable
  end,
  -- A map of action to key that should be used to invoke it
  actions = {
    split = '-',
    vertsplit = '|',
    tabsplit = ']',
    delete = '<Space>',
  },
}


local options_tabs = {
  show_icons = true,
  show_current = false,
  -- A map of action to key that should be used to invoke it
  actions = {
    delete = '<Space>',
  },
}

local options_cscheme = {
  filter = (function()
    local default = {
      'blue', 'darkblue', 'default', 'delek', 'desert', 'elflord', 'evening', 'industry', 'koehler',
      'morning', 'murphy', 'pablo', 'peachpuff', 'ron', 'shine', 'slate', 'torte', 'zellner',
    }

    return function(name)
      return not vim.tbl_contains(default, name) -- return true to disable

    end
  end)(),
}

vim.g.mapleader = ' '

keymap('n', ';', ':', opts)
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)


keymap('n', '<leader>e', ':NvimTreeToggle<cr>', opts)

keymap('n', '<C-Up>', ':resize +2<CR>', opts)
keymap('n', '<C-Down>', ':resize -2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize +2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize -2<CR>', opts)

keymap('n', '<TAB>', ':bnext<CR>', opts)
keymap('n', '<S-TAB>', ':bprevious<CR>', opts)

keymap('i', 'jk', '<ESC>', opts)

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

keymap("n", "<C-[>", "[m", opts)
keymap("n", "<C-]>", "]m", opts)

keymap("n", "<leader>tw", ":set invwrap<CR>:set wrap?<CR>", opts)
keymap("n", "!", ":!", { noremap = true })

-- dont forget to map <space>j in the plugin that splits {} and etc

keymap("n", "+", "<C-a>", { noremap = true, silent = true })
keymap("n", "-", "<C-x>", { noremap = true, silent = true })

keymap('n', '<C-c>', ":%y<CR>", opts)
keymap('n', '<C-a>', "ggVG", opts)
keymap('n', '<C-x>', ":%d<CR>", opts)


keymap("n", ",.", "'.", opts) -- go to last edited location

keymap("n", "<leader>nh", ":nohlsearch<CR>", opts)

keymap("n", "<leader>bo", ":only<CR>", opts)
keymap("n", "<leader>bda", ":%bdelete<CR>", opts)
keymap('n', '<leader>bdo', ':%bd|e#|bd#<CR>|\'\"', { noremap = true, silent = true })

-- Open/close quickfix window faster
-- keymap("n", ",qc", ":cclose<CR>", opts)
-- keymap("n", ",qo", ":copen<CR>", opts)

-- keymap("n", "<leader><leader>", "<cmd>Telescope live_grep<cr>", opts)
-- keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
-- keymap("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <cr>", opts)
-- keymap("n", "<leader>fb", "<cmd>Telescope buffers <cr>", opts)
keymap("n", "<leader>tu", "<cmd>Telescope undo <cr>", opts)
keymap("n", "<leader>ft", "<cmd>Telescope help_tags <cr>", opts)
keymap("n", "<leader>fo", "<cmd>Telescope oldfiles <cr>", opts)
keymap("n", "<leader>fk", "<cmd>Telescope keymaps <cr>", opts)
keymap("n", "<leader>gsh", "<cmd>Telescope git_stash <cr>", opts)
keymap("n", "<leader>tgb", "<cmd>Telescope git_branches <cr>", opts)
keymap("n", "<leader>gf", "<cmd>Telescope git_files <cr>", opts)
keymap("n", "<leader>tgc", "<cmd>Telescope git_commits <cr>", opts)
-- keymap("n", "<leader>gst", "<cmd>Telescope git_status <cr>", opts)
-- keymap("n", "<leader>gbc", "<cmd>Telescope git_bcommits <cr>", opts)

-- flog vim
keymap("n", "<leader>fg", ":Flog ", opts)
keymap("n", "<leader>fb", ":Floggit ", opts)
keymap("n", "<leader>fs", ":Flogsplit ", opts)

-- FZF
keymap("n", "<leader><leader>", ":Rg<CR>", opts)
keymap("n", "<leader>ff", ":Files<CR>", opts)
keymap("n", "<leader>fe", ":Locate ", opts)
keymap('n', '<leader>bb', ":Buffers<CR>", opts)
keymap('n', '<leader>ht', ":Helptags<CR>", opts)
keymap('n', '<leader>hs', ":History/<CR>", opts)
keymap('n', '<leader>hc', ":History:<CR>", opts)
keymap('n', '<leader>ho', ":History<CR>", opts)
keymap('n', '<leader>ll', ":Lines<CR>", opts)
keymap('n', '<leader>lb', ":BLines<CR>", opts)
keymap("n", "<leader>gst", ":GFiles?<CR>", opts)
keymap("n", "<leader>gls", ":GFiles<CR>", opts)
keymap("n", "<leader>gc", ":Commits<CR>", opts)
keymap("n", "<leader>bc", ":BCommits<CR>", opts)
-- :Maps
-- :Commands
-- :FileTypes
-- :Mars
-- :Windows
-- :Tags
-- :BTags
-- keymap("n", "<leader>fz", ":FZF<cr>", opts)

keymap('n', '<leader>q', ':Bdelete<cr>', opts)

keymap('n', '<leader>o', ':SymbolsOutline<cr>', opts)

keymap('n', '<leader>nb', ':enew<cr>', opts)

keymap('n', '<C-d>', '15j', opts)
keymap('n', '<C-u>', '15k', opts)

vim.keymap.set('n', '<leader>/', function() require("Comment.api").toggle.linewise.current() end, opts)
keymap('v', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

-- vim.keymap.set('n', '<leader>bb', function() require('reach').buffers(options_buff) end, {})
-- vim.keymap.set('n', '<leader>m', function() require('reach').marks(options_marks) end, {})
vim.keymap.set('n', '<leader>tt', function() require('reach').tabpages(options_tabs) end, {})
vim.keymap.set('n', '<leader>rc', function() require('reach').colorschemes(options_cscheme) end, {})

-- sessions
keymap("n", "<leader>ss", ":SaveSession<CR>", opts)
keymap("n", "<leader>sr", ":RestoreSession<CR>", opts)
keymap("n", "<leader>sa", ":EnableAutoSaveSession<CR>", opts)
keymap("n", "<leader>sA", ":DisableAutoSaveSession<CR>", opts)
keymap("n", "<leader>sd", ":DeleteSession<CR>", opts)


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
keymap("n", "<leader>gsw", ":Gitsigns show ",  opts)
-- keymap("n", "<leader>gcb", ":Gitsigns change_base ",  opts)
keymap("n", "<leader>gid", ":Gitsigns diffthis ",  opts)

-- STAGE THIS
keymap("n", "<leader>dru", ":lua require('dap').continue()<CR>", opts)
keymap("n", "<C-n>", ":lua require('dap').step_into()<CR>", opts)
keymap("n", "<Leader>dov", ":lua require('dap').step_over()<CR>", opts)
keymap("n", "<Leader>dou", ":lua require('dap').step_out()<CR>", opts)
keymap("n", "<Leader>dst", ":lua require('dap').terminate()<CR>", opts)
keymap("n", "<Leader>drr", ":lua require('dap').run_last()<CR>", opts)


keymap("n", "<Leader>dro", ":lua require('dap').repl.toggle()<CR>", opts)

keymap("n", "<Leader>bpe", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap("n", "<Leader>bpm", ":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
keymap("n", "<Leader>bpc", ":lua require('dap').clear_breakpoints()<CR>:lua require('debugger_signs_adjust').ontl()<CR>", opts)
keymap("n", "<Leader>bpp", ":lua require('dap').toggle_breakpoint()<CR>:lua require('debugger_signs_adjust').offtl()<CR>", opts)

keymap("n", "<Leader>dii", ":lua require('dapui').toggle()<CR>", opts)

-- keymap("n", "<Leader>sv", ":lua require('dap.ui.widgets').hover()<CR>", opts)
keymap("n", "<Leader>sv", ":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", opts)

keymap("n", "<Leader>xo", ":lua require('open_file_path').OpenCurrentFolder()<CR>", opts)

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
