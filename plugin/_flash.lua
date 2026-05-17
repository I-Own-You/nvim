vim.pack.add({'https://github.com/folke/flash.nvim'})

vim.keymap.set("n",  "s", function() require('flash').jump() end, {noremap = true, silent = true })
vim.keymap.set("x",  "s", function() require('flash').jump() end, {noremap = true, silent = true })
vim.keymap.set("o",  "s", function() require('flash').jump() end, {noremap = true, silent = true })
vim.keymap.set("o",  "r", function() require('flash').remote() end, {noremap = true, silent = true })
