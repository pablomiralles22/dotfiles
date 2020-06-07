nmap <Space> <Leader>

" Remove arrow keys"
nmap <up> <nop>
nmap <down> <nop>
nmap <left> :bprevious<CR>
nmap <right> :bnext<CR>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Split navigation "
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" for scaping without scape"
inoremap jk <Esc>
inoremap kj <Esc>

" Coc.vim "
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)


" CtrlP "
nmap <leader>p :CtrlP<cr>
nmap <leader>b :CtrlPBuffer<cr>

