local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

M = {}

delimiters = {
    ["{"] = {
        left_side = [[\{]],
        right_side = [[\}]]
    },
    ["("] = {
        right_side = [[)]]
    },
    ["["] = {
        right_side = "]"
    },
    ["<"] = {
        left_side = [[\langle]],
        right_side = [[\rangle]]
    },
    ["|"] = {
        right_side = [[|]]
    },
}

local delimeter_snippets = {}
for k, v in pairs(delimiters) do
    trig = "lr" .. k
    context = vim.tbl_deep_extend("keep", {
        trig = trig,
        snippetType = "autosnippet",
        name = "Delimeter " .. k,
        dscr = "Left right " .. k,
    }, v.context or {})
    opts = vim.tbl_deep_extend("keep", {
        condition = math_mode
    }, v.opts or {})

    left_side = v.left_side or k
    right_side = v.right_side

    new_snippet = s(context, fmta([[\left<> <> \right<> <>]], {t(left_side), i(1), t(right_side), i(0)}), opts)

    table.insert(delimeter_snippets, new_snippet)
end
vim.list_extend(M, delimeter_snippets)

return M