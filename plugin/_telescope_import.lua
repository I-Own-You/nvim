vim.pack.add({
    'https://github.com/nvim-telescope/telescope.nvim',  -- dep
    'https://github.com/piersolenski/telescope-import.nvim'
})

require("telescope").load_extension("import")

vim.keymap.set('n', "<leader>ii", "<cmd>Telescope import<CR>", {desc = "open imports", silent = true })
