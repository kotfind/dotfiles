"Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'ycm-core/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'craigemery/vim-autotag'
Plugin 'octol/vim-cpp-enhanced-highlight'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Put your non-Plugin stuff after this line
nnoremap <silent> <F2> :TagbarOpenAutoClose<CR>
map <silent> <F3> :e .<CR>
map <silent> <F4> :nohl<CR>
let g:netrw_banner = 0
let g:netrw_keepdir = 0

set encoding=utf8

set number " нумерация строк

set bs=indent,eol,start " backspace без глюков

set nowrap " включаем перенос строк
set linebreak " перенос по словам, а не по буквам

set showcmd " просмотр выполняемой команды в правом нижнем углу

set ruler " показывать строку с позицией курсора

filetype plugin on
syntax on " подсветка синтаксиса

set tabstop=4 "    |
set shiftwidth=4 " | кол-во символов пробелов, которые будут заменять \t
set smarttab "     |
"set et " автозамена по умолчанию

set ai " автоотступы для новых строк
"set cin " отступы в стиле Си

set showmatch "  |
set hlsearch "   | поиск и подсветка результатов поиска и совпадения скобок
set incsearch "  |
set ignorecase " |

"set listchars=tab:·· " | табы в начале строки точками
"set list "             |

set title " показывать имя буфера в заголовке терминала
set confirm " использовать диалоги вместо сообщения о ошибках

set t_Co=256 " использовать больше цветов в терминале
set background=dark

set cursorline " подсветка текущей строки

set autoread " автоматическое перечитывание файла при изменении

set foldmethod=syntax " фолдинг (сворачивание блоков кода) (zc - свернуть, zo - развернуть)

autocmd BufWinLeave *.* mkview          " | запоминание фолдинга
autocmd BufWinEnter *.* silent loadview " |

"" автозакрывание скобок
"imap [] []<LEFT>
"imap () ()<LEFT>
"imap {} {}<LEFT><ENTER><UP><RIGHT><ENTER>
imap {}<CR> {}<LEFT><CR><CR><UP><TAB>
""  <UP><ENTER><ENTER>
"inoremap "" ""<LEFT>
"inoremap '' ''<LEFT>
"inoremap <> <><LEFT>
""inoremap <SPACE><SPACE> <SPACE><SPACE><LEFT>

inoremap <C-k> <C-o>gk
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <C-o>gj

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
