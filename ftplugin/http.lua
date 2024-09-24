vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<A-k>rr",
	"<cmd>lua require('kulala').run()<cr>",
	{ noremap = true, silent = true, desc = "Execute the request" }
)

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<A-k>ra",
	"<cmd>lua require('kulala').run_all()<cr>",
	{ noremap = true, silent = true, desc = "Execute all requests in buffer" }
)

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<A-k>re",
	"<cmd>lua require('kulala').replay()<cr>",
	{ noremap = true, silent = true, desc = "Execute last request" }
)

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<A-k>rt",
	"<cmd>lua require('kulala').show_stats()<cr>",
	{ noremap = true, silent = true, desc = "Show stats for the last request" }
)

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<A-k>os",
	"<cmd>lua require('kulala').scratchpad()<cr>",
	{ noremap = true, silent = true, desc = "Open scratchpad" }
)

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<A-k>p",
	"<cmd>lua require('kulala').jump_prev()<cr>",
	{ noremap = true, silent = true, desc = "Jump to the previous request" }
)

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<A-k>n",
	"<cmd>lua require('kulala').jump_next()<cr>",
	{ noremap = true, silent = true, desc = "Jump to the next request" }
)

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<A-k>i",
	"<cmd>lua require('kulala').inspect()<cr>",
	{ noremap = true, silent = true, desc = "Inspect the current request" }
)

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<A-k>t",
	"<cmd>lua require('kulala').toggle_view()<cr>",
	{ noremap = true, silent = true, desc = "Toggle between body and headers" }
)

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<A-k>co",
	"<cmd>lua require('kulala').copy()<cr>",
	{ noremap = true, silent = true, desc = "Copy the current request as a curl command" }
)

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<A-k>ci",
	"<cmd>lua require('kulala').from_curl()<cr>",
	{ noremap = true, silent = true, desc = "Paste curl from clipboard as http request" }
)

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<A-k>ci",
	"<cmd>lua require('kulala').from_curl()<cr>",
	{ noremap = true, silent = true, desc = "Paste curl from clipboard as http request" }
)

-- scripts_clear_global -- https://kulala.mwco.app/docs/usage/public-methods#scripts_clear_global
-- download_graphql_schema -- https://kulala.mwco.app/docs/usage/public-methods#download_graphql_schema
-- get_selected_env -- https://kulala.mwco.app/docs/usage/public-methods#get_selected_env
-- set_selected_env -- https://kulala.mwco.app/docs/usage/public-methods#set_selected_env
