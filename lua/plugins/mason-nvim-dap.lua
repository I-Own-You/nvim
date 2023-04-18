local dap = require("dap")

require("mason-nvim-dap").setup({
    ensure_installed = {
        "debugpy",
    },

    automatic_installation = true,

	automatic_setup = true,

    handlers = {

        function(source_name)
            -- all sources with no handler get passed here


            -- Keep original functionality of `automatic_setup = true`
            require('mason-nvim-dap.automatic_setup')(source_name)
        end,
        python = function(source_name)
            dap.adapters.python = {
                type = "executable",
                -- command = "/usr/bin/python3.11",
                command = "/home/mkc/.virtualenvs/debugpy/bin/python3.11",
                args = {
                    "-m",
                    "debugpy.adapter",
                },
            }

            dap.configurations.python = {
                {
                    type = "python",
                    request = "launch",
                    name = "Launch file",
                    pythonPath = function()
                        local cwd = vim.fn.getcwd()
                        if vim.fn.executable(cwd .. '/venv/bin/python3.11') == 1 then
                            return cwd .. '/venv/bin/python3.11'
                        elseif vim.fn.executable(cwd .. '/.venv/bin/python3.11') == 1 then
                            return cwd .. '/.venv/bin/python3.11'
                        elseif vim.fn.executable(cwd .. '/env/bin/python3.11') == 1 then
                            return cwd .. '/env/bin/python3.11'
                        elseif vim.fn.executable(cwd .. '/.env/bin/python3.11') == 1 then
                            return cwd .. '/.env/bin/python3.11'
                        else
                            return '/usr/bin/python3.11'
                        end
                    end;               program = "${file}", -- This configuration will launch the current file if used.
                },
            }
        end,
    }
})


local api = vim.api
local keymap_restore = {}
dap.listeners.after['event_initialized']['me'] = function()
    for _, buf in pairs(api.nvim_list_bufs()) do
        local keymaps = api.nvim_buf_get_keymap(buf, 'n')
        for _, keymap in pairs(keymaps) do
            if keymap.lhs == "K" then
                table.insert(keymap_restore, keymap)
                api.nvim_buf_del_keymap(buf, 'n', 'K')
            end
        end
    end
    api.nvim_set_keymap(
        'n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end

dap.listeners.after['event_terminated']['me'] = function()
    for _, keymap in pairs(keymap_restore) do
        api.nvim_buf_set_keymap(
            keymap.buffer,
            keymap.mode,
            keymap.lhs,
            keymap.rhs,
            { silent = keymap.silent == 1 }
        )
    end
    keymap_restore = {}
end
