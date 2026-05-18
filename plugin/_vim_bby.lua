vim.pack.add({ "https://github.com/moll/vim-bbye" })
vim.keymap.set("n", "<leader>q", ":Bdelete!<cr>", { silent = true, desc = "delete buffer" })
