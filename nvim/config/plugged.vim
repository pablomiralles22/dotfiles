call plug#begin('~/.config/nvim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'kien/ctrlp.vim'
Plug 'preservim/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'justinmk/vim-sneak'
call plug#end()

" Plugin config "
source $HOME/.config/nvim/config/plugin_config/nerdcommenter.vim
source $HOME/.config/nvim/config/plugin_config/coc.vim
source $HOME/.config/nvim/config/plugin_config/ctrlp.vim
source $HOME/.config/nvim/config/plugin_config/netrw.vim
