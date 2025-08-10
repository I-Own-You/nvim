local options =  {
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
}

return    {
        "lewis6991/gitsigns.nvim",
        enabled = true,
        event = "BufReadPost",
        keys = {
            {
                mode = "n",
                "<A-n>",
                ":Gitsigns next_hunk<cr>",
                desc = "next git change",
                silent = true,
            },
            {
                mode = "n",
                "<A-p>",
                ":Gitsigns prev_hunk<cr>",
                desc = "previous git change",
                silent = true,
            },
            -- { mode = "n", "<leader>bl", ":Gitsigns blame_line<cr>", desc = "blame line", silent = true },
            {
                mode = "n",
                "<leader>ph",
                ":Gitsigns preview_hunk<cr>",
                desc = "preview float window change",
                silent = true,
            },
            {
                mode = "n",
                "<leader>pih",
                ":Gitsigns preview_hunk_inline<cr>",
                desc = "preview inline change",
                silent = true,
            },
            {
                mode = "n",
                "<leader>sh",
                ":Gitsigns stage_hunk<cr>",
                desc = "stage inline change",
                silent = true,
            },
            { mode = "n", "<leader>sb", ":Gitsigns stage_buffer<cr>", desc = "stage buffer", silent = true },
            {
                mode = "n",
                "<leader>ush",
                ":Gitsigns undo_stage_hunk<cr>",
                desc = "unstage inline change",
                silent = true,
            },
            {
                mode = "n",
                "<leader>rbb",
                ":Gitsigns reset_buffer<cr>",
                desc = "redo git buffer changes",
                silent = true,
            },
            {
                mode = "n",
                "<leader>rbi",
                ":Gitsigns reset_buffer_index<cr>",
                desc = "unstage buffer",
                silent = true,
            },
            {
                mode = "n",
                "<leader>rh",
                ":Gitsigns reset_hunk<cr>",
                desc = "redo git inline change",
                silent = true,
            },
            {
                mode = "n",
                "<leader>gsw",
                ":Gitsigns show ",
                desc = "git show",
                noremap = true,
                silent = true,
            },
            {
                mode = "n",
                "<leader>gid",
                ":Gitsigns diffthis ",
                desc = "git diff",
                noremap = true,
                silent = true,
            },
        },
        config = function()
            require("gitsigns").setup(options)
        end,
    }
