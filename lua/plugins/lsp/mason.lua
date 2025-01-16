local servers = {
	"lua_ls",
	--
	"ts_ls",
	"html",
	-- "emmet_language_server",
	"cssls",
	"jsonls",
	"pyright",
	-- "pylsp",
	-- "cssmodules_ls",
	-- "taplo",
	-- "yamlls",
	-- "eslint",
	"biome",
	"prismals",
	"bashls",
	"gopls",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = " ",
			package_pending = "󱦟 ",
			package_uninstalled = " ",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

-- require("neodev").setup({})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("plugins.lsp.handlers").on_attach,
		capabilities = require("plugins.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "plugins.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
