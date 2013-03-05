runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

let mapleader=","
set showcmd

set autoread

set iskeyword-=_  " Word movements stop on underscores  

set mouse=a " awww yiss
 
set printoptions=paper:letter,duplex:off
set number
set ls=2
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
set autoindent
set incsearch
set hidden
set history=1000
set scrolloff=10
set ruler
set softtabstop=4
set expandtab
set backspace=indent,eol,start
try
    set cc=80
catch
endtry

set encoding=utf-8 "god willing this will work ok

let g:solarized_termtrans = 1
set background=dark
colorscheme solarized 

set copyindent    " copy the previous indentation on autoindenting
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set nobackup
set noswapfile

syntax on
filetype on
filetype plugin on
filetype indent on

set hlsearch
set incsearch

