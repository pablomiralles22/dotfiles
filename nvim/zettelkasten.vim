" Use ugrep for file search, it allows boolean search
if executable('ugrep')
    set grepprg=ugrep\ -RInk\ -j\ -u\ --tabs=1\ --ignore-files
    set grepformat=%f:%l:%c:%m,%f+%l+%c+%m,%-G%f\\\|%l\\\|%c\\\|%m
endif

function! UgrepFzf(query, fullscreen)
  let command_fmt = 'ugrep -R --bool --column-number --line-number --color=always --smart-case %s . || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Zksearch call UgrepFzf(<q-args>, <bang>0)

nmap <leader>zks :Zksearch<CR>

" set image directory
" :command! Imgpaste :call mdip#MarkdownClipboardImage()
" let g:mdip_imgdir = 'media'

" follow link (has to be on top of id, excluding [[]])
set wildcharm=<tab> " for completion
nmap <leader>zl :e <c-r>=expand("<cword>")<cr><tab><CR>




" get backlinks to this file in quickfix
function! GetBacklinks()
  call grep! "\[\[<c-r>=matchstr(expand('%:t:r'),'^.\{-}\ze ')<cr>\]\]"<CR><CR>
  call copen
endfunction

command! -bang Zkbacklinks call GetBacklinks()

nmap <leader>zbl :Zkbacklinks<CR>




" copy link from current file in '[[id]] title' format
nmap <leader>zcl :let @"="\[\[<c-r>=matchstr(expand('%:t:r'),'^.\{-}\ze ')<cr>\]\]<c-r>=matchstr(expand('%:t:r'),' .\{}$')<cr>"<CR><CR>




" create new zettel
nmap <leader>zn :e <c-r>=strftime("%Y%m%d%H%M%S")<cr>




" access today's daily note
let journal_path = "journal/"
command! -bang Zkdailynote call e <C-R>=journal_path<CR><C-R>=strftime("%Y-%m-%d")<CR>.md<CR>
nmap <leader>zj :Zkdailynote<CR>




