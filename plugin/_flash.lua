vim.pack.add({ "https://github.com/folke/flash.nvim" })

require("flash").setup({})

vim.keymap.set("n", "ss", function()
	require("flash").jump()
end, { noremap = true, silent = true, desc = "search a word" })

vim.keymap.set("n", "sw", function()
	require("flash").jump({
		pattern = vim.fn.expand("<cword>"),
	})
end, { silent = true, desc = "search a word under the cursor" })

vim.keymap.set("x", "ss", function()
	require("flash").jump()
end, { noremap = true, silent = true, desc = "search a word in visual mode" })

vim.keymap.set("o", "r", function()
	require("flash").jump({
		search = {
			mode = function(pattern)
				if pattern == "" then
					return ""
				end
				return ([[\<%s\w*\>]]):format(pattern), ([[\<%s]]):format(pattern)
			end,
		},
		jump = { pos = "range" },
	})
end, { noremap = true, silent = true, desc = "flash operator mode word" })

vim.keymap.set("n", "S", function()
	require("flash").treesitter()
end, { silent = true })

vim.keymap.set("o", "S", function()
	require("flash").treesitter()
end, { silent = true, noremap = false, desc = "flash treesitter operator mode" })

-- vim.keymap.set("x", "S", function()
-- 	require("flash").treesitter()
-- end, { silent = true })

vim.api.nvim_set_hl(0, "FlashLabel", { bg = "#f00078", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "FlashMatch", { bg = "#426bd8", fg = "#95a9e6" })
vim.api.nvim_set_hl(0, "FlashBackdrop", { link = "NONE" })
