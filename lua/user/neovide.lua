if vim.g.neovide then
	vim.o.guifont = "CommitMono Nerd Font Mono:h15"
	vim.opt.linespace = 0

	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_padding_left = 0

	vim.g.neovide_cursor_smooth_blink = true

	vim.keymap.set("t", "<C-S-V>", "<C-\\><C-n>pi")
    vim.keymap.set("n", "<C-S-v>", '"+p', { noremap = true, silent = true })
    vim.keymap.set("i", "<C-S-v>", "<C-R>+", { noremap = true, silent = true })
    vim.keymap.set("v", "<C-S-v>", '"+p', { noremap = true, silent = true })
    vim.keymap.set("c", "<C-S-v>", function()
        vim.api.nvim_feedkeys(vim.keycode("<C-R>+"), "n", false)
        vim.cmd("redraw")
    end, { noremap = true, silent = true })

   
    local function set_cursor_hl()
        local cursorColor = "#83bfd4"
        vim.api.nvim_set_hl(0, "Cursor", {  bg = cursorColor })
        vim.api.nvim_set_hl(0, "CursorIM", {  bg = cursorColor })
        vim.api.nvim_set_hl(0, "lCursor", {  bg = cursorColor })
        vim.api.nvim_set_hl(0, "TermCursor", {  bg = cursorColor })
        vim.api.nvim_set_hl(0, "FzfLuaCursor", {  bg = cursorColor })

    end

    vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("CustomCursorHl", { clear = true }),
        callback = set_cursor_hl,
    })

end


