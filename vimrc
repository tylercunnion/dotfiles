let mapleader=","

set showcmd

set autoread

set mouse=a

if !has('nvim')
    set ttymouse=xterm
endif

map <F5> :NERDTreeToggle<CR>
map <F6> :TagbarToggle<CR>

set number
set ls=2
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

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'dag/vim-fish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-surround'
Plug 'tmux-plugins/vim-tmux'
"Plug 'christoomey/vim-tmux-navigator'
Plug 'hashivim/vim-terraform'
Plug 'airblade/vim-rooter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'beeender/Comrade'
"Plug 'zchee/deoplete-go'
Plug 'w0rp/ale'
"Plug 'edkolev/tmuxline.vim'
Plug 'craigemery/vim-autotag'
Plug 'sheerun/vim-polyglot'
"Plug 'chriskempson/base16-vim'
call plug#end()

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

let g:airline_powerline_fonts = 1
let g:airline_solarized_bg='dark'

let g:tmuxline_preset = {
  \'a' : '#(/bin/bash ~/.tmux/kube-tmux/kube.tmux white,normal white white)',
  \'win'  : ['#I', '#W'],
  \'cwin' : ['#I', '#W', '#F'],
  \'y'    : ['%R', '%a', '%Y'],
  \'z'    : '#h'}

set hlsearch
set incsearch

set completeopt-=preview
set omnifunc=syntaxcomplete#Complete
let g:deoplete#enable_at_startup = 1
"let g:deoplete#sources#go = 'vim-go'

"autocmd FileType java setlocal omnifunc=javacomplete#Complete

let g:airline#extensions#ale#enabled = 1

" Ctrl-r in visual mode for replace
" http://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left><left>

" gimme those go highlights
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

call deoplete#custom#option('omni_patterns', {
\ 'go': '[^. *\t]\.\w*',
\})

let java_highlight_all = 1
let java_comment_strings = 1
let java_highlight_java_lang_ids=1

let g:ackprg = 'ag --vimgrep --smart-case'

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

set tags=tags;/ " look for ctags up to the root
set rtp+=/usr/local/opt/fzf

function! SetBackgroundMode(...)
    let s:new_bg = "light"
    let s:mode = systemlist("defaults read -g AppleInterfaceStyle")[0]
    if s:mode ==? "dark"
        let s:new_bg = "dark"
    else
        let s:new_bg = "light"
    endif
    if &background !=? s:new_bg
        let &background = s:new_bg
    endif
endfunction
call SetBackgroundMode()
call timer_start(3000, "SetBackgroundMode", {"repeat": -1})
