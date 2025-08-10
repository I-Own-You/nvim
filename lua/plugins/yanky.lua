local opts= {
	highlight = {
		on_put = false,
		on_yank = false,
		-- timer = 500,
	},
}

return 
    {
        "gbprod/yanky.nvim",
        enabled = true,
        dependencies = {
            { "kkharji/sqlite.lua" },
        },
        opts = opts,
        keys = {
            {
                "<leader>yy",
                function()
                    require("telescope").extensions.yank_history.yank_history({})
                end,
                desc = "Open Yank History",
                silent = true,
            },
            { "y", "<Plug>(YankyYank)",     mode = { "n", "x" }, desc = "Yank text",                    silent = true },
            { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor", silent = true },
            {
                "P",
                "<Plug>(YankyPutBefore)",
                mode = { "n", "x" },
                desc = "Put yanked text before cursor",
                silent = true,
            },
            {
                "<c-p>",
                mode = { "n", "x" },
                "<Plug>(YankyPreviousEntry)",
                desc = "Select previous entry through yank history",
                silent = true,
            },
            {
                "<c-n>",
                mode = { "n", "x" },
                "<Plug>(YankyNextEntry)",
                desc = "Select next entry through yank history",
                silent = true,
            },
        },
    }
