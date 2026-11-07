if true then
	vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
	require("gitsigns").setup({
		debug_mode = true,
		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
		linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 100,
			ignore_whitespace = false,
		},
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- Use default
		max_file_length = 40000,
		preview_config = {
			-- Options passed to nvim_open_win
			border = "single",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
	})

	-- vim.keymap.set("n", "<leader>bl", "<cmd>Gitsigns blame_line<cr>", {desc = "blame line", silent = true })
	vim.keymap.set("n", "]c", "<cmd>Gitsigns next_hunk<cr>", { desc = "next git change", silent = true })
	vim.keymap.set("n", "[c", "<cmd>Gitsigns prev_hunk<cr>", { desc = "previous git change", silent = true })
	vim.keymap.set(
		"n",
		"<leader>ph",
		"<c/home/mkc/.config/nvim/lua/user/keymaps.luamd>Gitsigns preview_hunk<cr>",
		{ desc = "preview float window change", silent = true }
	)
	vim.keymap.set(
		"n",
		"<leader>pih",
		"<cmd>Gitsigns preview_hunk_inline<cr>",
		{ desc = "preview inline change", silent = true }
	)
	vim.keymap.set("n", "<leader>sh", "<cmd>Gitsigns stage_hunk<cr>", { desc = "stage inline change", silent = true })
	vim.keymap.set("v", "<leader>sh", "<cmd>Gitsigns stage_hunk<cr>", { desc = "stage inline change", silent = true })
	vim.keymap.set("n", "<leader>sb", "<cmd>Gitsigns stage_buffer<cr>", { desc = "stage buffer", silent = true })
	vim.keymap.set(
		"n",
		"<leader>ush",
		"<cmd>Gitsigns undo_stage_hunk<cr>",
		{ desc = "unstage inline change", silent = true }
	)
	vim.keymap.set(
		"v",
		"<leader>ush",
		"<cmd>Gitsigns undo_stage_hunk<cr>",
		{ desc = "unstage inline change", silent = true }
	)
	vim.keymap.set(
		"n",
		"<leader>rbb",
		"<cmd>Gitsigns reset_buffer<cr>",
		{ desc = "redo git buffer changes", silent = true }
	)
	vim.keymap.set("n", "<leader>rbi", "<cmd>Gitsigns reset_buffer_index<cr>", { desc = "unstage buffer", silent = true })
	vim.keymap.set("n", "<leader>rh", "<cmd>Gitsigns reset_hunk<cr>", { desc = "redo git inline change", silent = true })
	vim.keymap.set("n", "<leader>gsw", "<cmd>Gitsigns show ", { desc = "git show", silent = true })
	vim.keymap.set("n", "<leader>gid", "<cmd>Gitsigns diffthis ", { desc = "git diff", silent = true })
end
