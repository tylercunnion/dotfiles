let mapleader=","

set showcmd
set autoread
set mouse=a

if !has('nvim')
    set ttymouse=xterm
endif

map <F5> :NERDTreeToggle<CR>

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

set hlsearch
set incsearch

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'dag/vim-fish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'vim-ruby/vim-ruby'
Plug 'hashivim/vim-terraform'
Plug 'airblade/vim-rooter'
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'github/copilot.vim'

Plug 'prabirshrestha/vim-lsp'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'lighttiger2505/deoplete-vim-lsp'
call plug#end()

"if executable('pyright')
"  au User lsp_setup call lsp#register_server({
"    \ 'name': 'pyright',
"    \ 'cmd': {server_info->['pyright']},
"    \ 'allowlist': ['python'],
"    \ })
"endif

#function! s:on_lsp_buffer_enabled() abort
#  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
#    nmap <buffer> gd <plug>(lsp-definition)
#    nmap <buffer> gr <plug>(lsp-references)
#    nmap <buffer> gi <plug>(lsp-implementation)
#    nmap <buffer> gt <plug>(lsp-type-definition)
#    nmap <buffer> <leader>rn <plug>(lsp-rename)
#    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
#    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
#    nmap <buffer> K <plug>(lsp-hover)
#endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:airline_powerline_fonts = 1
let g:airline_solarized_bg='dark'

set completeopt-=preview
"set omnifunc=syntaxcomplete#Complete
set omnifunc=lsp#complete
let g:deoplete#enable_at_startup = 1
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
