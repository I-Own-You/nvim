-- local colorscheme = 'gatekeeper'
local colorscheme = 'horizon'

local status_ok, ok = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
    print('colorscheme ' .. colorscheme .. 'doesnt exist')


-- setup must be called before loading
vim.cmd("colorscheme " .. colorscheme) end
