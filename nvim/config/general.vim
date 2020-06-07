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
set clipboard=unnamedplus
" set updatetime=300
" set timeoutlen=100
set mouse=a

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Status-line "
set statusline=
set statusline+=%#IncSearch#
set statusline+=\ %y
set statusline+=\ %r
set statusline+=%#CursorLineNr#
set statusline+=\ %F
set statusline+=%= "Right side settings
set statusline+=%#Search#
set statusline+=\ %l/%L
set statusline+=\ [%c]
