local dap = require("dap")

require("mason-nvim-dap").setup({
    -- A list of adapters to install if they're not already installed.
    -- This setting has no relation with the `automatic_installation` setting.
    ensure_installed = {
        "debugpy",
    },

	-- NOTE: this is left here for future porting in case needed
	-- Whether adapters that are set up (via dap) should be automatically installed if they're not already installed.
	-- This setting has no relation with the `ensure_installed` setting.
	-- Can either be:
	--   - false: Daps are not automatically installed.
	--   - true: All adapters set up via dap are automatically installed.
	--   - { exclude: string[] }: All adapters set up via mason-nvim-dap, except the ones provided in the list, are automatically installed.
	--       Example: automatic_installation = { exclude = { "python", "delve" } }
    automatic_installation = true,

	-- Whether adapters that are installed in mason should be automatically set up in dap.
	-- Removes the need to set up dap manually.
	-- See mappings.adapters and mappings.configurations for settings.
	-- Must invoke when set to true: `require 'mason-nvim-dap'.setup_handlers()`
	-- Can either be:
	-- 	- false: Dap is not automatically configured.
	-- 	- true: Dap is automatically configured.
	-- 	- {adapters: {ADAPTER: {}, }, configurations: {configuration: {}, }, filetypes: {filetype: {}, }}. Allows overriding default configuration.
	-- 	- {adapters: function(default), configurations: function(default), filetypes: function(default), }. Allows modifying the default configuration passed in via function.
	automatic_setup = true,
    -- automatic_setup = {
    --     -- modifies the default configurations table
    --     -- pass in a function or a list to override with
    --     -- the same can be done for adapters and filetypes
    --     configurations = function(default)
    --         default.php[1].port = 9003
    --
    --         return default
    --     end,
    -- }
})

-- The setup_handlers() function provides a dynamic way of setting up sources and any other needed logic, It can also do that during runtime.
--
-- NOTE: When setting automatic_setup = true, the handler function needs to be called at a minimum like: require 'mason-nvim-dap'.setup_handlers(). When passing in a custom handler function for the the default or a source, then the automatic_setup function one won't be invoked. See below to keep original functionality inside the custom handler.

require 'mason-nvim-dap'.setup_handlers {
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
                    -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                    -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                    -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
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

    local signs = {
        { name = "DiagnosticSignError", text ="" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end
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

    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end
end
