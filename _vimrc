" Инициализация менеджера плагинов vim-plug
call plug#begin()

" Плагины
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " Дерево файловой системы
Plug 'alvan/vim-closetag', { 'on': ['BufRead', 'BufNewFile'] } " Автоматическое закрытие тегов HTML
Plug 'mattn/emmet-vim', { 'on': ['BufRead', 'BufNewFile'] } " Быстрое вставление HTML с помощью Emmet
Plug 'vim-airline/vim-airline' " Статусная линия Airline
Plug 'vim-airline/vim-airline-themes' " Темы для Airline
Plug 'tpope/vim-fugitive' " Интеграция с Git
Plug 'tpope/vim-surround' " Работа с окружениями (скобки, кавычки и т.д.)
Plug 'tpope/vim-commentary' " Быстрое комментирование кода
Plug 'terryma/vim-multiple-cursors' " Поддержка нескольких курсоров

" Завершение инициализации плагинов
call plug#end()

" Проверка и установка vim-plug, если он не установлен
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Настройка внутреннего diff, если доступен
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

" Настройки интерфейса для GUI версии Vim
if has("gui_running")
    set lines=60 columns=100
endif

" Настройки курсора для различных режимов
if &term =~ 'xterm\\|rxvt'
  let &t_SI = "\e[5 q" " Курсор в виде блока в режиме вставки
  let &t_SR = "\e[4 q" " Курсор в виде блока в режиме замены
  let &t_EI = "\e[1 q" " Стандартный курсор в обычном режиме
endif
let &t_EI .= "\e[2 q" " Курсор в виде блока в нормальном режиме

" Настройки Airline
let g:airline_theme = 'powerlineish' " Тема для Airline
let g:airline_enable_fugitive = 1 " Интеграция с Git
let g:airline_enable_syntastic = 1 " Интеграция с Syntastic
let g:airline_enable_bufferline = 1 " Включить буферную линию
let g:airline#extensions#tabline#enabled = 1 " Включить таб-линию
let g:airline#extensions#tabline#formatter = 'unique_tail' " Формат таб-линии
let g:airline_left_sep = '' " Отключить левый разделитель
let g:airline_right_sep = '' " Отключить правый разделитель
let g:airline_linecolumn_prefix = '¶ ' " Префикс для строки и столбца
let g:airline_fugitive_prefix = '⎇ ' " Префикс для Git
let g:airline_paste_symbol = 'ρ' " Символ для режима вставки
let g:airline_section_c = '%t' " Отображение только имени файла в секции C

" Использование PowerShell в качестве командной оболочки
set shell=pwsh

" Настройки табуляции и пробелов
set expandtab " Использовать пробелы вместо табуляции
set smarttab " Смарт-табуляция
set tabstop=4 " Ширина табуляции - 4 пробела
set softtabstop=4 " Ширина табуляции при редактировании - 4 пробела
set shiftwidth=4 " Ширина отступа - 4 пробела

" Нумерация строк и отступы
set number " Включить нумерацию строк
set foldcolumn=2 " Включить колонку сворачивания

" Цветовая схема и синтаксис
colorscheme torte " Цветовая схема
syntax on " Включить подсветку синтаксиса

" Отключение звуковых уведомлений
set noerrorbells " Отключить звуковые сигналы
set novisualbell " Отключить визуальные сигналы

" Настройки мыши
set mouse=a " Включить поддержку мыши

" Настройки поиска
set ignorecase " Игнорировать регистр при поиске
set smartcase " Умный поиск (учитывать регистр, если есть заглавные буквы)
set hlsearch " Подсвечивать результаты поиска
set incsearch " Поиск по мере ввода
set wrapscan " Циклический поиск

" Кодировка
set encoding=utf-8 " Установить кодировку UTF-8
set termencoding=utf-8

" Настройки шрифта для GUI версии
set guifont=Hack_NF:h11:cRUSSIAN:qDRAFT

" Отключение резервных копий и временных файлов
set backupdir=~/.vim/backup// " Директория для резервных копий
set directory=~/.vim/swap// " Директория для временных файлов
set undodir=~/.vim/undo// " Директория для undo-файлов
set nobackup " Отключить резервные копии
set nowritebackup " Отключить резервные копии при записи
set noswapfile " Отключить swap-файлы
set noundofile " Отключить undo-файлы

" Настройки проверки правописания
set spell spelllang=ru_ru,en_us " Включить проверку правописания для русского и английского

" Настройки подсветки слов с ошибками
hi SpellBad ctermfg=White ctermbg=Red cterm=underline " Цвет и стиль для терминала
hi SpellBad guifg=White guibg=Red gui=underline " Цвет и стиль для GUI
