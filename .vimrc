autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set number

" Move tabs with alt + left|right
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" Set tab label to show tab number, filename, if modified ('+' is shown if the current window in the tab has been modified)
:set guitablabel=%N/\ %t\ %M

" Center screen on next/previous selection.
nnoremap n nzz
nnoremap N Nzz
" Last and next jump should center too.
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz


set laststatus=2
hi User1 ctermbg=black ctermfg=white guibg=black  guifg=white
set statusline=
set statusline +=%1*\ %<%F%*            "full path
set statusline +=%1*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%1*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%1*0x%04B\ %*          "character under cursor
