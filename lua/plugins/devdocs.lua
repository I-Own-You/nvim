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
	wrap = false, -- text wrap, only applies to floating window
	-- ensure_installed = { "html", "javascript", "typescript", "go", "lua-5.4", "python-3.11", "django-4.2", "tailwindcss" }, -- get automatically installed
	previewer_cmd = "glow",
	cmd_args = { "-s", "dark", "-w", "80" },
  -- cmd_ignore = {}, -- ignore cmd rendering for the listed docs
  -- picker_cmd = false, -- use cmd previewer in picker preview
  -- picker_cmd_args = {}, -- example using glow: { "-p" }
}
