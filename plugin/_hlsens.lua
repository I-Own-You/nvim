vim.pack.add({ "https://github.com/kevinhwang91/nvim-hlslens" })
require("hlslens").setup()

vim.keymap.set(
	"n",
	"n",
	"<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zz",
	{ silent = true }
)
vim.keymap.set(
	"n",
	"N",
	"<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zz",
	{ silent = true }
)
vim.keymap.set("n", "*", "*<Cmd>lua require('hlslens').start()<CR>zz", { silent = true })
vim.keymap.set("n", "#", "#<Cmd>lua require('hlslens').start()<CR>zz", { silent = true })
vim.keymap.set(
	"n",
	"g*",
	"g*<Cmd>lua require('hlslens').start()<CR>zz",
	{ desc = "search forward word", silent = true }
)
vim.keymap.set(
	"n",
	"g#",
	"g#<Cmd>lua require('hlslens').start()<CR>zz",
	{ desc = "search backgward word", silent = true }
)
