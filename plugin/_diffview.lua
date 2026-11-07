if true then
	vim.pack.add({ "https://github.com/sindrets/diffview.nvim" })
	-- local actions = require("diffview.actions")
	require("diffview").setup()
	vim.keymap.set("n", "<leader>mt", "<cmd>DiffviewOpen ", { desc = "open diff view" })
	vim.keymap.set("n", "<leader>mf", "<cmd>DiffviewFileHistory ", { desc = "open diff view for single file" })
	vim.keymap.set("n", "<leader>mk", "<cmd>DiffviewClose<CR>", { desc = "close diff view", silent = true })
end
