local options = {
	backup = false,
	clipboard = "unnamedplus",
	completeopt = { "menuone", "noselect" },
	hlsearch = true,
	pumheight = 10,
	showmode = false,
	showtabline = 1,
	smartcase = true,
	-- foldmethod = "indent", -- ufo nvim works instead
	foldlevelstart = 99,
	smartindent = true,
	ignorecase = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	termguicolors = true,
	undofile = true,
	updatetime = 300,
	writebackup = false,
	expandtab = true,
	shiftwidth = 4,
	tabstop = 4,
	softtabstop = 4,
	incsearch = true,
	-- colorcolumn = "101",
	cursorline = true,
	number = true,
	relativenumber = true,
	numberwidth = 4,
	wrap = false,
	linebreak = true,
	fillchars = "eob: ",
	-- scrolloff = 5,
	sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize",
}
for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.api.nvim_command("set whichwrap+=<,>,h,l,[,]")
