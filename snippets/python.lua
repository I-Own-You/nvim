local ls = require('luasnip')

local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

local snippets, autosnippets = {}, {}

local dbdj = s(
    { trig = 'dbdj_', regTrig = true, hidden = true},
    fmt(
        [[
        DATABASES = {}
            "default": {}
                "ENGINE": "{}",
                "NAME": "{}",
                "USER": "{}",
                "PASSWORD": "{}",
                "HOST": "{}",
                "PORT": "{}",
            {}
        {}
        ]],
        {
            t('{'),
            t('{'),
            c(1, {
                i(1, ''),
                t('django.db.backends.postgresql'),
                t('django.db.backends.mysql'),
                t('django.db.backends.sqlite3'),
                t('django.db.backends.oracle'),
            }),
            i(2, ''),
            i(3, ''),
            i(4, ''),
            i(5, ''),
            i(6, ''),
            t('}'),
            t('}'),
        }
    )
)




table.insert(autosnippets, dbdj)
return snippets, autosnippets

-- local gorup = vim.api.nvim_create_augroup('Lua Snippets', { clear = true })
-- local fiel_pattern = '*.lua'

-- simple snippet example
-- local myFirstSnippet = s('myFirstSnippet', {
--     t('Hi zdarova!'),
--     i(1, " placeholder"),
--     i(1, " placeholder2"),
-- })

-- snippet fmt example
-- local fndef = s(
--     'fndef',
--     fmt(
--         [[
--         def {}({}):
--             return {}
--         ]],
--         {
--             i(1, ""),
--             c(2, {
--                 t(''),
--                 t('first_arg'),
--                 t('second_arg'),
--             }),
--             i(3, ""),
--         }
--     )
-- )

-- dynamic snippet example
-- local dynamic_snippet = s(
--     { trig = "for([%w_]+)", regTrig = true, hidden = true},
--     fmt(
--         [[
--         for {} in {}({}):
--             print({})
--         ]],
--         {
--             d(1, function(_, snip)
--                 return sn(1, i(1, snip.captures[1]))
--             end),
--             -- rep(1),
--             -- c(2, {
--             --     t('range'),
--             --     t('enumerate'),
--             --     t('reversed'),
--             -- }),
--             c(2, { i(1, 'range'), sn(1, { i(1, ''), t('.length')})}),
--             i(3, ''),
--             rep(1)
--         }
--     )
-- )

-- using function snippets arg - is the nodes, snip is a helper function
-- local function_snippet = s({ trig = 'auto(%d)', regTrig = true}, {
--     i(1, 'kekl'),
--     f(function(arg, snip)
--         return arg[1][1]:upper() .. arg[2][1]:lower() .. snip.captures[1]
--     end, {1, 2}),
--     i(2, 'another kekl'),
--     rep(1) -- will repeat the first node
-- })

-- autosnippets
-- local auto_snippet = s('auto-', { t('HELLO')})
-- local auto_snippet = s({trig = 'auto-', regTrig = true}, { t('HELLO')})
-- local auto_snippet = s({trig = 'auto%d', regTrig = true, hidden = true}, { t('HELLO')}) -- regexp works as well, for auto and not
-- table.insert(autosnippets, auto_snippet)
