set wrap linebreak nolist
set tabstop=4
set shiftwidth=4
set textwidth=80
set spell

" nnoremap j gj
" nnoremap k gk
nnoremap <leader>imp :call mdip#MarkdownClipboardImage()<CR>

" PENCIL PLUGIN config
let g:pencil#autoformat = 1
let g:pencil#wrapModeDefault = 'hard'
call pencil#init({'wrap': 'hard'})
