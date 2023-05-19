local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup({
    matchup = {
        enable = true,              -- mandatory, false will disable the whole extension
        enable_quotes = true
        -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
        -- [options]
    },
    ensure_installed = "all",
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
    },
    autopairs = {
        enable = true,
    },
    indent = {
        enable = true,
        disable = { "python", },
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    }
})
