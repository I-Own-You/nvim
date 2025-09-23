if vim.g.neovide then
	vim.o.guifont = "CommitMono:h16"
	vim.opt.linespace = 3

	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_padding_left = 0

	vim.g.neovide_cursor_smooth_blink = true
end

-- vim.keymap.set("n", "<C-S-v>", '"+p', { noremap = true, silent = true })
-- vim.keymap.set("i", "<C-S-v>", "<C-R>+", { noremap = true, silent = true })
-- vim.keymap.set("v", "<C-S-v>", '"+p', { noremap = true, silent = true })
