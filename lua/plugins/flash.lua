return 
    {
        "folke/flash.nvim",
        enabled = true,
        event = "BufReadPost",
        ---@type Flash.Config
        keys = {
            { "s", mode = "n", "<cmd>lua require('flash').jump()<CR>",       noremap = true, silent = true },
            { "s", mode = "x", "<cmd>lua require('flash').jump()<CR>",       noremap = true, silent = true },
            { "s", mode = "o", "<cmd>lua require('flash').jump()<CR>",       noremap = true, silent = true },
            { "S", mode = "n", "<cmd>lua require('flash').treesitter()<CR>", noremap = true, silent = true },
            { "S", mode = "o", "<cmd>lua require('flash').treesitter()<CR>", noremap = true, silent = true },
            -- { "S", mode = "x", "<cmd>lua require('flash').treesitter()<CR>", noremap = true ,silent=true},
            { "r", mode = "o", "<cmd>lua require('flash').remote()<CR>",     noremap = true, silent = true },
        },
        opts = {},
    }
