vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim", -- dep
	"https://github.com/mikavilpas/yazi.nvim",
})

require("yazi").setup({
	floating_window_scaling_factor = 0.8,
})

vim.keymap.set("n", "<leader>e", function()
	require("yazi").yazi()
end, { desc = "Open the file manager", silent = true })
