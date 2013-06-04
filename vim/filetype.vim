if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
    au BufRead,BufNewFile *.less set filetype=less
    au BufRead,BufNewFile *.as set filetype=actionscript
    au BufRead,BufNewFile * if expand('%:t') !~ '\.' && getline(1) =~ '-*- mason -*-' | set filetype=mason | endif
augroup END

autocmd FileType ruby :setlocal shiftwidth=2 tabstop=2 softtabstop=2
