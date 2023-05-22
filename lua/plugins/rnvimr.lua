vim.g.rnvimr_enable_ex = 1 -- Make Ranger to be hidden after picking a file--
vim.g.rnvimr_enable_picker = 1 -- Replace `$EDITOR` candidate with this command to open the selected file"
vim.g.rnvimr_edit_cmd = 'drop'
vim.g.rnvimr_draw_border = 0 -- Disable a border for floating window"
vim.g.rnvimr_hide_gitignore = 1 -- Hide the files included in gitignore"
vim.g.rnvimr_border_attr = {fg = 14, bg = -1} -- Change the border's color"
vim.g.rnvimr_enable_bw = 1 -- Make Neovim wipe the buffers corresponding to the files deleted by Ranger"
vim.g.rnvimr_shadow_winblend = 70 -- Add a shadow window, value is equal to 100 will disable shadow"
vim.g.rnvimr_ranger_cmd = {'ranger', '--cmd=set draw_borders both'} -- Draw border with both"

vim.g.rnvimr_layout = {
    relative = 'editor',
    width = vim.o.columns,
    height = vim.o.lines - 2,
    col = 0,
    row = 0,
    style = 'minimal'
}
