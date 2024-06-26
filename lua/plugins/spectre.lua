return {
	mapping = {
		["open_in_vsplit"] = {
			map = "<c-v>",
			cmd = "<cmd>lua vim.cmd('vsplit ' .. require('spectre.actions').get_current_entry().filename)<CR>",
			desc = "open in vertical split",
		},
		["open_in_split"] = {
			map = "<c-s>",
			cmd = "<cmd>lua vim.cmd('split ' .. require('spectre.actions').get_current_entry().filename)<CR>",
			desc = "open in horizontal split",
		},
		["open_in_tab"] = {
			map = "<c-t>",
			cmd = "<cmd>lua vim.cmd('tab split ' .. require('spectre.actions').get_current_entry().filename)<CR>",
			desc = "open in new tab",
		},
	},
	-- highlight = {
	-- 	ui = "String",
	-- 	search = "CustomSpectreSearch",
	-- 	replace = "CustomSpectreReplace",
	-- },
}
