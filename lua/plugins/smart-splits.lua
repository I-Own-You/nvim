local options = {
	cursor_follows_swapped_bufs = true,
	-- at_edge = 'stop',
}

return {
    
        "mrjones2014/smart-splits.nvim",
        enabled = true,
        build = "./kitty/install-kittens.bash",
        opts = options,
        keys = {
            -- move between buffers
            -- commented because i dont need the cycle option, so it has a delay anyway, so its slower than neovim builtin
            -- { "<C-h>", '<cmd>lua require("smart-splits").move_cursor_left()<CR>' },
            -- { "<C-j>", '<cmd>lua require("smart-splits").move_cursor_down()<CR>' },
            -- { "<C-k>", '<cmd>lua require("smart-splits").move_cursor_up()<CR>' },
            -- { "<C-l>", '<cmd>lua require("smart-splits").move_cursor_right()<CR>' },
            -- resize buffers
            -- { "<C-Left>", '<cmd>lua require("smart-splits").resize_left()<CR>' },
            -- { "<C-Down>", '<cmd>lua require("smart-splits").resize_down()<CR>' },
            -- { "<C-Up>", '<cmd>lua require("smart-splits").resize_up()<CR>' },
            -- { "<C-Right>", '<cmd>lua require("smart-splits").resize_right()<CR>' },
            { "<A-S-h>",    '<cmd>lua require("smart-splits").resize_left()<CR>' },
            { "<A-S-l>",    '<cmd>lua require("smart-splits").resize_right()<CR>' },
            { "<A-S-j>",    '<cmd>lua require("smart-splits").resize_down()<CR>' },
            { "<A-S-k>",    '<cmd>lua require("smart-splits").resize_up()<CR>' },
            -- swapping buffers
            { "<C-Space>h", '<cmd>lua require("smart-splits").swap_buf_left()<CR>' },
            { "<C-Space>j", '<cmd>lua require("smart-splits").swap_buf_down()<CR>' },
            { "<C-Space>k", '<cmd>lua require("smart-splits").swap_buf_up()<CR>' },
            { "<C-Space>l", '<cmd>lua require("smart-splits").swap_buf_right()<CR>' },
    },
}
