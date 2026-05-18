vim.pack.add({ "https://github.com/NvChad/nvim-colorizer.lua" })
require("colorizer").setup({
	-- filetypes = {
	-- "lua",
	-- "typescript",
	-- "javascript",
	-- "typescriptreact",
	-- "javascriptreact",
	-- "css",
	-- "scss",
	-- "sass",
	-- "text",
	-- },
	options = {
		parsers = {
			rgb = true,
			names = true,
			css = true,
			css_fn = true,
			tailwind = { enable = false },
			sass = { enable = true, parsers = { "css" } },
		},
	},
	display = {
		mode = "background", -- Set the display mode.
		virtualtext = {
			char = "■",
		},
	},
	buftypes = {},
	always_update = false,
})
