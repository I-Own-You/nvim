-- vim.pack.add({ "https://github.com/NvChad/nvim-colorizer.lua" })
return {} or require("colorizer").setup({
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
			hsl = true,
			oklch = true,
			hwb = true,
			lab = true,
			lch = true,
			css_color = true,
			names = true,
			css = true,
			css_fn = true,
			hex = true,
			tailwind = { enable = false },
			sass = { enable = false, parsers = { "css" } },
			xterm = { enable = false }, -- xterm 256-color codes (#xNN, \e[38;5;NNNm)
			xcolor = true,
			hsluv = true,
			css_var_rgb = true,
			css_var = {
				enable = true, -- resolve var(--name) references to their defined color
				parsers = { css = true }, -- parsers for resolving variable values
			},
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
