local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },
  {
    "hrsh7th/nvim-cmp",
    opts=function()
      return require "custom.configs.cmp_override"
    end
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_assume_mapped = true
    end,
  },

  {
    "rafamadriz/friendly-snippets",
    enabled = false,
  },

  {
    "lervag/vimtex",
    ft={"plaintex", "tex", "latex"},
    config = function()
      require("custom.configs.vimtex")
    end
  },
  {
    "L3MON4D3/LuaSnip",
    opts = { history = true, updateevents = "TextChanged,TextChangedI", enable_autosnippets = true },
    config = function(_, opts)
      require("plugins.configs.others").luasnip(opts)
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = {"markdown", "pandoc"},
    run = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "preservim/vim-markdown",
    ft = {"markdown", "pandoc"},
    config = function()
      require("custom.configs.vim-markdown")
    end
  },
  {
    "mickael-menu/zk-nvim",
    ft = {"markdown", "pandoc"},
    config = function()
      require("custom.configs.zk-nvim")
    end
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
