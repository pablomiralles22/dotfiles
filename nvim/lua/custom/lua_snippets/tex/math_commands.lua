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
local auto_backslash_snippet = require("custom.lua_snippets.tex.utils").auto_backslash_snippet
local symbol_snippet = require("custom.lua_snippets.tex.utils").symbol_snippet

M = {
autosnippet({
    trig = "sr",
    wordTrig = false
}, {t("^2")}, {
    condition = math_mode,
    show_condition = math_mode
}), autosnippet({
    trig = "cb",
    wordTrig = false
}, {t("^3")}, {
    condition = math_mode,
    show_condition = math_mode
}), autosnippet({
    trig = "compl",
    wordTrig = false
}, {t("^{c}")}, {
    condition = math_mode,
    show_condition = math_mode
}), autosnippet({
    trig = "vtr",
    wordTrig = false
}, {t("^{T}")}, {
    condition = math_mode,
    show_condition = math_mode
}), autosnippet({
    trig = "inv",
    wordTrig = false
}, {t("^{-1}")}, {
    condition = math_mode,
    show_condition = math_mode
}), -- fractions
autosnippet({
    trig = '//',
    name = 'fraction',
    dscr = "fraction (general)"
}, fmta([[
    \frac{<>}{<>}<>
    ]], {i(1), i(2), i(0)}), {
    condition = math_mode,
    show_condition = math_mode
}), autosnippet({
    trig = '(%d+)/',
    name = 'fraction',
    dscr = 'auto fraction 1',
    regTrig = true,
    hidden = true
}, fmta([[
    \frac{<>}{<>}<>
    ]], {f(function(_, snip)
    return snip.captures[1]
end), i(1), i(0)}), {
    condition = math_mode,
    show_condition = math_mode
}), autosnippet({
    trig = "lim",
    name = "lim(sup|inf)",
    dscr = "lim(sup|inf)"
}, fmta([[ 
    \lim<><><>
    ]], {c(1, {t(""), t("sup"), t("inf")}), c(2, {t(""), fmta([[_{<> \to <>}]], {i(1, "n"), i(2, "\\infty")})}), i(0)}),
    {
        condition = math_mode,
        show_condition = math_mode
    }), autosnippet({
    trig = "sum",
    name = "summation",
    dscr = "summation"
}, fmta([[
    \sum<> <>
    ]], {c(1, {fmta([[_{<>}^{<>}]], {i(1, "i = 0"), i(2, "\\infty")}), t("")}), i(0)}), {
    condition = math_mode,
    show_condition = math_mode
}), autosnippet({
    trig = "prod",
    name = "product",
    dscr = "product"
}, fmta([[
    \prod<> <>
    ]], {c(1, {fmta([[_{<>}^{<>}]], {i(1, "i = 0"), i(2, "\\infty")}), t("")}), i(0)}), {
    condition = math_mode,
    show_condition = math_mode
}), autosnippet({
    trig = "cprod",
    name = "coproduct",
    dscr = "coproduct"
}, fmta([[
    \coprod<> <>
    ]], {c(1, {fmta([[_{<>}^{<>}]], {i(1, "i = 0"), i(2, "\\infty")}), t("")}), i(0)}), {
    condition = math_mode,
    show_condition = math_mode
}), autosnippet({
    trig = "set",
    name = "set",
    dscr = "set"
}, -- overload with set builder notation
fmta([[
    \{<>\}<>
    ]], {c(1, {r(1, ""), sn(nil, {r(1, ""), t(" \\mid "), i(2)})}), i(0)}), {
    condition = math_mode,
    show_condition = math_mode
}), autosnippet({
    trig = "nnn",
    name = "bigcap",
    dscr = "bigcap"
}, fmta([[
    \bigcap<> <>
    ]], {c(1, {fmta([[_{<>}^{<>}]], {i(1, "i = 0"), i(2, "\\infty")}), t("")}), i(0)}), {
    condition = math_mode,
    show_condition = math_mode
}), autosnippet({
    trig = "uuu",
    name = "bigcup",
    dscr = "bigcup"
}, fmta([[
    \bigcup<> <>
    ]], {c(1, {fmta([[_{<>}^{<>}]], {i(1, "i = 0"), i(2, "\\infty")}), t("")}), i(0)}), {
    condition = math_mode,
    show_condition = math_mode
}), autosnippet({
    trig = "bnc",
    name = "binomial",
    dscr = "binomial (nCR)"
}, fmta([[
    \binom{<>}{<>}<>
    ]], {i(1), i(2), i(0)}), {
    condition = math_mode,
    show_condition = math_mode
}), autosnippet({
    trig = "dint",
    name = "integration",
    dscr = "integration"
}, fmta([[
    \int_{<>}^{<>} <> <>
    ]], {i(1, "a"), i(2, "b"), i(3), i(0)}), {
    condition = math_mode,
    show_condition = math_mode
})}

-- Auto backslashes
local auto_backslash_specs = {"arcsin", "sin", "arccos", "cos", "arctan", "tan", "cot", "csc", "sec", "log", "ln",
                              "exp", "ast", "star", "perp", "sup", "inf", "det", "max", "min", "argmax", "argmin", "int"}

local auto_backslash_snippets = {}
for _, v in ipairs(auto_backslash_specs) do
    table.insert(auto_backslash_snippets, auto_backslash_snippet({
        trig = v
    }, {
        condition = math_mode
    }))
end
vim.list_extend(M, auto_backslash_snippets)

-- Symbols/Commands
local greek_specs = {
    aaa = {
        context = {
            name = "α"
        },
        command = [[\alpha]]
    },
    bbb = {
        context = {
            name = "β"
        },
        command = [[\beta]]
    },
    ggg = {
        context = {
            name = "gamma"
        },
        command = [[\gamma]]
    },
    www = {
        context = {
            name = "ω"
        },
        command = [[\omega]]
    },
    WW = {
        context = {
            name = "Ω"
        },
        command = [[\Omega]]
    },
    ddd = {
        context = {
            name = "δ"
        },
        command = [[\delta]]
    },
    DD = {
        context = {
            name = "Δ"
        },
        command = [[\Delta]]
    },
    eps = {
        context = {
            name = "ε",
            priority = 500
        },
        command = [[\epsilon]]
    },
    eta = {
        context = {
            name = "θ",
            priority = 500
        },
        command = [[\eta]]
    },
    zzz = {
        context = {
            name = "θ"
        },
        command = [[\zeta]]
    },
    qqq = {
        context = {
            name = "θ"
        },
        command = [[\theta]]
    },
    lll = {
        context = {
            name = "λ"
        },
        command = [[\lambda]]
    },
    LL = {
        context = {
            name = "Λ"
        },
        command = [[\Lambda]]
    },
    mu = {
        context = {
            name = "μ"
        },
        command = [[\mu]]
    },
    nu = {
        context = {
            name = "μ"
        },
        command = [[\nu]]
    },
    pi = {
        context = {
            name = "π"
        },
        command = [[\pi]]
    },
    rho = {
        context = {
            name = "π"
        },
        command = [[\rho]]
    },
    sig = {
        context = {
            name = "σ"
        },
        command = [[\sigma]]
    },
    Sig = {
        context = {
            name = "Σ"
        },
        command = [[\Sigma]]
    },
    xi = {
        context = {
            name = "Σ"
        },
        command = [[\xi]]
    },
    phi = {
        context = {
            name = "normal φ"
        },
        command = [[\phi]]
    },
    vphi = {
        context = {
            name = "φ"
        },
        command = [[\varphi]]
    },
    veps = {
        context = {
            name = "ε"
        },
        command = [[\varepsilon]]
    }
}

local greek_snippets = {}
for k, v in pairs(greek_specs) do
    table.insert(greek_snippets, symbol_snippet(vim.tbl_deep_extend("keep", {
        trig = k
    }, v.context), v.command, {
        condition = math_mode
    }))
end
vim.list_extend(M, greek_snippets)

local symbol_specs = {
    -- operators
    ["!="] = {
        context = {
            name = "!="
        },
        command = [[\neq]]
    },
    ["<="] = {
        context = {
            name = "≤"
        },
        command = [[\leq]]
    },
    [">="] = {
        context = {
            name = "≥"
        },
        command = [[\geq]]
    },
    ["<<"] = {
        context = {
            name = "<<"
        },
        command = [[\ll]]
    },
    [">>"] = {
        context = {
            name = ">>"
        },
        command = [[\gg]]
    },
    ["~~"] = {
        context = {
            name = "~"
        },
        command = [[\sim]]
    },
    ["~="] = {
        context = {
            name = "≈"
        },
        command = [[\approx]]
    },
    ["~-"] = {
        context = {
            name = "≃"
        },
        command = [[\simeq]]
    },
    ["-~"] = {
        context = {
            name = "⋍"
        },
        command = [[\backsimeq]]
    },
    ["-="] = {
        context = {
            name = "≡"
        },
        command = [[\equiv]]
    },
    ["=~"] = {
        context = {
            name = "≅"
        },
        command = [[\cong]]
    },
    [":="] = {
        context = {
            name = "≔"
        },
        command = [[\definedas]]
    },
    ["**"] = {
        context = {
            name = "·"
        },
        command = [[\cdot]],
        opts = {

            priority = 100
        }
    },
    xx = {
        context = {
            name = "×"
        },
        command = [[\times]]
    },
    ["!+"] = {
        context = {
            name = "⊕"
        },
        command = [[\oplus]]
    },
    ["!*"] = {
        context = {
            name = "⊗"
        },
        command = [[\otimes]]
    },
    -- sets
    NN = {
        context = {
            name = "ℕ"
        },
        command = [[\mathbb{N}]]
    },
    ZZ = {
        context = {
            name = "ℤ"
        },
        command = [[\mathbb{Z}]]
    },
    QQ = {
        context = {
            name = "ℚ"
        },
        command = [[\mathbb{Q}]]
    },
    RR = {
        context = {
            name = "ℝ"
        },
        command = [[\mathbb{R}]]
    },
    CC = {
        context = {
            name = "ℂ"
        },
        command = [[\mathbb{C}]]
    },
    OO = {
        context = {
            name = "∅"
        },
        command = [[\emptyset]]
    },
    pwr = {
        context = {
            name = "P"
        },
        command = [[\powerset]]
    },
    conin = {
        context = {
            name = "⊂"
        },
        command = [[\subset]]
    },
    conein = {
        context = {
            name = "⊆"
        },
        command = [[\subseteq]]
    },
    conby = {
        context = {
            name = "⊃"
        },
        command = [[\supset]]
    },
    qc = {
        context = {
            name = "⊇"
        },
        command = [[\supseteq]]
    },
    ["\\\\\\"] = {
        context = {
            name = "⧵"
        },
        command = [[\setminus]]
    },
    Nn = {
        context = {
            name = "∩"
        },
        command = [[\cap]]
    },
    UU = {
        context = {
            name = "∪"
        },
        command = [[\cup]]
    },
    ["::"] = {
        context = {
            name = ":"
        },
        command = [[\colon]]
    },
    -- quantifiers and logic stuffs
    AA = {
        context = {
            name = "∀"
        },
        command = [[\forall]]
    },
    EE = {
        context = {
            name = "∃"
        },
        command = [[\exists]]
    },
    inn = {
        context = {
            name = "∈"
        },
        command = [[\in]]
    },
    notin = {
        context = {
            name = "∉"
        },
        command = [[\not\in]]
    },
    ["!-"] = {
        context = {
            name = "¬"
        },
        command = [[\lnot]]
    },
    VV = {
        context = {
            name = "∨"
        },
        command = [[\lor]]
    },
    WW = {
        context = {
            name = "∧"
        },
        command = [[\land]]
    },
    ["!W"] = {
        context = {
            name = "∧"
        },
        command = [[\bigwedge]]
    },
    ["=>"] = {
        context = {
            name = "⇒"
        },
        command = [[\implies]]
    },
    ["=<"] = {
        context = {
            name = "⇐"
        },
        command = [[\impliedby]]
    },
    iff = {
        context = {
            name = "⟺"
        },
        command = [[\iff]]
    },
    ["->"] = {
        context = {
            name = "→"
        },
        command = [[\to]],
        opts = {
            priority = 250
        }
    },
    ["!>"] = {
        context = {
            name = "↦"
        },
        command = [[\mapsto]]
    },
    ["<-"] = {
        context = {
            name = "↦"
        },
        command = [[\gets]],
        opts = {
            priority = 250
        }
    },
    -- differentials 
    dp = {
        context = {
            name = "⇐"
        },
        command = [[\partial]]
    },
    -- arrows
    ["-->"] = {
        context = {
            name = "⟶"
        },
        command = [[\longrightarrow]],
        opts = {
            priority = 500
        }
    },
    ["<->"] = {
        context = {
            name = "↔"
        },
        command = [[\leftrightarrow]],
        opts = {
            priority = 500
        }
    },
    ["2>"] = {
        context = {
            name = "⇉",
            priority = 400
        },
        command = [[\rightrightarrows]],
        opts = {
            priority = 400
        }
    },
    upar = {
        context = {
            name = "↑"
        },
        command = [[\uparrow]]
    },
    dnar = {
        context = {
            name = "↓"
        },
        command = [[\downarrow]]
    },
    -- etc
    ooo = {
        context = {
            name = "∞"
        },
        command = [[\infty]]
    },
    lll = {
        context = {
            name = "ℓ"
        },
        command = [[\ell]]
    },
    dag = {
        context = {
            name = "†"
        },
        command = [[\dagger]]
    },
    ["+-"] = {
        context = {
            name = "†"
        },
        command = [[\pm]]
    },
    ["-+"] = {
        context = {
            name = "†"
        },
        command = [[\mp]]
    },
    ["..."] = {
        context = {
            name = "..."
        },
        command = [[\dots]]
    }
}

local symbol_snippets = {}
for k, v in pairs(symbol_specs) do
    context = vim.tbl_deep_extend("keep", {
        trig = k
    }, v.context)
    opts = vim.tbl_deep_extend("keep", {
        condition = math_mode
    }, v.opts or {})
    table.insert(symbol_snippets, symbol_snippet(context, v.command, opts))
end
vim.list_extend(M, symbol_snippets)

local single_command_math_specs = {
    tt = {
        context = {
            name = "text (math)",
            dscr = "text in math mode"
        },
        command = [[\text]]
    },
    sbf = {
        context = {
            name = "symbf",
            dscr = "bold math text"
        },
        command = [[\symbf]]
    },
    syi = {
        context = {
            name = "symit",
            dscr = "italic math text"
        },
        command = [[\symit]]
    },
    udd = {
        context = {
            name = "underline (math)",
            dscr = "underlined text in math mode"
        },
        command = [[\underline]]
    },
    conj = {
        context = {
            name = "conjugate",
            dscr = "conjugate (overline)"
        },
        command = [[\overline]]
    },
    ["__"] = {
        context = {
            name = "subscript",
            dscr = "auto subscript 3",
            wordTrig = false
        },
        command = [[_]]
    },
    td = {
        context = {
            name = "superscript",
            dscr = "auto superscript alt",
            wordTrig = false
        },
        command = [[^]]
    },
    sbt = {
        context = {
            name = "substack",
            dscr = "substack for sums/products"
        },
        command = [[\substack]]
    },
    sq = {
        context = {
            name = "sqrt",
            dscr = "sqrt"
        },
        command = [[\sqrt]]
    },
    mbb = {
        context = {
            name = "mathbb",
            dscr = "math blackboard bold"
        },
        command = [[\mathbb]]
    },
    mcal = {
        context = {
            name = "mathcal",
            dscr = "math calligraphic"
        },
        command = [[\mathcal]]
    },
    mscr = {
        context = {
            name = "mathscr",
            dscr = "math script"
        },
        command = [[\mathscr]]
    },
    mfr = {
        context = {
            name = "mathfrak",
            dscr = "mathfrak"
        },
        command = [[\mathfrak]]
    },
    hat = {
        context = {
            name = "hat",
            dscr = "hat"
        },
        command = [[\hat]]
    },
    bar = {
        context = {
            name = "bar",
            dscr = "bar (overline)"
        },
        command = [[\overline]]
    },
    tild = {
        context = {
            name = "tilde",
            dscr = "tilde"
        },
        command = [[\tilde]],
        opts = {
            priority = 500
        }
    }
}

local single_command_math_snippets = {}
for k, v in pairs(single_command_math_specs) do
    context = vim.tbl_deep_extend("keep", {
        trig = k,
        snippetType = "autosnippet"
    }, v.context)
    opts = vim.tbl_deep_extend("keep", {
        condition = math_mode
    }, v.opts or {})

    new_snippet = s(context, fmta([[<>{<>} <>]], {t(v.command), i(1), i(0)}), opts)

    table.insert(single_command_math_snippets, new_snippet)
end
vim.list_extend(M, single_command_math_snippets)

return M
