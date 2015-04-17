syntax on
"filetype plugin indent on

" Send more characters for redraws
set ttyfast

" Enable mouse use in all modes
set mouse=a

" When pressing tab, insert 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

set number

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Highlight trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

set list listchars=tab:»\ ,trail:·

" Move tabs with alt + left|right
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" Set tab label to show tab number, filename, if modified ('+' is shown if the current window in the tab has been modified)
set guitablabel=%N/\ %t\ %M

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


au BufNewFile,BufRead *.rs set filetype=rust
