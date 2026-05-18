vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })
require("nvim-autopairs").setup({
	{
		disable_filetype = { "TelescopePrompt", "spectre_panel", "vim" },
		fast_wrap = {
			map = "<M-e>",
			chars = { "{", "[", "(", '"', "'" },
			pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
			offset = 0, -- Offset from pattern match
			end_key = "$",
			keys = "qwertyuiopzxcvbnmasdfghjkl",
			check_comma = true,
			highlight = "PmenuSel",
			highlight_grey = "LineNr",
		},
	},
})
