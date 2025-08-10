return {
	"dnlhc/glance.nvim",
	event = "BufReadPost",
	enabled = true,
	config = function()
		local glance = require("glance")
		local actions = glance.actions
		require("glance").setup({
			hooks = {
				before_open = function(results, open, jump, _) -- _ - method
					if #results == 1 then
						jump(results[1]) -- argument is optional
					else
						open(results) -- argument is optional
					end
				end,
			},
			mappings = {
				list = {
					["<C-h>"] = actions.enter_win("preview"),
					["<C-l>"] = actions.enter_win("preview"),
				},
				preview = {
					["<C-h>"] = actions.enter_win("list"),
					["<C-l>"] = actions.enter_win("list"),
				},
			},
		})
	end,
}
