-- [
-- snip_env + autosnippets
-- ]
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
local autosnippet = ls.extend_decorator.apply(s, {
    snippetType = "autosnippet"
})

local math_mode = require("custom.lua_snippets.tex.utils").math_mode
local not_math_mode = require("custom.lua_snippets.tex.utils").not_math_mode
local auto_backslash_snippet = require("custom.lua_snippets.tex.utils").auto_backslash_snippet
local symbol_snippet = require("custom.lua_snippets.tex.utils").symbol_snippet

M = {
    s({ trig='beg', name='begin/end', dscr='begin/end environment (generic)'},
    fmta([[
    \begin{<>}
    <>
    \end{<>}
    ]],
    { i(1), i(0), rep(1) }
    ), { condition = not_math_mode, show_condition = not_math_mode }),

    s({ trig='fig', name='begin/end', dscr='begin/end environment (generic)'},
    fmta([[
    \begin{figure}
      \includegraphics[width=0.7\textwidth]{img/}
      \label{fig:<>}
      \caption{<>}
    \end{figure}
    <>]],
    { i(1), i(2), i(3) }
    ), { condition = not_math_mode, show_condition = not_math_mode }),

    s({ trig='lsti', name='lst inline', dscr='lst inline'},
    fmta([[\lstinline{<>} <>]],
    { i(1), i(2) }
    ), { condition = not_math_mode, show_condition = not_math_mode }),

    s({ trig='emph', name='emph', dscr='emph'},
    fmta([[\emph{<>} <>]],
    { i(1), i(2) }
    ), { condition = not_math_mode, show_condition = not_math_mode }),

    s({ trig='bold', name='bold', dscr='bold'},
    fmta([[\textbf{<>} <>]],
    { i(1), i(2) }
    ), { condition = not_math_mode, show_condition = not_math_mode }),

    s({ trig = "-i", name = "itemize", dscr = "bullet points (itemize)" },
	fmta([[ 
    \begin{itemize}
    \item <>
    \end{itemize}
    ]],
	{ c(1, { i(0), sn(nil, fmta(
		[[
        [<>] <>
        ]],
		{ i(1), i(0) })) })
    }
    ),
    { condition = not_math_mode, show_condition = not_math_mode }),

    -- requires enumitem
	s({ trig = "-e", name = "enumerate", dscr = "numbered list (enumerate)" },
    fmta([[ 
    \begin{enumerate}<>
    \item <>
    \end{enumerate}
    ]],
	{c(1, { t(""), sn(nil, fmta(
		[[
        [label=<>]
        ]],
        { c(1, { t("(\\alph*)"), t("(\\roman*)"), i(1) }) })) }),
	c(2, { i(0), sn(nil, fmta(
        [[
        [<>] <>
        ]],
        { i(1), i(0) })) })
    }
    ),
	{ condition = not_math_mode, show_condition = not_math_mode }),

}

return M
