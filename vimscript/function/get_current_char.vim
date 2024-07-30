function! s:get_current_char() abort
    let l:char = getline('.')[col('.')-1]
    echo l:char
    return l:char
endfunction
noremap <silent> <Plug>(GetCurrentChar) :<C-u>call <SID>get_current_char()<cr>
nmap <cr> <Plug>(GetCurrentChar)