vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu","menuone", "noinsert" }
vim.opt.hlsearch = true
vim.opt.showmode = false
vim.opt.smartcase = true

-- nvim-ufo related
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.foldenable = true
vim.opt.foldcolumn = "1" -- '0' is not bad
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
-- nvim-ufo related

vim.o.mouse = "a"
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.writebackup = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.incsearch = true
-- vim.opt.colorcolumn = "101"
vim.opt.cursorline = true
vim.o.cursorlineopt = "both"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.shortmess:append "sI"
vim.o.signcolumn = "yes"
vim.o.timeoutlen = 400
vim.opt.wrap = false
vim.opt.linebreak = true
-- vim.opt.fillchars = "eob: "
-- vim.opt.scrolloff = 5
vim.opt.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"
vim.opt.whichwrap:append "<>[]hl"
