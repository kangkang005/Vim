function! SelectBracket() abort
    " let l:closure = [['(', ')'], ['{', '}'], ['[', ']']]
    let l:closure_str = '()[]{}'
    let [l:cursor_linenum, l:cursor_col] = getpos('.')[2]
    " let l:cursor_linenum = line('.')
    " let l:cursor_col = col('.')
    let l:cursor_col -= 1
    let l:start_col = l:cursor_col
    let l:start_linenum = l:cursor_linenum
    let l:counter = 0
    while 1
        if l:start_col < 0
            let l:start_linenum -= 1
            let l:start_col = len(getline(l:start_linenum)) - 1
        endif
        let l:line = getline(l:start_linenum)
        let l:char = l:line[l:start_col-1]
        let l:start_col -= 1
        let l:have_match = match(l:closure_str, '\V'. l:char)
        if l:have_match == -1
            continue
        elseif l:have_match % 2 == 1
            let l:counter += 1
        else
            let l:counter -= 1
        endif
        if l:counter == -1
            break
        endif
    endwhile

    let l:end_col = l:cursor_col
    let l:end_linenum = l:cursor_linenum
    while 1
        let l:line = getline(l:end_linenum)
        if l:end_col == len(l:line)
            let l:end_linenum += 1
            let l:end_col = 0
        endif
        let l:line = getline(l:end_linenum)
        let l:char = l:line[l:end_col]
        let l:end_col += 1
        let l:have_match = match(l:closure_str, '\V'. l:char)
        if l:have_match == -1
            continue
        elseif l:have_match % 2 == 1
            let l:counter += 1
        else
            let l:counter -= 1
        endif
        if l:counter == 0
            break
        endif
    endwhile

    let l:start_col += 2
    call setpos('.', [0, l:start_linenum, l:start_col, 0])
    normal m<
    call setpos('.', [0, l:end_linenum, l:end_col, 0])
    normal m>
    normal gv
endfunction

nmap <silent>  <CR>  :call SelectBracket()<CR>