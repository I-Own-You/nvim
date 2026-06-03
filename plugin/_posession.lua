vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim", -- dep
	"https://github.com/nvim-telescope/telescope.nvim", -- dep
	"https://github.com/jedrzejboczar/possession.nvim",
})

require("possession").setup({
	silent = false,
	load_silent = true,
	debug = false,
	logfile = false,
	prompt_no_cr = false,
	autosave = {
		current = true, -- or fun(name): boolean
		tmp = false, -- or fun(): boolean
		tmp_name = "tmp", -- or fun(): string
		on_load = true,
		on_quit = true,
	},
	commands = {
		save = "PossessionSave",
		load = "PossessionLoad",
		rename = "PossessionRename",
		close = "PossessionClose",
		delete = "PossessionDelete",
		show = "PossessionShow",
		list = "PossessionList",
		migrate = "PossessionMigrate",
	},
	hooks = {
		before_save = function(name)
			local tabpages = vim.api.nvim_list_tabpages()
			local titles = {}

			for _, tab_handle in ipairs(tabpages) do
				local has_name, title = pcall(vim.api.nvim_tabpage_get_var, tab_handle, "tab_title")
				if has_name then
					table.insert(titles, title)
				else
					table.insert(titles, "") -- Blank space for un-renamed tabs
				end
			end

			return {
				custom_tab_titles = titles,
			}
		end,

		after_save = function(name, user_data, aborted) end,
		before_load = function(name, user_data)
			return user_data
		end,

		after_load = function(name, user_data)
			if not user_data or not user_data.custom_tab_titles then
				return
			end

			local titles = user_data.custom_tab_titles
			local tabpages = vim.api.nvim_list_tabpages()

			for i, tab_handle in ipairs(tabpages) do
				if titles[i] and titles[i] ~= "" then
					vim.api.nvim_tabpage_set_var(tab_handle, "tab_title", titles[i])
				end
			end

			vim.cmd("redrawtabline")
		end,
	},
	plugins = {
		close_windows = {
			hooks = { "before_save", "before_load" },
			preserve_layout = true, -- or fun(win): boolean
			match = {
				floating = true,
				buftype = {},
				filetype = {},
				custom = false, -- or fun(win): boolean
			},
		},
		-- delete_hidden_buffers = {
		-- 	hooks = {
		-- 		"before_load",
		-- 		vim.o.sessionoptions:match("buffer") and "before_save",
		-- 	},
		-- 	force = false, -- or fun(buf): boolean
		-- },
		nvim_tree = true,
		tabby = true,
		dap = true,
		delete_buffers = true,
		delete_hidden_buffers = false,
	},
	telescope = {
		list = {
			default_action = "load",
			mappings = {
				save = { n = "<c-s>", i = "<c-s>" },
				load = { n = "<CR>", i = "<CR>" },
				delete = { n = "<c-x>", i = "<c-x>" },
				rename = { n = "<c-r>", i = "<c-r>" },
			},
		},
	},
})

vim.keymap.set("n", "<leader>sl", ":Telescope possession list<CR>", { desc = "Open sessions list", silent = true })
-- vim.keymap.set("n", "<leader>sl", function()
-- 	require("telescope").extensions.possession.list({
-- 		previewer = false,
-- 		layout_strategy = "vertical",
-- 		layout_config = { width = 0.4, height = 0.4 },
-- 	})
-- end, { desc = "List sessions cleanly" })
vim.keymap.set("n", "<leader>ss", ":PossessionSave ", { desc = "save session" })
