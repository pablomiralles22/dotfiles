require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = { "markdown" }
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "cpp",
    "c",
    "lua",
    "toml"
  },
}

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
