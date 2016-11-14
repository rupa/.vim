" rupa's vimrc

" pathogen
filetype off
call pathogen#infect()
call pathogen#helptags()
"filetype plugin indent on
filetype plugin on

set nocompatible
set novisualbell
set backspace=indent,eol,start
set history=1000
set ruler
set showcmd
set shiftwidth=4
" useless if sw=1
set smarttab
set tabstop=4
set softtabstop=4
set expandtab
set noshowmatch
set incsearch
set whichwrap=h,l,~,[,],<,>
set notitle
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
set nojoinspaces
set modeline
"set relativenumber
"set number
set cryptmethod=blowfish

" I keep typing :Wq
"com Wq wq

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

" tabs and trailing spaces
set listchars=tab:__,trail:_
set list

let term=$TERM
if term == 'xterm-256color-italic'
    highlight Comment gui=italic
    highlight Comment cterm=italic
    highlight htmlArg gui=italic
    highlight htmlArg cterm=italic
endif

" long lines
"highlight rightMargin cterm=underline gui=underline
"match rightMargin /\%>79v.\+/

" nice mapping for devices without easy <ESC>
"inoremap jj <ESC>

" make Y like C/D
nnoremap Y y$

" more intuitive j/k
nnoremap j gj
nnoremap k gk

" sudo write
cmap w!! w !sudo tee > /dev/null %

" put cursor at start of command when repeating
" breaks with vim-flake8
"nmap . .`[

" hardcore mode
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" use normal regexes. see :help /\v
nnoremap / /\v
vnoremap / /\v

" toggle line numbers
nnoremap <silent> <Leader>n :set nu!<CR>

" strip trailing whitespace from file
nnoremap <silent> <leader>W :%s/\s\+$//<CR>:let @/=''<CR>

" re-hardwap paragraphs of text
nnoremap <leader>q gqap
" unwrap paragraphs of text
nnoremap <leader>u vipJjjj

" execute file being edited
noremap <buffer> <Leader>pl :!/usr/bin/perl % <CR>
noremap <buffer> <Leader>py :!/usr/bin/env python % <CR>
noremap <buffer> <Leader>sh :!/bin/bash % <CR>

" brief crosshairs on the cursor
function! CursorPing()
    set cursorline cursorcolumn
    redraw
    sleep 50m
    set nocursorline nocursorcolumn
endfunction
nmap <Leader><Leader> :call CursorPing()<CR>

" prevent screen clearing
set t_ti= t_te=

" gui options
if has("gui_running")
    set guioptions=aegiLt
    if has("win32")
        set guifont=Consolas:h10
    else
        set guifont=Source\ Code\ Pro:h12
    endif
endif

if has("autocmd")

    au BufEnter /tmp/crontab.* setl backupcopy=yes

    "autocmd InsertEnter * hi Normal ctermfg=251 ctermbg=DarkGray guifg=#cccccc guibg=#111111
    "autocmd InsertLeave * hi Normal ctermfg=251 ctermbg=Black guifg=#cccccc guibg=#000000

    " makefiles need literal tabs
    autocmd FileType make setlocal noexpandtab

    " epub files are zip files
    au BufReadCmd *.epub call zip#Browse(expand("<amatch>"))
    " xlsx files are zip files
    au BufReadCmd *.xlsx call zip#Browse(expand("<amatch>"))

    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal g'\"" |
    \ endif

    " get completions from current syntax file
    au BufEnter * exec('setlocal complete+=k$VIMRUNTIME/syntax/'.&ft.'.vim')
    set iskeyword+=-,:

    " change terminal size for local terminals
    " cause i tend to like vim terminals to be longer than other ones
    "if $SSH_TTY == "" && $VIM_RESIZE != ""
    "    set co=80 lines=35
    "    if $VIM_RESIZE > 1
    "        autocmd VimLeave * set co=80 lines=25
    "    endif
    "endif

    if has("gui_running")
        " lulz
        autocmd FocusGained * syntax on
        autocmd FocusLost * syntax off
    endif

    " python completion
    au FileType python set omnifunc=pythoncomplete#Complete

endif

" Add the virtualenv's site-packages to vim path
if has("python")
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif

if !exists("DiffOrig")
    command DiffOrig vert new |
    \ set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %

" stuff for plugins
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"let g:UltiSnipsListSnippets="<c-tab>"

let g:SuperTabDefaultCompletionType="context"

" fix CSApprox complaining about lame terminals
if &t_Co < 88 || !has("gui")
    let g:CSApprox_verbose_level = 0
    let g:CSApprox_loaded = 1
endif

let g:khuno_ignore="E302,E121,E261"
nmap <silent><Leader>x <Esc>:Khuno show<CR>

let at_vistar=$AT_VISTAR
if at_vistar == '1'
    set shiftwidth=2
    set tabstop=2
    set softtabstop=2
    let g:khuno_ignore="E111,E114,E121,E127,E128,E221,E225,E241,E251"
endif
