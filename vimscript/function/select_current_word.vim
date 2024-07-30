function! s:select_current_word() abort
    let l:line = getline('.')
    let l:col = col('.')-1
    let l:left_part = strpart(l:line, 0, l:col+1)
    let l:right_part = strpart(l:line, l:col, col('$'))
    let l:left_word = matchstr(l:left_part, '\k*$')
    let l:right_word = matchstr(l:right_part, '\k*')[1:]
    let l:word = l:left_word . l:right_word
    if l:word == ''
        return
    endif
    let l:len = len(l:word)
    call cursor(l:lnum, l:col+2-len(l:left_word))
    execute 'normal! v'.l:len.'l'
endfunction
noremap <silent> <Plug>(SelectCurWord) :<C-u>call <SID>select_current_word()<cr>
nmap <cr> <Plug>(SelectCurWord)