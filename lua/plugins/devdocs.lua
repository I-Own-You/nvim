return {
	-- dir_path = vim.fn.stdpath("data") .. "/devdocs", -- installation directory
	telescope = {}, -- passed to the telescope picker
	telescope_alt = { -- when searching globally without preview
		layout_config = {
			width = 75,
		},
	},
	float_win = { -- passed to nvim_open_win(), see :h api-floatwin
		relative = "editor",
		height = 25,
		width = 100,
		border = "rounded",
	},
	wrap = true, -- text wrap, only applies to floating window
	--  install them: html, javascript, npm, react, express, react-router, css, typescript, python, django, tailwindcss, dom
	-- previewer_cmd = "glow",
	cmd_args = { "-s", "dark", "-w", "80" },
	cmd_ignore = {}, -- ignore cmd rendering for the listed docs
	picker_cmd = false, -- use cmd previewer in picker preview
	picker_cmd_args = {}, -- example using glow: { "-s", "dark", "-w", "50" }
	mappings = { -- keymaps for the doc buffer
		open_in_browser = "",
	},
	ensure_installed = {}, -- get automatically installed
	-- {"javascript", "typescript", "html", "react", "express", "go", "htmx", "dom", "lua", "python"}
	after_open = function(bufnr)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", ":close<CR>", {})
	end, -- callback that runs after the Devdocs window is opened. Devdocs buffer ID will be passed in
}
