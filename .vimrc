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
set ignorecase

set undodir=~/.vim/undodir
set undofile

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz


set mouse=
" set ttymouse=
 
imap {<CR> {<CR>a<BACKSPACE><CR>}<UP><END>
nnoremap ^] <Nop>

set nowrap
set foldmethod=syntax
function! MyFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=MyFoldText()
hi Folded ctermbg=black

" F1 keys bindings
nnoremap <F5> :!echo --------------------; make -j<CR>
nnoremap <F6> :!echo --------------------; make -j run<CR>
nnoremap <F7> :!echo --------------------; make -j debug<CR>
nnoremap <silent> <F2> :TagbarOpenAutoClose<CR>
map <silent> <F3> :e .<CR>
map <silent> <F4> :nohl<CR>

" autocomplete
" :inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
" let g:SuperTabDefaultCompletionType = "<c-n>"
" let g:SuperTabContextDefaultCompletionType = "<c-n"
" let g:SuperTabClosePreviewOnPopupClose=1
" set completeopt=menu,menuone,preview ",noselect
" set complete-=i

let g:ycm_show_diagnostics_ui = 0
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
" python3 ~/.vim/bundle/YouCompleteMe/install.py --clang-completer

" vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
" set conceallevel=2
" let g:tex_conceal="abdgm"
hi clear Conceal

" UltiSnips
inoremap <c-n> <Nop>
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
