-- local autocmd = vim.api.nvim_create_autocmd
vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/custom/lua_snippets"

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
