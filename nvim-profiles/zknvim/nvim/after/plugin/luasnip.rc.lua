ls = require("luasnip")

local snippets_folder = vim.fn.stdpath "config" .. "/lua/snippets/"
ls.setup {
	enable_autosnippets = true,
    update_events = {"TextChanged", "TextChangedI"},
	history = true,
    require("luasnip.loaders.from_lua").lazy_load { paths = snippets_folder }
}