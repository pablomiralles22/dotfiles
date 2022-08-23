-------------------- HELPERS -------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-------------------- PLUGINS -------------------------------
require("packer").startup(function()
  use 'wbthomason/packer.nvim'
  use "hoob3rt/lualine.nvim"
  use {"junegunn/fzf", run = function() fn["fzf#install"](0) end}
  use "junegunn/fzf.vim"
  use "SirVer/ultisnips"
  use "preservim/nerdcommenter"
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
  use "lervag/vimtex"

  use "plasticboy/vim-markdown"
  use "mickael-menu/zk-nvim"
  -- use "Furkanzmc/zettelkasten.nvim"
  -- use "chiefnoah/neuron-v2.vim"
  use "ferrine/md-img-paste.vim"
  use "itspriddle/vim-marked"
  -- LSP support
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "quangnguyen30192/cmp-nvim-ultisnips",
    }
  }
  -- Themes
  use "morhetz/gruvbox"
  use "lourenci/github-colors"
  use "chriskempson/base16-vim"
end)

-- Ultisnips
g.UltiSnipsExpandTrigger = "<tab>"
g.UltiSnipsJumpForwardTrigger = '<tab>'
g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
g.UltiSnipsSnippetDirectories = {"UltiSnips"}

-------------------- OPTIONS -------------------------------
cmd 'colorscheme gruvbox'           -- Put your favorite colorscheme here
opt.background = 'dark'
cmd 'filetype plugin indent on'
cmd 'syntax on'
opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options (for deoplete)
opt.expandtab = true                -- Use spaces instead of tabs
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = true               -- Ignore case
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.listchars = 'trail:·'
opt.number = true                   -- Show line numbers
opt.relativenumber = true           -- Relative line numbers
opt.scrolloff = 4                   -- Lines of context
opt.shiftround = true               -- Roud indent
opt.shiftwidth = 2                  -- Size of an indent
opt.sidescrolloff = 0               -- Columns of context
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = 2                     -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.wrap = false                    -- Disable line wrapn



-------------------- AUTOCMD -------------------------------

-- vim.api.nvim_command([[
--   augroup PlainTextWidth
--   autocmd BufRead,BufNewFile *.txt,*.tex set textwidth=80 " Autowrap text files
--   augroup END
-- ]])


-------------------- MAPPINGS -------------------------------
g.mapleader = ' '

-- Remove arrow keys
map('n', '<up>', 'gk')
map('n', '<down>', 'gj')
map('n', '<left>', ':bprevious<CR>')
map('n', '<right>', ':bnext<CR>')
map('i', '<up>', '')
map('i', '<down>', '')
map('i', '<left>', '')
map('i', '<right>', '')

-- Split navigation
map('n', '<C-J>', '<C-W><C-J>')
map('n', '<C-K>', '<C-W><C-K>')
map('n', '<C-L>', '<C-W><C-L>')
map('n', '<C-H>', '<C-W><C-H>')

-- FZF
map('n', '<leader>ff', ':Files<cr>')
map('n', '<leader>fg', ':GFiles<cr>')
map('n', '<leader>fc', ':Ag<cr>')
map('n', '<leader>fb', ':Buffers<cr>')

map('n', '<leader>i', ":let @z=input('enter text: ') <bar> norm \"zp<CR>")

