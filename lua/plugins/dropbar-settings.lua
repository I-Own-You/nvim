return {
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
