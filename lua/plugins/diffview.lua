return {
	"sindrets/diffview.nvim",
	enabled = true,
	event = "BufReadPost",
	config = function()
		local actions = require("diffview.actions")
		require("diffview").setup({
			keymaps = {
				view = {
					{ "n", "<A-n>", "]c", { desc = "Next hunk / entry" } },
					{ "n", "<A-p>", "[c", { desc = "Prev hunk / entry" } },
				},
			},
		})
	end,
	keys = {
		{ "<leader>mt", mode = "n", ":DiffviewOpen ", desc = "open diff view", silent = true },
		{
			"<leader>mf",
			mode = "n",
			":DiffviewFileHistory ",
			desc = "open diff view for single file",
			silent = true,
		},
		{ "<leader>mk", mode = "n", ":DiffviewClose<CR>", desc = "close diff view", silent = true },
	},
}
