set nocompatible
set relativenumber
set cursorline
set backspace=indent,eol,start
set clipboard=unnamedplus
set noswapfile
set nowritebackup
set runtimepath+=/opt/domus/vim
set background=dark
set autoindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set list listchars=tab:>-
set linebreak
set incsearch
set hlsearch
set ignorecase
set smartcase

call plug#begin('/opt/domus/vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'arcticicestudio/nord-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
call plug#end()

let g:airline_theme='nord'
let g:airline_powerline_fonts = 1
colorscheme nord

if (has("termguicolors")) && (v:version < 802)
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

if has('persistent_undo')
  set undodir=~/.cache/vim/
  set undofile
endif

augroup vimrcEx
  autocmd!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END
