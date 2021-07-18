"""" Theme
" colorscheme gruvbox
" hi MatchParen ctermfg=none ctermbg=red cterm=bold

set guicursor=a:block-blinkon0

" General Settings "
set encoding=UTF-8
filetype plugin indent on
syntax on
set autoread wildmode=longest,list,full
set backspace=indent,eol,start 
set confirm
set shiftwidth=4
set autoindent 
set smartindent 
set tabstop=4 
set softtabstop=4
set expandtab  
set hls 
set is 
set ic
set laststatus=2 
set cmdheight=1
set splitbelow 
set splitright 
set nobackup 
set nowritebackup
set number relativenumber
set signcolumn=no
set cursorline
" set clipboard=unnamedplus
set nohlsearch
set updatetime=300
set timeoutlen=300
set mouse=a
set scrolloff=10
" set nolazyredraw
" set colorcolumn=80
set nocompatible


autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

source $HOME/.config/nvim/mappings.vim
source $HOME/.config/nvim/plug.vim
