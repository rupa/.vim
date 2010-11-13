" try to get omnicompletion closer to tab
if version < 700
    finish
endif

set completeopt+=longest,menuone
" close window on cursor movement or esc
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" FFFFFFFFFF
function! CTab()
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        return "\<Tab>"
    elseif exists('&omnifunc') && &omnifunc != ''
        return "\<C-X>\<C-O>"
    else
        return "\<C-N>"
    endif
endfunction

" select next match
inoremap <silent><expr><unique><leader><Tab> pumvisible() ? "\<C-N>" : CTab()
