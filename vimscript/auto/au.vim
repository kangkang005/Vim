" au <events> <file pattern> <command>
" set .pn is 'potion' filetype
au BufNewFile,BufRead *.pn set filetype=potion
au BufNewFile,BufRead *.pn set filetype=potion

" listen to filetype
autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>

" augroup <group_name>
augroup testgroup
    " reset all auto commands in group
    autocmd! " clear augroup
    autocmd BufWrite * :echom "Cats"
augroup END