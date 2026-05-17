vim.pack.add({
	"https://github.com/romus204/tree-sitter-manager.nvim",
	"https://github.com/wansmer/treesj",
})

vim.keymap.set("n", "<leader>jj", function()
	require("treesj").toggle()
end, { desc = "toggle split nodes", silent = true })
