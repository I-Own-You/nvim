local options = {
	menu = {
		keymaps = {
			["h"] = "<C-w>q",
			["l"] = function()
				local dropbar_api = require("dropbar.utils")
				local menu = dropbar_api.menu.get_current()
				if not menu then
					return
				end
				local cursor = vim.api.nvim_win_get_cursor(menu.win)
				local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
				if component then
					menu:click_on(component, nil, 1, "l")
				end
			end,
		},
		preview = true,
		scrollbar = {
			enable = false,
		},
		win_configs = {
			border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
		},
	},
}

return {
	"Bekaboo/dropbar.nvim",
	enalbed = true,
	event = "BufReadPost",
	dependencies = {
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	config = function()
		local dropbar_api = require("dropbar.api")
		vim.keymap.set("n", "<leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
		vim.keymap.set("n", "<leader>hh", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
		vim.keymap.set("n", "<leader>kk", dropbar_api.select_next_context, { desc = "Select next context" })
		require("dropbar").setup(options)
	end,
}
