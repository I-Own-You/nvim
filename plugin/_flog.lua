vim.pack.add({
	"https://github.com/tpope/vim-fugitive", -- dep
	"https://github.com/rbong/vim-flog",
})
vim.keymap.set("n", "<leader>fgg", ":Flog ", { desc = "open floggit" })
vim.keymap.set("n", "<leader>fs", ":Flogsplit ", { desc = "flog split" })
