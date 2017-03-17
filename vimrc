runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

let mapleader=","
set showcmd

set autoread

set mouse=a
set ttymouse=xterm

map <F5> :NERDTreeToggle<CR>
 
set printoptions=paper:letter,duplex:off
set number
set ls=2
set statusline=%<\ %n:%f\ %m%r%y[%{strlen(&fenc)?&fenc:'none'}]
set statusline+=%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
set autoindent
set incsearch
set hidden
set history=1000
set scrolloff=10
set ruler
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
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

autocmd FileType javascript noremap <buffer> <C-s> :call JsBeautify()<cr>

" Ctrl-r in visual mode for replace
" http://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left><left>

" Keep go files from taking 10 seconds to save
" https://github.com/fatih/vim-go/tree/3eb57ac3a8e02a3d6e2bfba981144c6e1af3545b#using-with-syntastic
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
" gimme those go highlights
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_autosave = 0
let g:ackprg = 'ag --nogroup --nocolor --column'
