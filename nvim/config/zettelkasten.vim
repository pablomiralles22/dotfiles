" Use ugrep for file search, it allows boolean search
if executable('ugrep')
    set grepprg=ugrep\ -RInk\ -j\ -u\ --tabs=1\ --ignore-files
    set grepformat=%f:%l:%c:%m,%f+%l+%c+%m,%-G%f\\\|%l\\\|%c\\\|%m
endif

" set image directory
:command! Imgpaste :call mdip#MarkdownClipboardImage()
let g:mdip_imgdir = 'media'

" follow link (has to be on top of id, excluding [[]])
set wildcharm=<tab> " for completion
nmap <leader>zl :e <c-r>=expand("<cword>")<cr><tab><CR>

" get backlinks to this file in quickfix
nmap <leader>zbl :grep! "\[\[<c-r>=matchstr(expand('%:t:r'),'^.\{-}\ze ')<cr>\]\]"<CR><CR>

" copy link from current file in '[[id]] title' format
nmap <leader>zcl :let @"="\[\[<c-r>=matchstr(expand('%:t:r'),'^.\{-}\ze ')<cr>\]\]<c-r>=matchstr(expand('%:t:r'),' .\{}$')<cr>"<CR><CR>

" start search (results in quickfix)
nmap <leader>zs :grep! --bool "

" create new zettel
nmap <leader>zn :e <c-r>=strftime("%Y%m%d%H%M%S")<cr> 

" access today's daily note
let journal_path = "journal/"
nmap <leader>zj :e <C-R>=journal_path<CR><C-R>=strftime("%Y-%m-%d")<CR>.md<CR>

