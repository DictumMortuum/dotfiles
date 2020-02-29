set nocompatible

" ================ General Config ====================
set relativenumber
set cursorline
set backspace=indent,eol,start
set clipboard=unnamedplus
syntax on

" =============== git-plug Initialization ===============
set runtimepath+=/opt/domus/vim

call plug#begin('/opt/domus/vim/plugged')
Plug 'gmarik/Vundle.vim'
Plug 'vim-airline/vim-airline'
Plug 'arcticicestudio/nord-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
call plug#end()

let g:airline_theme='nord'
let g:airline_powerline_fonts = 1

" set Vim-specific sequences for RGB colors
if (has("termguicolors")) && (v:version < 802)
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

colorscheme nord
set background=dark

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
if has('persistent_undo')
  set undodir=~/.cache/vim/
  set undolevels=1000
  set undoreload=10000
  set undofile
endif

" ================ Indentation ======================
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
filetype plugin on
filetype indent on
set list listchars=tab:\ \ ,trail:·
set nowrap
set linebreak

" ================ Scrolling ========================
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

" ================ Search ===========================
set incsearch
set hlsearch
set ignorecase
set smartcase

" hardmode!
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
