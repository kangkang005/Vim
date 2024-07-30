function! s:next(pos) abort
    let [l:lnum, l:col] = getpos(a:pos)[1:2]

    let l:line = getline(l:lnum)
    let l:charlen = matchend(l:line[l:col-1:], '.')
    if l:charlen >= 0 && l:col + l:charlen <= strlen(l:line)
        return [0, l:lnum, l:col + l:charlen, 0]
    endif
    return [0, l:lnum+1, 1, 0]
endfunction

function! s:prev(pos) abort
    let [l:lnum, l:col] = getpos(a:pos)[1:2]

    if l:col > 1
        return [0, l:lnum, match(getline(l:lnum)[0:l:col-2], '.$') + 1, 0]
    endif
    return [0, max([l:lnum-1, 1]),
        \ max([strlen(getline(l:lnum-1)), 1]), 0]
endfunction

" compare cursor position
function! s:val(pos) abort
    let [l:lnum, l:col] = getpos(a:pos)[1:2]
    return 100000*l:lnum + min([l:col, 90000])
endfunction

function! s:smaller(pos1, pos2) abort
    return s:val(a:pos1) < s:val(a:pos2)
endfunction