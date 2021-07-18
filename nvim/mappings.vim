nmap <Space> <Leader>

" Remove arrow keys"
nmap <up> gk
nmap <down> gj
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

" Coc.vim "
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

" FZF "
nmap <leader>f :Files<cr>
nmap <leader>p :GFiles<cr>
nmap <leader>b :Buffers<cr>

