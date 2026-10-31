vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "r", "o" })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "markdown",
        "help",
        "qf",
        "vim",
        "http",
        "bufferlist",
        "netrw",
        "notify",
        "fugitiveblame",
        "git",
    },
    callback = function(event)
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end
})
