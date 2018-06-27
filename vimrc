let mapleader=","

set showcmd

set autoread

set mouse=a
set ttymouse=xterm

map <F5> :NERDTreeToggle<CR>
map <F6> :TagbarToggle<CR>

set printoptions=paper:letter,duplex:off
set number
set ls=2
"set statusline=%<\ %n:%f\ %m%r%y[%{strlen(&fenc)?&fenc:'none'}]
"set statusline+=%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
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

packadd minpac

call minpac#init()
call minpac#add('fatih/vim-go', {'branch': 'v1.17'})
call minpac#add('junegunn/fzf.vim')
call minpac#add('majutsushi/tagbar', {'branch': 'v2.7'})
call minpac#add('scrooloose/nerdcommenter', {'branch': '2.5.1'})
call minpac#add('scrooloose/nerdtree')
call minpac#add('vim-airline/vim-airline', {'branch': 'v0.9'})
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('lifepillar/vim-solarized8')
call minpac#add('romainl/flattened')
call minpac#add('dag/vim-fish')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-rhubarb')
"call minpac#add('vim-perl/vim-perl')
call minpac#add('tpope/vim-repeat', {'branch': 'v1.2'})
"call minpac#add('vim-ruby/vim-ruby')
call minpac#add('tpope/vim-surround', {'branch': 'v2.1'})
call minpac#add('tmux-plugins/vim-tmux')
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('artur-shaik/vim-javacomplete2')
call minpac#add('hashivim/vim-terraform')
call minpac#add('airblade/vim-rooter')
call minpac#add('Shougo/deoplete.nvim')
    call minpac#add('roxma/nvim-yarp')
    call minpac#add('roxma/vim-hug-neovim-rpc')
call minpac#add('zchee/deoplete-go')
call minpac#add('w0rp/ale')
call minpac#add('edkolev/tmuxline.vim')
call minpac#add('craigemery/vim-autotag')
call minpac#add('sheerun/vim-polyglot')
call minpac#add('chriskempson/base16-vim')
call minpac#add('dhleong/intellivim')

let g:github_enterprise_urls = ['https://git.liveramp.net']


let g:solarized_use16 = 1

set background=dark
colorscheme flattened_dark

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

syntax on
filetype on
filetype plugin on
filetype indent on

set hlsearch
set incsearch

set completeopt-=preview
set omnifunc=syntaxcomplete#Complete
let g:deoplete#enable_at_startup = 1
"let g:deoplete#complete_method = "omnifunc"
autocmd FileType java setlocal omnifunc=javacomplete#Complete

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
