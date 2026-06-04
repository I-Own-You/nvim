vim.pack.add({ "https://github.com/romus204/tree-sitter-manager.nvim" })

require("tree-sitter-manager").setup({
	ensure_installed = { "lua", "c", "cpp", "toml", "kdl", "python", "html", "css", "javascript", "typescript"  }, -- list of parsers to install at the start of a neovim session
	-- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
	auto_install = false, -- if enabled, install missing parsers when editing a new file
	highlight = true,
	-- highlight = {"lua", "c"}, -- an example
})
