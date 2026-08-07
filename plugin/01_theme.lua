vim.pack.add({ "https://github.com/srcery-colors/srcery-vim" })
vim.cmd.colorscheme("srcery")

vim.api.nvim_set_hl(0, "Visual", { bg = "#282828", force = true })
vim.api.nvim_set_hl(0, "Visual", { bg = "#2e251e", force = true })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#111111", force = true })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#2e251e", force = true })
--
vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
-- vim.api.nvim_set_hl(0, "FzfLuaBorder", { link = "FloatBorder" }) -- its linked to TelescopeBorder
