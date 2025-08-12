-- return {
-- 	"Shatur/neovim-ayu",
-- 	enabled = true,
-- 	lazy = false,
-- 	config = function()
-- 		vim.cmd("colorscheme ayu-dark")
-- 		local hl = vim.api.nvim_set_hl
-- 		-- hl(0, "Search", { fg = "#bb9af7", bg = "#8CCF7E" })
-- 		-- hl(0, "IncSearch", { fg = "#000000", bg = "#8CCF7E" })
-- 		-- hlslens
-- 		-- hl(0, "HlSearchNear", { fg = "#000000", bg = "#8CCF7E" })
-- 		hl(0, "HlSearchLens", { bg = "#0b0e14", fg = "#0b0e14" })
-- 		-- hl(0, "HlSearchLensNear", { fg = "#000000", bg = "#8CCF7E" })
-- 		-- general
-- 		-- hl(0, "FloatBorder", { fg = "#2f3639" })
-- 		-- hl(0, "NormalFloat", { bg = "#141b1e" })
-- 		-- telescope
-- 		-- hl(0, "TelescopeMatching", { fg = "#bb9af7", bg = "NONE" })
-- 		-- fzf lua
-- 		-- hl(0, "FzfLuaLiveSym", { fg = "#2AC3DE", bg = "NONE" })
-- 		-- blink.cmp
-- 		hl(0, "BlinkCmpMenu", { bg = "#0b0e14" })
-- 		hl(0, "BlinkCmpMenuBorder", { fg = "#636a72", bg = "#0b0e14" })
-- 		hl(0, "BlinkCmpDoc", { bg = "#0b0e14" })
-- 		hl(0, "BlinkCmpKind", { bg = "#0b0e14" })
-- 		-- hl(0, "BlinkCmpMenuSelection", { bg = "#1a2124" })
-- 		hl(0, "BlinkCmpSignatureHelpActiveParameter", { bg = "#2f3639" })
-- 		hl(0, "BlinkCmpDocBorder", { fg = "#636a72", bg = "#0b0e14" })
-- 		-- hl(0, "BlinkCmpDocSeparator", { fg = "#2f3639", bg = "#141b1e" })
-- 		-- hl(0, "BlinkCmpSignatureHelp", { bg = "#141b1e" })
-- 		hl(0, "BlinkCmpSignatureHelpBorder", { fg = "#636a72", bg = "#0b0e14" })
-- 		hl(0, "BlinkCmpLabelDeprecated", { fg = "#2f3639", strikethrough = true })
-- 		-- dropbar
-- 		hl(0, "DropBarMenuCurrentContext", { fg = "#2f3639", bg = "#1a2124" })
-- 		hl(0, "DropBarMenuHoverEntry", { fg = "#dadada", bg = "#1a2124" })

-- 		hl(0, "DropBarMenuFloatBorder", { fg = "#636a72", bg = "#0b0e14" })
-- 		hl(0, "DropBarMenuNormalFloat", { bg = "#0b0e14" })
-- 	end,
-- }

return {
	"olimorris/onedarkpro.nvim",
	lazy = false,
	priority = 1000, -- Ensure it loads first
	config = function()
		vim.cmd("colorscheme onedark")
	end,
}
