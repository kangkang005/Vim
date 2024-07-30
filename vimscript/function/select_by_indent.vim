function! GetBoundary(direction) abort
    let l:curlinenum = line('.')
    if nextnonblank('.') != line('.') || prevnonblank('.') != line('.')
        return l:curlinenum
    endif
    let l:curlineindent = indent('.')
    let l:nextlinenum = l:curlinenum
    while l:nextlinenum != line('$')
        let l:lineindent = indent(l:nextlinenum)
        if l:lineindent < l:curlineindent
            let l:nextlinenum -= a:direction
            break
        endif

        if a:direction < 0
            let l:nextlinenum = prevnonblank(l:nextlinenum + a:direction)
        elseif a:direction > 0
            let l:nextlinenum = nextnonblank(l:nextlinenum + a:direction)
        endif
    endwhile

    let l:def_nextlinenum = prevnonblank(l:nextlinenum-1)
    if match(getline(l:def_nextlinenum), 'def ') != -1
        let l:nextlinenum = l:def_nextlinenum
    endif
    return l:nextlinenum
endfunction

function! SelectByIndent() abort
    let l:toplinenum = GetBoundary(-1)
    let l:botlinenum = GetBoundary(1)

    " selet lines by line number
    execute l:toplinenum
    normal! V
    execute l:botlinenum
endfunction

nmap <silent>  <CR>  :call SelectByIndent()<CR>
" vmap <silent>  <CR>  :call SelectByIndent()<CR>