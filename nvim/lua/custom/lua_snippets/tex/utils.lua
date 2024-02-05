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

local M = {}

-------- CONTEXTS --------
local texMathZones = {}
for _, x in ipairs({'A', 'AS', 'B', 'BS', 'C', 'CS', 'D', 'DS', 'E', 'ES', 'F', 'FS', 'G', 'GS', 'H', 'HS', 'I', 'IS', 'J', 'JS', 'K', 'KS', 'L', 'LI', 'LD', 'LS', 'DS', 'V', 'W', 'X', 'XX', 'Y', 'Z', 'AmsA', 'AmsB', 'AmsC', 'AmsD', 'AmsE', 'AmsF', 'AmsG', 'AmsAS', 'AmsBS', 'AmsCS', 'AmsDS', 'AmsES', 'AmsFS', 'AmsGS'}) do
   texMathZones['texMathZone' .. x] = true
end
local texIgnoreMathZones = {texMathText = true}

function M.math_mode()
    if vim.bo.filetype == "tex" then
        return vim.fn['vimtex#syntax#in_mathzone']() == 1
    end
    local stack = vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.')-1)
    for ind = #stack, 1, -1 do
        local id = stack[ind]
        local name = vim.fn.synIDattr(id, 'name')
        if texMathZones[name] then return true end
        if texIgnoreMathZones[name] then return false end
    end
    return false
end

function M.not_math_mode()
    return not M.math_mode()
end

function M.latex_mode()
    if vim.bo.filetype == "tex" then
        return true
    end
    local stack = vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.')-1)
    for ind = 1, #stack, 1 do
        local id = stack[ind]
        local name = vim.fn.synIDattr(id, 'name')
        if texMathZones[name] then return true end
    end
    return false
end

function M.md_mode()
    return vim.bo.filetype == "markdown" and not M.latex_mode()
end

M.auto_backslash_snippet = function(context, opts)
	opts = opts or {}
	if not context.trig then
		error("context doesn't include a `trig` key which is mandatory", 2)
	end
	context.dscr = context.dscr or (context.trig .. "with automatic backslash")
	context.name = context.name or context.trig
	context.docstring = context.docstring or ([[\]] .. context.trig)
	return autosnippet(context, t([[\]] .. context.trig), opts)
end

M.symbol_snippet = function(context, command, opts)
	opts = opts or {}
	if not context.trig then
		error("context doesn't include a `trig` key which is mandatory", 2)
	end
	context.dscr = context.dscr or command
	context.name = context.name or command:gsub([[\]], "")
	context.docstring = context.docstring or (command .. [[{0}]])
	context.wordTrig = context.wordTrig or false
	return autosnippet(context, t(command), opts)
end

return M
