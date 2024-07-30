function! NumberLine() abort range
    for l:line in range(a:firstline, a:lastline)
        let l:sLine = getline(l:line)
        let l:sLine = l:line . ' ' . l:sLine
        call setline(l:line, l:sLine)
    endfor
endfunction

vmap <silent>  ;s  :call NumberLine()<CR>