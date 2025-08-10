local opts = {
	matchup = {
		enable = true, -- mandatory, false will disable the whole extension
		enable_quotes = true,
		disable_virtual_text = true, -- at the ending of functioin
		-- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
		-- [options]
	},
	ensure_installed = {
		"python",
		"javascript",
		"typescript",
		"lua",
		"json",
		"jsonc",
		"html",
		"xml",
		"toml",
		"graphql",
		"http",
		"htmldjango",
		"rasi",
		"css",
		"prisma",
		"tsx",
		"vim",
		"regex",
		"go",
		"gosum",
		"gotmpl",
		"gomod",
		"gowork",
		"markdown",
		"markdown_inline",
		"sql",
		"bash",
	},
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		additional_vim_regex_highlighting = false,
		disable = { "" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	indent = {
		enable = true,
		disable = { "python" },
	},
	autotag = {
		enable = true,
		enable_rename = true,
		enable_close = true,
		enable_close_on_slash = true,
	},
}

return {
    
        "nvim-treesitter/nvim-treesitter",
        enabled = true,
        build = ":TSUpdate",
        event = "BufReadPost",
        config = function()
            require("nvim-treesitter.configs").setup(opts)
        end,
}
