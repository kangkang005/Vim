function! s:put_msg() abort
    echo 'this is message'
endfunction

" keyword sequence
" <SID> is function scope
" <C-u> clear command line, such as comamnd line is :'<,'> at visual mode, <C-u> will clear '<,'>
noremap <silent> <Plug>(Put) :<C-u>call <SID>put_msg()<cr>
nmap <leader>l <Plug>(Put)