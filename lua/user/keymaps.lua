local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = " "

keymap("n", ";", ":", { noremap = true })
keymap("v", ";", ":", { noremap = true })
keymap("x", ";", ":", { noremap = true })

-- keymap("n", "<C-Up>", ":resize +2<CR>", {silent=true, desc=''})
-- keymap("n", "<C-Down>", ":resize -2<CR>", {silent=true, desc=''})
-- keymap("n", "<C-Left>", ":vertical resize +2<CR>", {silent=true, desc=''})
-- keymap("n", "<C-Right>", ":vertical resize -2<CR>", {silent=true, desc=''})

-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<leader>mh",
-- 	":lua require('utility_functions').moveFloatingWindow(-5, 0)<CR>",
-- 	{ noremap = true, silent = true }
-- )
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<leader>mj",
-- 	":lua require('utility_functions').moveFloatingWindow(0, 5)<CR>",
-- 	{ noremap = true, silent = true }
-- )
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<leader>mk",
-- 	":lua require('utility_functions').moveFloatingWindow(0, -5)<CR>",
-- 	{ noremap = true, silent = true }
-- )
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<leader>ml",
-- 	":lua require('utility_functions').moveFloatingWindow(5, 0)<CR>",
-- 	{ noremap = true, silent = true }
-- )

-- keymap("t", "<C-h>", "<C-\\><C-n>:wincmd h<CR>", { silent = true })
-- keymap("t", "<C-j>", "<C-\\><C-n>:wincmd j<CR>", { silent = true })
-- keymap("t", "<C-k>", "<C-\\><C-n>:wincmd k<CR>", { silent = true })
-- keymap("t", "<C-l>", "<C-\\><C-n>:wincmd l<CR>", { silent = true })

keymap("n", "q", "<Nop>", { silent = true })

-- keymap("n", "<TAB>", ":tabnext<CR>", { silent = true })
-- keymap("n", "<S-TAB>", ":tabNext<CR>", { silent = true })

-- keymap("i", "jk", "<ESC>", { silent = true })

keymap("v", "<", "<gv", { silent = true })
keymap("v", ">", ">gv", { silent = true })

keymap("v", "p", '"_dP', { silent = true })

keymap("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "" })
keymap("n", "<A-k>", ":m .-2<CR>==", { silent = true, desc = "" })
keymap("i", "<A-j>", "<ESC>:m .+1<CR>==gi", { silent = true, desc = "" })
keymap("i", "<A-k>", "<ESC>:m .-2<CR>==gi", { silent = true, desc = "" })
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "" })

keymap("i", "<C-a>", "<C-o>A", { noremap = true, silent = true })
keymap("i", "<C-i>", "<C-o>I", { noremap = true, silent = true })

keymap("n", "<leader>ww", ":set invwrap<CR>", { silent = true, desc = "toggle wrap" })
keymap("n", "!", ":!", { noremap = true })

keymap("n", "+", "<C-a>", { noremap = true, silent = true })
keymap("n", "-", "<C-x>", { noremap = true, silent = true })

keymap("i", "<C-BACKSPACE>", "<ESC>vbdi", { silent = true, desc = "" })

keymap("n", "<leader>nh", ":nohlsearch<CR>", { silent = true, desc = "toggle search results" })
keymap("n", "<leader>bo", ":only<CR>", { silent = true, desc = "clear buffer windows" })
keymap("n", "<leader>bda", ":%bdelete<CR>", { silent = true, desc = "delete all buffers" })
keymap(
	"n",
	"<leader>bdo",
	":%bd|e#|bd#<CR>|'\"",
	{ noremap = true, silent = true, desc = "delete all buffers but not current" }
)
keymap("n", "<leader>to", ":tabonly<CR>", { noremap = true, silent = true, desc = "remove all tabs but not current" })

-- keymap("n", "gd", ':lua require("utility_functions").goto_defintion()<CR>', { silent = true, desc = "lsp definition" })
-- keymap(
-- 	"n",
-- 	"gD",
-- 	':lua require("utility_functions").goto_declaration()<CR>',
-- 	{ silent = true, desc = "lsp declaration" }
-- )
-- keymap(
-- 	"n",
-- 	"gi",
-- 	':lua require("utility_functions").goto_implementation()<CR>',
-- 	{ silent = true, desc = "lsp implementation" }
-- )
-- keymap(
-- 	"n",
-- 	"<leader>D",
-- 	':lua require("utility_functions").goto_type_definition()<CR>',
-- 	{ silent = true, desc = "lsp type definition" }
-- )

-- keymap("n", "<C-d>", "5j", { silent = true, desc = "" })
-- keymap("n", "<C-u>", "5k", { silent = true, desc = "" })
-- keymap("v", "<C-d>", "5j", { silent = true, desc = "" })
-- keymap("v", "<C-u>", "5k", { silent = true, desc = "" })

keymap("n", "<C-e>", "5<C-e>", { silent = true, desc = "", noremap = true })
keymap("n", "<C-y>", "5<C-y>", { silent = true, desc = "", noremap = true })
keymap("v", "<C-e>", "5<C-e>", { silent = true, desc = "", noremap = true })
keymap("v", "<C-y>", "5<C-y>", { silent = true, desc = "", noremap = true })

-- keymap("n", "<C-d>", "5<C-d>", { silent = true, desc = "", noremap = true })
-- keymap("n", "<C-u>", "5<C-u>", { silent = true, desc = "", noremap = true })
-- keymap("v", "<C-d>", "5<C-d>", { silent = true, desc = "", noremap = true })
-- keymap("v", "<C-u>", "5<C-u>", { silent = true, desc = "", noremap = true })

keymap("n", "<C-c>", ":%y<CR>", { silent = true })
keymap("n", "<C-a>", "ggVG", { silent = true })
keymap("n", "<C-x>", ":%d<CR>", { silent = true })

keymap("n", "<leader>nb", ":enew<cr>", { silent = true, desc = "open new buffer" })
keymap("n", "<leader>nt", ":tabnew<CR>", { silent = true, desc = "open new tab" })

-- "%:p:h" without filename
keymap("n", "<Leader>xt", ':let @+=expand("%:p")<CR>', { silent = true, desc = "copy current buffers location" })

keymap("n", "q", ":lua require('utility_functions').close_file_type_buffers()<CR>", { silent = true })

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
