" make ugly code look ugly

" de-emphasize invisible characters
highlight NonText ctermfg=brown guifg=brown
highlight SpecialKey ctermfg=brown guifg=brown

" highlight literal tabs and trailing spaces
highlight Hlt ctermfg=brown cterm=underline guifg=brown gui=underline
function! s:ToggleTabHl()
    if exists("b:hltab") && b:hltab
        match none
        let b:hltab = 0
    else
        match Hlt /\t\|\s\+$/
        let b:hltab = 1
    endif
endfunction
command! HlTab call s:ToggleTabHl()
call s:ToggleTabHl()

" underline >80
highlight rightMargin cterm=underline gui=underline
function! s:ToggleRMargin()
    if exists("b:hlrmargin") && b:hlrmargin
        2match none
        let b:hlrmargin = 0
    else
        2match rightMargin /.\%>81v/
        let b:hlrmargin = 1
    endif
endfunction
command! Hl80 call s:ToggleRMargin()
call s:ToggleRMargin()
