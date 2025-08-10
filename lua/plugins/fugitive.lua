return 
    {
        "tpope/vim-fugitive",
        enabled = true,
        event = "CmdlineEnter",
        keys = {
            { "<leader>gg", mode = "n", ":Git ",          desc = "open git",  noremap = true, silent = true },
            {

                "<leader>gc",
                mode = "n",
                ":Git commit<CR>",
                desc = "git commit",
                noremap = true,
                silent = true,
            },
            { "<leader>gp", mode = "n", ":Git push<CR>",  desc = "git push",  silent = true },
            { "<leader>bl", mode = "n", ":Git blame<CR>", desc = "git blame", noremap = true, silent = true },
        },
    }
