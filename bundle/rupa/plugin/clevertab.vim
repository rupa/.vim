if version >= 700

 set completeopt+=longest,menuone
 autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
 autocmd InsertLeave * if pumvisible() == 0|pclose|endif

 " FFFFFFFFFF
 function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
     return "\<Tab>"
   elseif exists('&omnifunc') && &omnifunc != ''
     return "\<C-X>\<C-O>"
   else
     return "\<C-N>"
   endif
 endfunction
 " messes up esc
 " inoremap <expr> <Esc> pumvisible() ? "\<C-E>" : "\<Esc>"
 inoremap <silent><expr> <Tab> pumvisible() ? "\<C-N>" : CleverTab()
 inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"
 inoremap <silent><expr> <CR> pumvisible() ? "\<C-Y>" : "\<C-G>u\<CR>"

endif
