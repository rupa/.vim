" rupa's vimrc

" pathogen
filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

set nocompatible
set novisualbell
set backspace=indent,eol,start
set history=1000
set ruler
set showcmd
set shiftwidth=1
set tabstop=4
set softtabstop=4
set expandtab
set noshowmatch
set incsearch
set whichwrap=h,l,~,[,],<,>
set title
set shortmess=aoOtTI
set clipboard=unnamed
set nobackup
set hidden
set ignorecase
set smartcase
set wildmenu
set wildmode=list:longest
set autoindent
set encoding=utf8
"set mouse=a
set scrolloff=2
set ttyfast
set gdefault
set listchars=tab:▸\ ,eol:¬
set nojoinspaces

" nice mapping for normal mode
inoremap jj <ESC>

" make Y like C/D
nnoremap Y y$

" more intuitive j/k
nnoremap j gj
nnoremap k gk

" hardcore mode
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" prevent screen clearing
set t_ti= t_te=

" use normal regexes. see :help /\v
nnoremap / /\v
vnoremap / /\v

" toggle invisible chars
nnoremap <silent> <leader>l :set list!<CR>

" toggle line numbers/cursorline
nnoremap <silent> <Leader><Leader> :set nu!<CR> :set cursorline!<CR>

" strip trailing whitespace from file
nnoremap <silent> <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" re-hardwap paragraphs of text
nnoremap <leader>q gqap
" unwrap paragraphs of text
nnoremap <leader>u vipJjjj

" execute file being edited
noremap <buffer> <Leader>pl :!/usr/bin/perl % <CR>
noremap <buffer> <Leader>py :!/usr/bin/env python % <CR>
noremap <buffer> <Leader>sh :!/bin/bash % <CR>

" colors
if has("gui_running") || &t_Co > 2
 set background=dark
 syntax enable
 try
  colorscheme desert256
 catch
  colorscheme koehler
 endtry
endif

if has("autocmd")

 " makefiles need literal tabs
 autocmd FileType make set noexpandtab

 " When editing a file, always jump to the last cursor position
 autocmd BufReadPost *
 \ if line("'\"") > 0 && line ("'\"") <= line("$") |
 \   exe "normal g'\"" |
 \ endif

 " gvim lulz gvim only
 if has("gui_running")
  autocmd FocusGained * syntax on
  autocmd FocusLost * syntax off
 endif

 " change terminal size for local terminals
 " cause i tend to like vim terminals to be longer than other ones
 if $SSH_TTY == "" && $VIM_RESIZE != ""
  set co=80 lines=45
  autocmd VimLeave * set co=80 lines=25
 endif

 " get completions from current syntax file
 au BufEnter * exec('setlocal complete+=k$VIMRUNTIME/syntax/'.&ft.'.vim')
 set iskeyword+=-,:

endif

" stuff for plugins
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
