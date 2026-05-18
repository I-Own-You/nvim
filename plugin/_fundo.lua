vim.pack.add({
	"https://github.com/kevinhwang91/promise-async", -- dep
	"https://github.com/kevinhwang91/nvim-fundo",
})

vim.o.undofile = true

require("fundo").install()

require("fundo").setup({
	limit_archives_size = 64, --defualt was 512
})
