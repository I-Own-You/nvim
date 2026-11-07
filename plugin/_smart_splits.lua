if true then
	vim.pack.add({ "https://github.com/mrjones2014/smart-splits.nvim" })
	require("smart-splits").setup({
		swap = {
			move_cursor = {
				cursor_follows_swapped_bufs = true,
			},
		},
		-- at_edge = 'stop',
	})

	vim.keymap.set("n", "<A-S-l>", function()
		require("smart-splits").resize_right()
	end, { silent = true })
	vim.keymap.set("n", "<A-S-h>", function()
		require("smart-splits").resize_left()
	end, { silent = true })
	vim.keymap.set("n", "<A-S-j>", function()
		require("smart-splits").resize_down()
	end, { silent = true })
	vim.keymap.set("n", "<A-S-k>", function()
		require("smart-splits").resize_up()
	end, { silent = true })
end
