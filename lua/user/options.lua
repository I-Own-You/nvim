vim.o.backup = false
vim.o.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noinsert" }
vim.o.hlsearch = true
vim.o.showmode = false
vim.o.smartcase = true

-- nvim-ufo related
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.opt.foldenable = true
-- vim.opt.foldcolumn = "1" -- '0' is not bad
-- vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- vim.opt.foldlevelstart = 99
-- nvim-ufo related

vim.o.mouse = "a"
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.writebackup = false
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.incsearch = true
-- vim.o.colorcolumn = "81"
vim.o.cursorline = false
vim.o.cursorlineopt = "number"
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 2
vim.opt.shortmess:append("sI")
vim.o.signcolumn = "yes"
vim.o.timeoutlen = 400
vim.o.wrap = false
vim.o.linebreak = true
vim.o.laststatus = 3 -- https://github.com/neovim/neovim/pull/17266, customization docs
-- vim.opt.fillchars = "eob: "
-- vim.opt.scrolloff = 5
vim.o.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"
vim.opt.whichwrap:append("<>[]hl")
