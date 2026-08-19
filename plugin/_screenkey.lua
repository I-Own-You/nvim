vim.pack.add({
	{
		src = "https://github.com/nstefan002/screenkey.nvim",
		version = vim.version.range("*"),
	},
})
require("screenkey").setup({})
