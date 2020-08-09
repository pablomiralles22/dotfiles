call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'kien/ctrlp.vim'
Plug 'preservim/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'justinmk/vim-sneak'
Plug 'morhetz/gruvbox'
call plug#end()

" Plugin config "
source $HOME/.config/vim/config/plugin_config/nerdcommenter.vim
source $HOME/.config/vim/config/plugin_config/coc.vim
source $HOME/.config/vim/config/plugin_config/ctrlp.vim
source $HOME/.config/vim/config/plugin_config/netrw.vim
