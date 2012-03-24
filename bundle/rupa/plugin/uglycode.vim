" make ugly code look ugly
" provides functions to highlight tabs, trailing spaces, and long-ass lines

" -----------------------------------------------------------------------------

" simple version

" tabs and trailing spaces
" set listchars=tab:__,trail:_
" set list

" long lines
" highlight tooLong cterm=underline gui=underline
" match tooLong /.\%>81v/

" -----------------------------------------------------------------------------

" de-emphasize invisible characters
highlight NonText ctermfg=brown guifg=brown
highlight SpecialKey ctermfg=brown guifg=brown

" -----------------------------------------------------------------------------

" cycle through highlights for invisible chars
" default: tabs/trailing spaces -> tabs/trailing spaces/eol -> none
" settings:
"     g:mylistchars - list of listchars to cycle through
"     g:NoInvChars  - default higlighting to off
" toggle with :List or <Leader><CR>
if !exists("g:mylistchars")
    if strlen(substitute(strtrans(nr2char(172)), ".", "x", "g")) == 1
        "let s:tab = nr2char(187)
        let s:tab = nr2char(9657)
        let s:tab2 = nr2char(9643)
        let s:trail = nr2char(183)
        let s:eol = nr2char(172)
    else
        let s:tab = "_"
        let s:tab2 = "_"
        let s:trail = "_"
        let s:eol = "$"
    endif
    let g:mylistchars = ["tab:".s:tab.s:tab2.",trail:".s:trail]
    call add(g:mylistchars, "tab:".s:tab.s:tab2.",trail:".s:trail.",eol:".s:eol)
endif
let b:counter = 0
function! s:InvChars()
    if b:counter == len(g:mylistchars)
        set nolist
        let b:counter = 0
    else
        set list
        execute "set listchars=" . g:mylistchars[b:counter % len(g:mylistchars)]
        let b:counter += 1
    endif
endfunction
if !exists("g:NoInvChars")
    call s:InvChars()
endif
command! List call s:InvChars()
nnoremap <silent> <leader><CR> :List<CR>

" -----------------------------------------------------------------------------

" highlight long lines
" settings:
"     g:LongLineLength  - max  length (default 79)
"     g:LongLineOff - default highlighting to off
"     g:LongLineExclude - exclude by filetype (default ['', 'text'])
" toggle with :Long or <Leader>l
highlight tooLong cterm=underline gui=underline
if !exists("g:LongLineLength")
   let g:LongLineLength = 79
endif
if !exists("g:LongLineExclude")
   let g:LongLineExclude = ['', 'text']
endif
function! s:LongLines()
    if exists("b:longlines")
        call matchdelete(b:longlines)
        unlet b:longlines
    else
        let b:longlines =
            \ matchadd('tooLong', '.\%>'.(g:LongLineLength+1).'v', -1)
    endif
endfunction
if !exists("g:LongLineOff")
    if has("autocmd")
        au BufNewFile,BufRead * if index(g:LongLineExclude, &ft) == -1
            \ | call s:LongLines() | endif
    else
        call s:LongLines()
    endif
endif
command! Long call s:LongLines()
nnoremap <silent> <leader>l :Long<CR>

" vim:fileencoding=utf-8
