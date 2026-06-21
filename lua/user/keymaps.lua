vim.g.mapleader = " "

-- vim.keymap.set("n", ";", ":")
-- vim.keymap.set("v", ";", ":")
-- vim.keymap.set("x", ";", ":")

vim.keymap.set("c", "<C-a>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Home>", true, true, true), "n", true)
end, { desc = "Move to beginning of line" })

vim.keymap.set("c", "<C-f>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, true, true), "n", true)
end, { desc = "Move forward one character" })
vim.keymap.set("c", "<C-;>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-f>", true, true, true), "n", true)
end, { desc = "Open command-line window (History)" })

vim.keymap.set("c", "<C-b>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left>", true, true, true), "n", true)
end, { desc = "Move backward one character" })
vim.keymap.set("c", "<M-f>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Right>", true, true, true), "n", true)
end, { desc = "Move forward one word" })
vim.keymap.set("c", "<M-b>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Left>", true, true, true), "n", true)
end, { desc = "Move backward one word" })
vim.keymap.set("c", "<C-l>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Del>", true, true, true), "n", true)
end, { desc = "Delete character under cursor" })
vim.keymap.set("c", "<C-e>", "<End>", { desc = "Move to end of line" })

-- keymap("n", "<C-Up>", ":resize +2<CR>", {silent=true, desc=''})
-- keymap("n", "<C-Down>", ":resize -2<CR>", {silent=true, desc=''})
-- keymap("n", "<C-Left>", ":vertical resize +2<CR>", {silent=true, desc=''})
-- keymap("n", "<C-Right>", ":vertical resize -2<CR>", {silent=true, desc=''})

-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<leader>mh",
-- 	":lua require('utility_functions').moveFloatingWindow(-5, 0)<CR>",
-- 	{silent = true }
-- )
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<leader>mj",
-- 	":lua require('utility_functions').moveFloatingWindow(0, 5)<CR>",
-- 	{silent = true }
-- )
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<leader>mk",
-- 	":lua require('utility_functions').moveFloatingWindow(0, -5)<CR>",
-- 	{silent = true }
-- )
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<leader>ml",
-- 	":lua require('utility_functions').moveFloatingWindow(5, 0)<CR>",
-- 	{silent = true }
-- )

vim.keymap.set("n", "q", "<Nop>", { silent = true })

-- keymap("i", "jk", "<ESC>", { silent = true })

vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

vim.keymap.set("v", "p", '"_dP', { silent = true })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true, desc = "" })
vim.keymap.set("i", "<A-j>", "<ESC>:m .+1<CR>==gi", { silent = true, desc = "" })
vim.keymap.set("i", "<A-k>", "<ESC>:m .-2<CR>==gi", { silent = true, desc = "" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "" })

vim.keymap.set("i", "<C-a>", "<C-o>A", { silent = true })
vim.keymap.set("i", "<C-i>", "<C-o>I", { silent = true })

vim.keymap.set("n", "<leader>ww", ":set invwrap<CR>", { silent = true, desc = "toggle wrap" })
vim.keymap.set("n", "!", ":!", { noremap = true })

vim.keymap.set("n", "+", "<C-a>", { silent = true })
vim.keymap.set("n", "-", "<C-x>", { silent = true })

vim.keymap.set("n", "ZR", function()
	vim.cmd(":restart")
end, {})

vim.keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { silent = true, desc = "toggle search results" })
vim.keymap.set("n", "<leader>bo", ":only<CR>", { silent = true, desc = "clear buffer windows" })
vim.keymap.set("n", "<leader>bda", ":%bdelete<CR>", { silent = true, desc = "delete all buffers" })
vim.keymap.set(
	"n",
	"<leader>bdo",
	":%bd|e#|bd#<CR>|'\"",
	{ silent = true, desc = "delete all buffers but not current" }
)
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { silent = true, desc = "remove all tabs but not current" })

vim.keymap.set("i", "<C-l>", "<Del>", { silent = true })

vim.keymap.set("n", "<C-e>", "5<C-e>", { silent = true, desc = "" })
vim.keymap.set("n", "<C-y>", "5<C-y>", { silent = true, desc = "" })
vim.keymap.set("v", "<C-e>", "5<C-e>", { silent = true, desc = "" })
vim.keymap.set("v", "<C-y>", "5<C-y>", { silent = true, desc = "" })

vim.keymap.set("n", "<leader>nb", ":enew<cr>", { silent = true, desc = "open new buffer" })
vim.keymap.set("n", "<leader>nt", ":tabnew<CR>", { silent = true, desc = "open new tab" })

vim.keymap.set("n", "[t", ":tabprevious<CR>", { silent = true, desc = "" })
vim.keymap.set("n", "]t", ":tabnext<CR>", { silent = true, desc = "" })
vim.keymap.set("n", "[T", ":tabfirst<CR>", { silent = true, desc = "" })
vim.keymap.set("n", "]T", ":tablast<CR>", { silent = true, desc = "" })

-- "%:p:h" without filename
vim.keymap.set(
	"n",
	"<Leader>xt",
	':let @+=expand("%:p")<CR>',
	{ silent = true, desc = "copy current buffers location" }
)

vim.keymap.set("n", "q", function()
	require("user.utility_functions").close_file_type_buffers()
end, { silent = true })

vim.keymap.set("n", "<C-Space>", "<C-^>", { desc = "cycle between prev/current file", silent = true })

-- this is for LSP builtin keymaps to remove them
vim.keymap.del("n", "grn")
vim.keymap.del("n", "gra")
vim.keymap.del("v", "gra")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grt")
vim.keymap.del("n", "gO")
vim.keymap.del("i", "<C-s>")

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(args)
-- 		local buf = args.buf
-- 		local ok, err = pcall(function()
-- 			vim.keymap.del("n", "K", { buffer = buf })
-- 		end)
-- 	end,
-- })
