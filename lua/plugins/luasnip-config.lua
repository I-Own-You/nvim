local ls = require('luasnip')

require('luasnip.loaders.from_lua').load({ paths = '~/.config/nvim/snippets'})

ls.config.set_config({
    history = true,
    updateevents = "TextChanged, TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [require('luasnip.util.types').choiceNode] = {
            active = {
                virt_text = { { "", "GruvboxOrange"} },
            },
        },
    },
})


vim.keymap.set({ 'i', 's' }, "<a-P>", function()
    if ls.expand_or_jumpable() then
        ls.expand()
    end
end)

vim.keymap.set({ 'i', 's' }, "<a-k>", function()
    if ls.jumpabale(1) then
        ls.jump(1)
    end
end)

vim.keymap.set({ 'i', 's' }, "<a-j>", function()
    if ls.jumpabale(-1) then
        ls.jump(-1)
    end
end)

vim.keymap.set({ 'i', 's' }, "<a-l>", function() -- scroll through choice nodes
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

vim.keymap.set({ 'i', 's' }, "<a-h>", function() -- scroll through choice nodes
    if ls.choice_active() then
        ls.change_choice(-1)
    end
end)
