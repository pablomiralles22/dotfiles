-------------------- HELPERS -------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-------------------- PLUGINS -------------------------------
require "paq" {
  "savq/paq-nvim";                  -- Let Paq manage itself
  "hoob3rt/lualine.nvim";
  {"junegunn/fzf", run = fn["fzf#install"]};
  "junegunn/fzf.vim";
  "SirVer/ultisnips";
  "preservim/nerdcommenter";
  {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"};
  -- Language suppor, check if I really need them anymore
  -- "lervag/vimtex";
  -- "godlygeek/tabular";
  -- "plasticboy/vim-markdown";
  -- LSP support
  "neovim/nvim-lspconfig";
  "kabouzeid/nvim-lspinstall";
  "nvim-lua/completion-nvim";
  -- Themes
  "morhetz/gruvbox";
  "lourenci/github-colors";
}

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
opt.sidescrolloff = 8               -- Columns of context
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = 2                     -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.wrap = false                    -- Disable line wrapn

-------------------- MAPPINGS -------------------------------
g.mapleader = ' '

-- Remove arrow keys
map('n', '<up>', 'gk')
map('n', '<down>', 'gj')
map('n', '<left>', ':bprevious<CR>')
map('n', '<right>', ':bnext<CR>')
map('i', '<up>', 'nop')
map('i', '<down>', 'nop')
map('i', '<left>', 'nop')
map('i', '<right>', 'nop')

-- Split navigation
map('n', '<C-J>', '<C-W><C-J>')
map('n', '<C-K>', '<C-W><C-K>')
map('n', '<C-L>', '<C-W><C-L>')
map('n', '<C-H>', '<C-W><C-H>')

-- FZF
map('n', '<leader>f', ':Files<cr>')
map('n', '<leader>p', ':GFiles<cr>')
map('n', '<leader>b', ':Buffers<cr>')

