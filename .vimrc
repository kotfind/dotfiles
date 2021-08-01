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
" Plugin 'ervandew/supertab'
" Plugin 'honza/vim-snippets'
Plugin 'SirVer/ultisnips'
Plugin 'ycm-core/YouCompleteMe'

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

filetype plugin on
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

" Mappings
nnoremap <F5> make -j4<CR>
nnoremap <F6> make -j4 run<CR>
nnoremap <F7> make -j4 debug<CR>
nnoremap <silent> <F2> :TagbarOpenAutoClose<CR>
noremap <silent> <F3> :e .<CR>
map <silent> <F4> :nohl<CR>

inoremap {<CR> {<CR>a<BACKSPACE><CR>}<UP><END>
nnoremap ^] <Nop>

inoremap jk <ESC>
noremap gp "+p
noremap gP "+P
noremap gy "+y
noremap gY "+Y

" YCM
let g:ycm_show_diagnostics_ui = 0
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion=1
" python3 ~/.vim/bundle/YouCompleteMe/install.py --clang-completer

" vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
hi clear Conceal

" UltiSnips
inoremap <c-n> <Nop>
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
