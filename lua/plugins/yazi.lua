return 
    {
        "mikavilpas/yazi.nvim",
        enabled = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "VeryLazy",
        keys = {
            {
                "<leader>e",
                function()
                    require("yazi").yazi()
                end,
                desc = "Open the file manager",
            },
        },
    }
