-- [
-- snip_env + autosnippets
-- ]
local ls = require( 'luasnip' )
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require( 'luasnip.util.events' )
local ai = require( 'luasnip.nodes.absolute_indexer' )
local extras = require( 'luasnip.extras' )
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require( 'luasnip.extras.fmt' ).fmt
local fmta = require( 'luasnip.extras.fmt' ).fmta
local conds = require( 'luasnip.extras.expand_conditions' )
local postfix = require( 'luasnip.extras.postfix' ).postfix
local types = require( 'luasnip.util.types' )
local parse = require( 'luasnip.util.parser' ).parse_snippet
local ms = ls.multi_snippet
local autosnippet = ls.extend_decorator.apply(
                        s, {
                            snippetType = 'autosnippet';
                        }
                     )

local line_begin = require( 'luasnip.extras.conditions.expand' ).line_begin
local math_mode = require( 'snippets.tex.utils' ).math_mode
local not_math_mode = require( 'snippets.tex.utils' ).not_math_mode
local latex_mode = require( 'snippets.tex.utils' ).latex_mode
local md_mode = require( 'snippets.tex.utils' ).md_mode

function should_expand_legacy_math_delimeters()
    return not_math_mode() and md_mode()
end

function should_expand_modern_math_delimeters()
    return not_math_mode() and latex_mode()
end

-- Generating functions for Matrix/Cases - thanks L3MON4D3!
local generate_matrix = function( args, snip )
    local rows = tonumber( snip.captures[2] )
    local cols = tonumber( snip.captures[3] )
    local nodes = {}
    local ins_indx = 1
    for j = 1, rows do
        table.insert( nodes, r( ins_indx, tostring( j ) .. 'x1', i( 1 ) ) )
        ins_indx = ins_indx + 1
        for k = 2, cols do
            table.insert( nodes, t( ' & ' ) )
            table.insert( nodes, r( ins_indx, tostring( j ) .. 'x' .. tostring( k ), i( 1 ) ) )
            ins_indx = ins_indx + 1
        end
        table.insert(
            nodes, t(
                {
                    [[\\]];
                    '';
                 }
             )
         )
    end
    -- fix last node.
    nodes[#nodes] = t( [[\\]] )
    return sn( nil, nodes )
end

-- update for cases
local generate_cases = function( args, snip )
    local rows = tonumber( snip.captures[1] ) or 2 -- default option 2 for cases
    local cols = 2 -- fix to 2 cols
    local nodes = {}
    local ins_indx = 1
    for j = 1, rows do
        table.insert( nodes, r( ins_indx, tostring( j ) .. 'x1', i( 1 ) ) )
        ins_indx = ins_indx + 1
        for k = 2, cols do
            table.insert( nodes, t( ' & ' ) )
            table.insert( nodes, r( ins_indx, tostring( j ) .. 'x' .. tostring( k ), i( 1 ) ) )
            ins_indx = ins_indx + 1
        end
        table.insert(
            nodes, t(
                {
                    [[\\]];
                    '';
                 }
             )
         )
    end
    -- fix last node.
    table.remove( nodes, #nodes )
    return sn( nil, nodes )
end

M = { -- Matrices and Cases
    s(
        {
            trig = '([bBpvV])mat(%d+)x(%d+)([ar])';
            name = '[bBpvV]matrix';
            dscr = 'matrices';
            regTrig = true;
            hidden = true;
        }, fmta(
            [[
    \begin{<>}<>
    <>
    \end{<>}]], {
                f(
                    function( _, snip )
                        return snip.captures[1] .. 'matrix'
                    end
                 );
                f(
                    function( _, snip )
                        if snip.captures[4] == 'a' then
                            out = string.rep( 'c', tonumber( snip.captures[3] ) - 1 )
                            return '[' .. out .. '|c]'
                        end
                        return ''
                    end
                 );
                d( 1, generate_matrix );
                f(
                    function( _, snip )
                        return snip.captures[1] .. 'matrix'
                    end
                 );
            }
         ), {
            condition = math_mode;
            show_condition = math_mode;
         }
     );
    autosnippet(
        {
            trig = '(%d?)cases';
            name = 'cases';
            dscr = 'cases';
            regTrig = true;
            hidden = true;
         }, fmta(
            [[\begin{cases}]] .. '\n<>\n' .. [[\end{cases}]], {
                d( 1, generate_cases );
             }
         ), {
            condition = math_mode;
            show_condition = math_mode;
         }
     );
    autosnippet(
        {
            trig = 'mk';
            name = 'enter math mode';
            dscr = 'enter inline math mode';
         }, fmta(
            [[$<>$<>]], {
                i( 1 );
                i( 0 );
             }
         ), {
            condition = should_expand_legacy_math_delimeters;
            show_condition = should_expand_legacy_math_delimeters;
         }
     );
    autosnippet(
        {
            trig = 'mk';
            name = 'enter math mode';
            dscr = 'enter inline math mode';
         }, fmta(
            [[\(<>\)<>]], {
                i( 1 );
                i( 0 );
             }
         ), {
            condition = should_expand_modern_math_delimeters;
            show_condition = should_expand_modern_math_delimeters;
         }
     );
    autosnippet(
        {
            trig = 'dm';
            name = 'enter math display mode';
            dscr = 'enter display math mode';
         }, fmta(
            '$$\n<>\n$$<>', {
                i( 1 );
                i( 0 );
             }
         ), {
            condition = should_expand_legacy_math_delimeters;
            show_condition = should_expand_legacy_math_delimeters;
         }
     );
    autosnippet(
        {
            trig = 'dm';
            name = 'enter math display mode';
            dscr = 'enter display math mode';
         }, fmta(
            '\\[\n<>\n\\]<>', {
                i( 1 );
                i( 0 );
             }
         ), {
            condition = should_expand_modern_math_delimeters;
            show_condition = should_expand_modern_math_delimeters;
         }
     );
}

return M
