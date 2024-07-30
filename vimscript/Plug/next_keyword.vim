function! MoveCursor(forward)
    let stop_re = 'sql\%(Keyword\|Operator\|Statement\)'
    let curpos=getcurpos()
    while search('\<', 'W'.a:forward)
        if synIDattr(synID(line("."), col("."), 1), "name") =~ stop_re
            break
        endif
    endwhile
    if synIDattr(synID(line("."), col("."), 1), "name") !~ stop_re
        call setpos('.', curpos)
    endif
endfunction

nnoremap W :call MoveCursor('')<cr>
nnoremap B :call MoveCursor('b')<cr>