vim.pack.add({
    'https://github.com/kkharji/sqlite.lua',  -- dep
    'https://github.com/gbprod/yanky.nvim'
})

require('yanky').setup({
    highlight = {
        on_put = false,
        on_yank = false,
        -- timer = 500,
    },
})

vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)", {desc = "Yank text", silent = true })
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)" , {desc = "Put yanked text after cursor", silent = true })
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", {desc = "Put yanked text before cursor", silent = true}) 
vim.keymap.set({"n", "x"} ,"<c-p>", "<Plug>(YankyPreviousEntry)", {desc = "Select previous entry through yank history", silent = true })
vim.keymap.set({"n", "x"},"<c-n>", "<Plug>(YankyNextEntry)", {desc = "Select next entry through yank history", silent = true })

vim.keymap.set('n', "<leader>yy", function()
    require("telescope").extensions.yank_history.yank_history({}) 
end, {desc = "Open Yank History", silent=true})
