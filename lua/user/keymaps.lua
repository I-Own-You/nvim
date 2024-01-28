local opts = { silent = true }
local kopts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = " "

keymap("n", ";", ":", { noremap = true })
keymap("v", ";", ":", { noremap = true })
keymap("x", ";", ":", { noremap = true })

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- keymap("n", "<C-Up>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

keymap("n", "<leader>ot", ":tab split | terminal<CR>", opts)
keymap("t", "<leader>tc", "<C-\\><C-n>", opts)

keymap("n", "q", "<Nop>", opts)

keymap("n", "<TAB>", ":tabnext<CR>", opts)
keymap("n", "<S-TAB>", ":tabprevious<CR>", opts)

keymap("i", "jk", "<ESC>", opts)

keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("v", "p", '"_dP', opts)

-- keymap("n", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("n", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("i", "<A-j>", "<ESC>:m .+1<CR>==gi", opts)
-- keymap("i", "<A-k>", "<ESC>:m .-2<CR>==gi", opts)
-- keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
-- keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

keymap("n", "<leader>vv", ":vsplit<CR>", opts)
keymap("n", "<leader>hh", ":split<CR>", opts)
keymap("n", "<leader>vd", ":vert diffsplit ", { noremap = true })

keymap("n", "<C-[>", "[m", opts)
keymap("n", "<C-]>", "]m", opts)

keymap("n", "<leader>ww", ":set invwrap<CR>:set wrap?<CR>", opts)
keymap("n", "!", ":!", { noremap = true })

keymap("n", "+", "<C-a>", kopts)
keymap("n", "-", "<C-x>", kopts)
keymap("v", "+", "<C-a>gv=gv", kopts)
keymap("v", "-", "<C-x>gv=gv", kopts)
keymap("x", "+", "<C-a>", kopts)
keymap("x", "-", "<C-x>", kopts)

keymap("n", "<C-c>", ":%y<CR>", opts)
keymap("n", "<C-a>", "ggVG", opts)
keymap("n", "<C-x>", ":%d<CR>", opts)

vim.keymap.set("n", "<leader>kk", function()
	local ok, start = require("indent_blankline.utils").get_current_context(
		vim.g.indent_blankline_context_patterns,
		vim.g.indent_blankline_use_treesitter_scope
	)

	if ok then
		vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
		vim.cmd([[normal! _]])
	end
end, opts)


keymap("n", "<leader>nh", ":nohlsearch<CR>", opts)
keymap("n", "<leader>bo", ":only<CR>", opts)
keymap("n", "<leader>bda", ":%bdelete<CR>", opts)
keymap("n", "<leader>bdo", ":%bd|e#|bd#<CR>|'\"", kopts)
keymap("n", "<leader>to", ":tabonly<CR>", kopts)

keymap("n", "<leader>la", ":Lazy<CR>", { noremap = true })

keymap("n", "gd", ':lua require("utility_functions").goto_defintion()<CR>', opts)
keymap("n", "gD", ':lua require("utility_functions").goto_declaration()<CR>', opts)
keymap("n", "gi", ':lua require("utility_functions").goto_implementation()<CR>', opts)
keymap("n", "<leader>D", ':lua require("utility_functions").goto_type_definition()<CR>', opts)


-- keymap("n", "<C-d>", "15j", opts)
-- keymap("n", "<C-u>", "15k", opts)

keymap("n", "<leader>nb", ":enew<cr>", opts)
keymap("n", "<leader>nt", ":tabnew<CR>", opts)

keymap("n", "<Leader>xt", ':let @+=expand("%:p:h")<CR>', opts)

keymap("n", "zz", "za", kopts) -- for
