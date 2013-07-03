" try to prevent writing a trailing eol
set binary
set noeol

" unfold
nnoremap <unique><leader>X :s/\~/\~\r/<CR>1G
" fold
nnoremap <unique><leader>Z 1GvG:j!<CR>
