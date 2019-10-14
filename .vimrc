set nocompatible

" ================ General Config ====================
set number
set cursorline
set backspace=indent,eol,start
set history=1000
set showcmd
set showmode
set gcr=a:blinkon0
set visualbell
set autoread
set encoding=utf-8
set hidden
syntax on
let base16colorspace=256
let mapleader=","

" =============== Vundle Initialization ===============
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'arcticicestudio/nord-vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'

call vundle#end()
filetype plugin indent on

let g:nord_underline = 1
let g:nord_italic_comments = 1
let g:nord_italic = 1
let g:nord_uniform_status_lines = 1
let g:nord_uniform_diff_background = 1
let g:nord_cursor_line_number_background = 1
set laststatus=2
let g:airline_theme='nord'
let g:airline_skip_empty_sections = 1
let g:airline_detect_paste = 1
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.space = "\ua0"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

map <C-n> :NERDTreeToggle<CR>

" set Vim-specific sequences for RGB colors
if (has("termguicolors"))
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
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>
filetype plugin on
filetype indent on
set list listchars=tab:\ \ ,trail:·
set nowrap
set linebreak

" ================ Folds ============================
set foldmethod=indent
set foldnestmax=3
set nofoldenable

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
