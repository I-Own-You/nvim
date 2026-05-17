vim.pack.add({'https://github.com/mrjones2014/smart-splits.nvim'})
require('smart-splits').setup({
    cursor_follows_swapped_bufs = true,
    -- at_edge = 'stop',
})

vim.keymap.set("n", "<A-S-l>", '<cmd>lua require("smart-splits").resize_right()<CR>', { silent = true })
vim.keymap.set("n", "<A-S-h>", '<cmd>lua require("smart-splits").resize_left()<CR>', { silent = true })
vim.keymap.set("n", "<A-S-j>", '<cmd>lua require("smart-splits").resize_down()<CR>', { silent = true })
vim.keymap.set("n", "<A-S-k>", '<cmd>lua require("smart-splits").resize_up()<CR>', { silent = true })

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
