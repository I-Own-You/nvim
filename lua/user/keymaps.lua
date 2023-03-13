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

keymap("n", "<leader><leader>", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <cr>", opts)
-- keymap("n", "<leader>fb", "<cmd>Telescope buffers <cr>", opts)
keymap("n", "<leader>tu", "<cmd>Telescope undo <cr>", opts)
keymap("n", "<leader>ft", "<cmd>Telescope help_tags <cr>", opts)
keymap("n", "<leader>fo", "<cmd>Telescope oldfiles <cr>", opts)
keymap("n", "<leader>fk", "<cmd>Telescope keymaps <cr>", opts)
keymap("n", "<leader>gsh", "<cmd>Telescope git_stash <cr>", opts)
keymap("n", "<leader>gb", "<cmd>Telescope git_branches <cr>", opts)
keymap("n", "<leader>gf", "<cmd>Telescope git_files <cr>", opts)
keymap("n", "<leader>gc", "<cmd>Telescope git_commits <cr>", opts)
keymap("n", "<leader>gst", "<cmd>Telescope git_status <cr>", opts)
keymap("n", "<leader>gbc", "<cmd>Telescope git_bcommits <cr>", opts)

keymap("n", "<leader>fg", ":Flog ", opts)
keymap("n", "<leader>fb", ":Floggit ", opts)
keymap("n", "<leader>fs", ":Flogsplit ", opts)

-- keymap("n", "<leader>ff", ":FZF<cr>", opts)

keymap('n', '<leader>q', ':Bdelete<cr>', opts)

keymap('n', '<leader>o', ':SymbolsOutline<cr>', opts)

keymap('n', '<leader>nb', ':enew<cr>', opts)

keymap('n', '<C-d>', '15j', opts)
keymap('n', '<C-u>', '15k', opts)

vim.keymap.set('n', '<leader>/', function() require("Comment.api").toggle.linewise.current() end, opts)
keymap('v', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

vim.keymap.set('n', '<leader>bb', function() require('reach').buffers(options_buff) end, {})
vim.keymap.set('n', '<leader>m', function() require('reach').marks(options_marks) end, {})
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
keymap("n", "<leader>gcb", ":Gitsigns change_base ",  opts)
keymap("n", "<leader>gid", ":Gitsigns diffthis ",  opts)

-- STAGE THIS
-- map({ "n", "<F4>", ":lua require('dapui').toggle()<CR>" })
-- map({ "n", "<F5>", ":lua require('dap').toggle_breakpoint()<CR>" })
-- map({ "n", "<F9>", ":lua require('dap').continue()<CR>" })
--
-- map({ "n", "<F1>", ":lua require('dap').step_over()<CR>" })
-- map({ "n", "<F2>", ":lua require('dap').step_into()<CR>" })
-- map({ "n", "<F3>", ":lua require('dap').step_out()<CR>" })
--
-- map({ "n", "<Leader>dsc", ":lua require('dap').continue()<CR>" })
-- map({ "n", "<Leader>dsv", ":lua require('dap').step_over()<CR>" })
-- map({ "n", "<Leader>dsi", ":lua require('dap').step_into()<CR>" })
-- map({ "n", "<Leader>dso", ":lua require('dap').step_out()<CR>" })
--
-- map({ "n", "<Leader>dhh", ":lua require('dap.ui.variables').hover()<CR>" })
-- map({ "v", "<Leader>dhv", ":lua require('dap.ui.variables').visual_hover()<CR>" })
--
-- map({ "n", "<Leader>duh", ":lua require('dap.ui.widgets').hover()<CR>" })
-- map({ "n", "<Leader>duf", ":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>" })
--
-- map({ "n", "<Leader>dro", ":lua require('dap').repl.open()<CR>" })
-- map({ "n", "<Leader>drl", ":lua require('dap').repl.run_last()<CR>" })
--
-- map({ "n", "<Leader>dbc", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" })
-- map({ "n", "<Leader>dbm", ":lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>" })
-- map({ "n", "<Leader>dbt", ":lua require('dap').toggle_breakpoint()<CR>" })
--
-- map({ "n", "<Leader>dc", ":lua require('dap.ui.variables').scopes()<CR>" })
-- map({ "n", "<Leader>di", ":lua require('dapui').toggle()<CR>" })
--
-- which_key.register({
-- 	d = {
-- 		name = "Debug",
-- 		s = {
-- 			name = "Step",
-- 			c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
-- 			v = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
-- 			i = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
-- 			o = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
-- 		},
-- 		h = {
-- 			name = "Hover",
-- 			h = { "<cmd>lua require('dap.ui.variables').hover()<CR>", "Hover" },
-- 			v = { "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", "Visual Hover" },
-- 		},
-- 		u = {
-- 			name = "UI",
-- 			h = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", "Hover" },
-- 			f = { "local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", "Float" },
-- 		},
-- 		r = {
-- 			name = "Repl",
-- 			o = { "<cmd>lua require('dap').repl.open()<CR>", "Open" },
-- 			l = { "<cmd>lua require('dap').repl.run_last()<CR>", "Run Last" },
-- 		},
-- 		b = {
-- 			name = "Breakpoints",
-- 			c = {
-- 				"<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
-- 				"Breakpoint Condition",
-- 			},
-- 			m = {
-- 				"<cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>",
-- 				"Log Point Message",
-- 			},
-- 			t = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Create" },
-- 		},
-- 		c = { "<cmd>lua require('dap').scopes()<CR>", "Scopes" },
-- 		i = { "<cmd>lua require('dap').toggle()<CR>", "Toggle" },
-- 	},
-- }, { prefix = "<leader>" })
-- JOIN BLOCKS IS SPECIFIED IN SETTINGS ITSELF <space>j in ~/.local/share/nvim/site/pack/packer/start/


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
