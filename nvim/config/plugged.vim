call plug#begin('~/.config/nvim/plugged')
Plug 'itchyny/lightline.vim'
" Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'justinmk/vim-sneak'
Plug 'morhetz/gruvbox'
call plug#end()

" Plugin config "
source $HOME/.config/nvim/config/plugin_config/nerdcommenter.vim
source $HOME/.config/nvim/config/plugin_config/coc.vim
source $HOME/.config/nvim/config/plugin_config/netrw.vim
