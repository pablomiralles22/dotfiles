local options = require("plugins.configs.cmp")
local cmp = require "cmp"


-- Disable cmp for tabs
options.mapping["<Tab>"] = cmp.mapping(function(fallback)
      if require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s", })

options.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
      if require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s", })

return options
