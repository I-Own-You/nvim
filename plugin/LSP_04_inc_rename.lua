vim.pack.add({
	"https://github.com/smjonas/inc-rename.nvim",
})
require("inc_rename").setup()

-- vim.keymap.set("n", "<leader>re", ":IncRename ")

vim.keymap.set("n", "<leader>re", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })
