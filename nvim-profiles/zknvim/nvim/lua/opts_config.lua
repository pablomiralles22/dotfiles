vim.cmd 'filetype plugin indent on'
vim.cmd 'syntax on'
vim.opt.expandtab = true                -- Use spaces instead of tabs
vim.opt.hidden = true                   -- Enable background buffers
vim.opt.ignorecase = true               -- Ignore case
vim.opt.joinspaces = false              -- No double spaces with join
vim.opt.list = true                     -- Show some invisible characters
vim.opt.listchars = 'trail:·'
vim.opt.number = true                   -- Show line numbers
vim.opt.relativenumber = true           -- Relative line numbers
vim.opt.scrolloff = 4                   -- Lines of context
vim.opt.shiftround = true               -- Roud indent
vim.opt.shiftwidth = 2                  -- Size of an indent
vim.opt.sidescrolloff = 0               -- Columns of context
vim.opt.smartcase = true                -- Do not ignore case with capitals
vim.opt.smartindent = true              -- Insert indents automatically
vim.opt.splitbelow = true               -- Put new windows below current
vim.opt.splitright = true               -- Put new windows right of current
vim.opt.tabstop = 2                     -- Number of spaces tabs count for
vim.opt.termguicolors = true            -- True color support
vim.opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
vim.opt.wrap = false                    -- Disable line wrapn
vim.opt.textwidth=80
vim.opt.colorcolumn="81"
vim.cmd "highlight ColorColumn guibg=White"
vim.cmd "set whichwrap+=<,>,h,l"

vim.opt.background = 'dark'
vim.cmd 'colorscheme nord'           -- Put your favorite colorscheme here