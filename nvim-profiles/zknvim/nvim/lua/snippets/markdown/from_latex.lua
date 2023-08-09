delimeter_snippets = require("snippets.tex.delimeters")
math_commands_snippets = require("snippets.tex.math_commands")
math_snippets = require("snippets.tex.math")

M = {}
vim.list_extend(M, delimeter_snippets)
vim.list_extend(M, math_commands_snippets)
vim.list_extend(M, math_snippets)
return M