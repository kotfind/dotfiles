" Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'majutsushi/tagbar'

Plugin 'craigemery/vim-autotag'

Plugin 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0
    set conceallevel=2
    let g:tex_conceal='abdmg'
    hi Conceal ctermbg=none
    " hi clear Conceal

Plugin 'preservim/nerdtree'

Plugin 'SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger = "<c-l>"
    let g:UltiSnipsJumpForwardTrigger = "<c-j>"
    let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

Plugin 'vim-scripts/dbext.vim'
Plugin 'alvan/vim-closetag'
Plugin 'lepture/vim-jinja'
    let g:closetag_filetypes = 'html,jinja'

call vundle#end()
filetype plugin indent on

set encoding=utf8
set fileencoding=utf8

set number
set relativenumber

set bs=indent,eol,start

set showcmd
set ruler
set cursorline

set title
set confirm

set t_Co=256
set background=dark

syntax on

set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set ai
set cin

set showmatch
set hlsearch
set incsearch 
set ignorecase

set undodir=~/.vim/undodir
set undofile

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

set mouse=
" set ttymouse=

set nowrap
set foldmethod=syntax
function MyFoldText()
    let foldchar = '.'
    let line = substitute(getline(v:foldstart), '^\s*', '', 'g')
    let lines_cnt = v:foldend - v:foldstart + 1
    let cnt_text = '| ' . printf('%4s', lines_cnt) . ' |'
    let text_start = repeat(foldchar, (v:foldlevel - 1) * 4) . line
    let text_end = cnt_text . repeat(foldchar, 4)
    let len = strlen(text_start . text_end) + 4
    return text_start . repeat(foldchar, winwidth(0) - len) . text_end
endfunction
set foldtext=MyFoldText()
hi Folded ctermbg=black

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 

" Command Line Mode Autocompletion
set wildmenu
set wildmode=longest:full,full

" Mappings
nnoremap <F5> :!make -j4<CR>
nnoremap <F6> :!make -j4 run<CR>
nnoremap <F7> :!make -j4 debug<CR>
nnoremap <F8> :!TMP=$(mktemp) && g++ % -Wall -Wextra -Wpedantic -o $TMP && $TMP && rm $TMP <CR>
nnoremap <silent> <F2> :TagbarOpenAutoClose<CR>
noremap <silent> <F3> :e .<CR>
map <silent> <F4> :nohl<CR>

inoremap {<CR> {<CR>}<Esc>O
inoremap {; {<CR>};<Esc>O

inoremap jk <ESC>
inoremap Jk <ESC>
inoremap jK <ESC>
inoremap JK <ESC>

noremap gp "+p
noremap gP "+P
noremap gy "+y
noremap gY "+Y

noremap Q @@

noremap gwh <C-w>h
noremap gwj <C-w>j
noremap gwk <C-w>k
noremap gwl <C-w>l
