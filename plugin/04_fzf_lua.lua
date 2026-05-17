vim.pack.add({
	"https://github.com/kyazdani42/nvim-web-devicons", -- dep
	"https://github.com/nvim-telescope/telescope.nvim", -- dep
	"https://github.com/ibhagwan/fzf-lua",
})

local actions = require("fzf-lua.actions")
require("fzf-lua").setup({
	"telescope",
	winopts = {
		preview = {
			layout = "horizontal",
		},
	},
	previewers = {
		builtin = {
			extensions = {
				-- ["png"] = { "ueberzug" },
				-- ["jpg"] = { "ueberzug" },
				-- ["svg"] = { "ueberzug" },
				-- ["jpeg"] = { "ueberzug" },
			},
		},
	},
	git = {
		status = {
			actions = {
				["alt-l"] = { fn = actions.git_unstage, reload = true },
				["alt-h"] = { fn = actions.git_stage, reload = true },
			},
		},
	},
})

vim.keymap.set("n", "<leader>bb", function()
	require("fzf-lua").buffers()
end, { desc = "buffers list", silent = true })

vim.keymap.set("n", "<leader>ta", function()
	require("fzf-lua").tabs()
end, { desc = "tabs list", silent = true })

vim.keymap.set("n", "<leader>ho", function()
	require("fzf-lua").oldfiles()
end, { desc = "old files", silent = true })

vim.keymap.set("n", "<leader>lb", function()
	require("fzf-lua").lgrep_curbuf()
end, { desc = "buffer lines", silent = true })

vim.keymap.set("n", "<leader>gst", function()
	require("fzf-lua").git_status()
end, { desc = "git status", silent = true })

vim.keymap.set("n", "<leader>fgl", function()
	require("fzf-lua").git_commits()
end, { desc = "project commits", silent = true })

vim.keymap.set("n", "<leader>fgb", function()
	require("fzf-lua").git_bcommits()
end, { desc = "buffer commits", silent = true })

vim.keymap.set("n", "<leader>gbb", function()
	require("fzf-lua").git_branches()
end, { desc = "git branches", silent = true })

vim.keymap.set("n", "<leader>gsh", function()
	require("fzf-lua").git_stash()
end, { desc = "git stash list", silent = true })

vim.keymap.set("n", "<leader>gt", function()
	require("fzf-lua").git_tags()
end, { desc = "git tags", silent = true })

vim.keymap.set("n", "gs", function()
	require("fzf-lua").lsp_document_symbols()
end, { desc = "lsp symbols", silent = true })

vim.keymap.set("n", "gR", function()
	require("fzf-lua").lsp_finder()
end, { desc = "all lsp refs", silent = true })

vim.keymap.set("n", "<leader>lw", function()
	require("fzf-lua").lsp_workspace_diagnostics()
end, { desc = "project diagnostics", silent = true })

vim.keymap.set("n", "<leader>bt", function()
	require("fzf-lua").builtin()
end, { desc = "fzflua builtins", silent = true })

vim.keymap.set("n", "<leader>ht", function()
	require("fzf-lua").help_tags()
end, { desc = "help tags", silent = true })

vim.keymap.set("n", "<leader>hc", function()
	require("fzf-lua").command_history()
end, { desc = "comand history", silent = true })

vim.keymap.set("n", "<leader>hs", function()
	require("fzf-lua").search_history()
end, { desc = "search history", silent = true })

vim.keymap.set("n", "<leader>fk", function()
	require("fzf-lua").keymaps()
end, { desc = "keymaps", silent = true })

vim.keymap.set("n", "<leader>ol", function()
	require("fzf-lua").tags()
end, { desc = "project tags", silent = true })

vim.keymap.set("n", "<leader>tb", function()
	require("fzf-lua").btags()
end, { desc = "buffer tags", silent = true })

vim.keymap.set("n", "<leader>tw", function()
	require("fzf-lua").tags_grep_cword()
end, { desc = "grep tag word", silent = true })

vim.keymap.set("n", "<leader>tl", function()
	require("fzf-lua").tags_live_grep()
end, { desc = "live tag", silent = true })

vim.keymap.set("n", "<leader><leader>", function()
	require("fzf-lua").grep_project()
end, { desc = "grep with rules", silent = true })

vim.keymap.set("n", "<leader>gw", function()
	require("fzf-lua").grep_cword()
end, { desc = "grep word", silent = true })

vim.keymap.set("n", "<A-f>", function()
	require("fzf-lua").files({ winopts = { preview = { hidden = "hidden" } }, fzf_opts = { ["--layout"] = "default" } })
end, { silent = true, desc = "find files" })

vim.keymap.set("n", "<A-a>", function()
	require("fzf-lua").files({
		fd_opts = "--color=never --type f --hidden --follow --no-ignore",
		winopts = { preview = { hidden = "hidden" } },
		fzf_opts = { ["--layout"] = "default" },
	})
end, { silent = true, desc = "find hidden/ignored files" })

vim.keymap.set("n", "<leader>ll", function()
	require("fzf-lua").lines({ winopts = { preview = { hidden = "hidden" } } })
end, { silent = true, desc = "lines from all buffers" })

vim.keymap.set("n", "<leader>gls", function()
	require("fzf-lua").git_files({ winopts = { preview = { hidden = "hidden" } } })
end, { silent = true, desc = "git files" })

vim.keymap.set("n", "gS", function()
	require("fzf-lua").lsp_live_workspace_symbols({ file_ignore_patterns = { "^node_modules/" } })
end, { silent = true, desc = "live workspace symbols" })

vim.keymap.set("n", "<leader>ka", function()
	require("fzf-lua").lsp_code_actions({ winopts = { preview = { hidden = "hidden" } } })
end, { silent = true, desc = "code actions" })

vim.keymap.set("n", "<leader>a", function()
	require("fzf-lua").grep_project({
		rg_opts = "--hidden --no-ignore --column --line-number --no-heading --color=always --smart-case --max-columns=4096",
	})
end, { silent = true, desc = "grep without rules(everyhting)" })
