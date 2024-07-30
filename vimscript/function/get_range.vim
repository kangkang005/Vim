" todo
function! GetRange() abort
    if mode() == 'v'
        let [line_start, column_start] = getpos("'<")[1:2]
        let [line_end, column_end] = getpos("'>")[1:2]
        echo line_start
        echo line_end
    else
        echo line('.')
    endif
endfunction

nmap <silent>  <CR>  :call GetRange()<CR>
vmap <silent>  <CR>  :call GetRange()<CR>