delimeter_snippets = require("custom.lua_snippets.tex.delimeters")
math_commands_snippets = require("custom.lua_snippets.tex.math_commands")
math_snippets = require("custom.lua_snippets.tex.math")

M = {}
vim.list_extend(M, delimeter_snippets)
vim.list_extend(M, math_commands_snippets)
vim.list_extend(M, math_snippets)
return M