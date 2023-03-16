local colorscheme = 'gatekeeper'

local status_ok, ok = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
    print('colorscheme ' .. colorscheme .. 'doesnt exist')
else
    vim.cmd("colorscheme " .. colorscheme)
end


