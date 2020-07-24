" Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'majutsushi/tagbar'
Plugin 'craigemery/vim-autotag'
Plugin 'lervag/vimtex'
Plugin 'preservim/nerdtree'
Plugin 'beyondmarc/glsl.vim'
" Plugin 'mingchaoyan/vim-shaderlab'
Plugin 'ervandew/supertab'

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

" filetype plugin on
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
set ttymouse=
 
imap {<CR> {<CR>a<BACKSPACE><CR>}<UP><END>

set nowrap
set foldmethod=indent

" F1 keys bindings
nnoremap <F5> :!echo --------------------; make<CR>
nnoremap <F6> :!echo --------------------; make run<CR>
nnoremap <F7> :!echo --------------------; make debug<CR>
nnoremap <silent> <F2> :TagbarOpenAutoClose<CR>
map <silent> <F3> :e .<CR>
map <silent> <F4> :nohl<CR>

" autocomplete
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n"
let g:SuperTabClosePreviewOnPopupClose=1
set completeopt=menu,menuone,preview ",noselect
set complete-=i
