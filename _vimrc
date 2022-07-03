call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'



" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" HTML
Plug 'alvan/vim-closetag' " Automatic tag closing
Plug 'mattn/emmet-vim' " Emmet, fast HTML inserting

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Initialize plugin system
call plug#end()


" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

if has("gui_running")
    set lines=60 columns=100
endif

" air-line
let g:airline_theme='selenized'
" Включить/выключить интеграцию со сторонними плагинами:
let g:airline_enable_fugitive=1
let g:airline_enable_syntastic=1
let g:airline_enable_bufferline=1

" Замена символов:
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_linecolumn_prefix = '¶ '
let g:airline_fugitive_prefix = '⎇ '
let g:airline_paste_symbol = 'ρ'

" Замена отдельных секций:
let g:airline_section_c = '%t'

" запуск команд в posh
set shell=pwsh

"Табуляция и пробелы
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Нумерация строк и отступ
set number
set foldcolumn=2

"Цветовая схема
colorscheme torte  

syntax on

" Без звука
set noerrorbells
set novisualbell

" Мышь
set mouse=a

" Поиск
set ignorecase
set smartcase
set hlsearch
set incsearch

"Кодировка
set encoding=utf8

" шрифт
set guifont=Hack_NF:h11:cRUSSIAN:qDRAFT

" Не сохранять резервные копии и временные файлы
set nobackup
set nowritebackup
set noswapfile
set noundofile

"язык проверки правописания
set spell spelllang=ru_ru,en_us

"highligth
hi clear SpellBad
hi SpellBad cterm=underline
hi SpellBad ctermfg=167 ctermbg=235
hi SpellBad gui=underline
hi SpellBad guifg=#282828 guibg=#fb4944
