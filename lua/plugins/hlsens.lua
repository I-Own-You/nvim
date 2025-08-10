return 
    {
        "kevinhwang91/nvim-hlslens",
        enabled = true,
        event = "BufReadPost",
        config = function()
            require("hlslens").setup()
        end,
        keys = {
            {
                "n",
                "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zz",
                mode = "n",
                noremap = true,
                silent = true,
            },
            {
                "N",
                "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zz",
                mode = "n",
                noremap = true,
                silent = true,
            },
            { mode = "n", "*", "*<Cmd>lua require('hlslens').start()<CR>zz", noremap = true, silent = true },
            { mode = "n", "#", "#<Cmd>lua require('hlslens').start()<CR>zz", noremap = true, silent = true },
            {
                mode = "n",
                "g*",
                "g*<Cmd>lua require('hlslens').start()<CR>zz",
                desc = "search forward word",
                noremap = true,
                silent = true,
            },
            {
                mode = "n",
                "g#",
                "g#<Cmd>lua require('hlslens').start()<CR>zz",
                desc = "search backgward word",
                noremap = true,
                silent = true,
            },
        },
    }
