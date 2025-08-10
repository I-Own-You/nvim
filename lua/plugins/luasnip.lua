return {
	"L3MON4D3/LuaSnip",
	enabled = true,
	event = "InsertEnter",
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		local luasnip = require("luasnip")
		-- luasnip.filetype_extend("htmldjango", { "html" })
		luasnip.filetype_extend("typescriptreact", { "html" })
		luasnip.filetype_extend("javascriptreact", { "html" })
		-- require("luasnip/loaders/from_vscode").lazy_load({ paths = "~/.config/nvim/snippets/" })
		require("luasnip/loaders/from_vscode").lazy_load()
		-- enable it if you will define lua snippets
		-- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
	end,
	build = "make install_jsregexp",
}
