require("nvim-possession").setup({
sessions = {
        sessions_path = './sessions/', -- folder to look for sessions, must be a valid existing path
        -- sessions_variable = ..., -- defines vim.g[sessions_variable] when a session is loaded
        sessions_icon = ' 󱁿 ',
    },

    autoload = false, -- whether to autoload sessions in the cwd at startup
    autosave = true, -- whether to autosave loaded sessions before quitting
    autoswitch = {
        enable = true, -- whether to enable autoswitch
        exclude_ft = {}, -- list of filetypes to exclude from autoswitch
    },

    post_hook = nil,
    -- callback, function to execute after loading a session
                    -- useful to restore file trees, file managers or terminals
                    -- function()
                    --     require('FTerm').open()
                    --     require('nvim-tree').toggle(false, true)
                    -- end

    fzf_winopts = {
        -- any valid fzf-lua winopts options, for instance
        width = 0.7,
        preview = {
            horizontal = "right:50%"
        }
    }
})




