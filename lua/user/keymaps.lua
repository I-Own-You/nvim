vim.g.mapleader = " "

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

-- vim.keymap.set("n", "<A-S-k>", "<cmd>resize +2<CR>", {silent=true, desc=''})
-- vim.keymap.set("n", "<A-S-j>", "<cmd>resize -2<CR>", {silent=true, desc=''})
-- vim.keymap.set("n", "<A-S-h>", "<cmd>vertical resize +2<CR>", {silent=true, desc=''})
-- vim.keymap.set("n", "<A-S-l>", "<cmd>vertical resize -2<CR>", {silent=true, desc=''})

vim.keymap.set("n", "q", "<Nop>", { silent = true })

-- keymap("i", "jk", "<ESC>", { silent = true })

vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

vim.keymap.set("v", "p", '"_dP', { silent = true })

vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<CR>==", { desc = "Move line down", silent = true })
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<CR>==", { desc = "Move line up", silent = true })
vim.keymap.set("i", "<A-j>", "<C-o><cmd>m .+1<CR><C-o>==", { desc = "Move line down", silent = true })
vim.keymap.set("i", "<A-k>", "<C-o><cmd>m .-2<CR><C-o>==", { desc = "Move line up", silent = true })
vim.keymap.set("v", "<A-k>", "<cmd><C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<CR>gv=gv", { desc = "Move selection up", silent = true })
vim.keymap.set("v", "<A-j>", "<cmd><C-u>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv", { desc = "Move selection down", silent = true })

vim.keymap.set("n", "<leader>ww", "<cmd>set invwrap<CR>", { silent = true, desc = "toggle wrap" })

vim.keymap.set("n", "<leader>bo", "<cmd>only<CR>", { silent = true, desc = "clear buffer windows" })
vim.keymap.set("n", "<leader>bda", "<cmd>%bdelete<CR>", { silent = true, desc = "delete all buffers" })
vim.keymap.set(
	"n",
	"<leader>bdo",
	":%bd|e#|bd#<CR>|'\"",
	{ silent = true, desc = "delete all buffers but not current" }
)
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<CR>", { silent = true, desc = "remove all tabs but not current" })

-- c-w del left word (builtin)
-- c-u del all left  (builtin)
-- c-h del left char (builtin)
-- c-l del right char
-- c-k del right word 
-- c-; del everything to right
vim.keymap.set("i", "<C-l>", "<Del>", { silent = true })
vim.keymap.set("i", "<C-k>", "<C-o>dw", { silent = true })
vim.keymap.set("i", "<C-;>", "<C-o>D", { silent = true })
vim.keymap.set("i", "<C-a>", "<C-o>I", { silent = true })
vim.keymap.set("i", "<C-e>", "<C-o>g_<Right>", { silent = true })
vim.keymap.set("i", "<A-b>", "<C-Left>", { silent = true })
vim.keymap.set("i", "<A-f>", "<C-Right>", { silent = true })
vim.keymap.set("i", "<C-b>", "<Left>", { silent = true })
vim.keymap.set("i", "<C-f>", "<Right>", { silent = true })
vim.keymap.set("i", "<C-n>", "<Down>", { silent = true })
vim.keymap.set("i", "<C-p>", "<Up>", { silent = true })

vim.keymap.set("n", "<C-e>", "5<C-e>", { silent = true, desc = "" })
vim.keymap.set("n", "<C-y>", "5<C-y>", { silent = true, desc = "" })         
vim.keymap.set("v", "<C-e>", "5<C-e>", { silent = true, desc = "" })
vim.keymap.set("v", "<C-y>", "5<C-y>", { silent = true, desc = "" })

vim.keymap.set("n", "[t", "<cmd>tabprevious<CR>", { silent = true, desc = "" })
vim.keymap.set("n", "]t", "<cmd>tabnext<CR>", { silent = true, desc = "" })
vim.keymap.set("n", "[T", "<cmd>tabfirst<CR>", { silent = true, desc = "" })
vim.keymap.set("n", "]T", "<cmd>tablast<CR>", { silent = true, desc = "" })

-- "%:p:h" without filename
vim.keymap.set(
	"n",
	"<Leader>xt",
	'<cmd>let @+=expand("%:p")<CR>',
    { silent = true, desc = "copy current buffers location" }
)

vim.keymap.set("n", "q", "<cmd>nohl<CR>", { desc = "", silent = true })

vim.keymap.set("n", "<C-Space>", "<C-^>", { desc = "cycle between prev/current file", silent = true })

-- this is for LSP builtin keymaps to remove them
vim.keymap.del("n", "grn")
vim.keymap.del("n", "gra")
vim.keymap.del("v", "gra")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grt")
vim.keymap.del("n", "grx")
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
