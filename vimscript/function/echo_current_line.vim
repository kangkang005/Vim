function! EchoLine()
    let line = getline(".") " . is cursor
    echo line
endfunction

nmap <silent>  ;s  :call EchoLine()()<CR>