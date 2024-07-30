function! s:get_cur_word() abort
    let l:line = getline('.')
    let l:col = col('.')-1
    " l:left_part & l:right_part include current char
    let l:left_part = strpart(l:line, 0, l:col+1)
    " col('$') is col end of line
    let l:right_part = strpart(l:line, l:col, col('$'))
    " \k is string pattern, include [a-zA-Z0-9_], like <cword>
    " \+ is regexp +
    " \* is regexp *
    let l:word = matchstr(l:left_part, '\k*$') . matchstr(l:right_part, '\k*')[1:]
    echo l:word

    return '\<' . escape(l:word, '/\') . '\>'
endfunction
noremap <silent> <Plug>(GetCurWord) :<C-u>call <SID>get_cur_word()<cr>
nmap <cr> <Plug>(GetCurWord)

" https://vi.stackexchange.com/questions/17194/expandcword-returns-empty-string-in-inoremap
" or
" \k like <cword>
" :help /\%v
let l:wordBeforeCursor     = matchstr(getline('.'), '\k\+\%' . virtcol('.') . 'v')
" \S like <cWORD>
let l:WORDContainingCursor = matchstr(getline('.'), '\S*\%' . virtcol('.') . 'v\S*')

" or
call expand('<cword>')
call expand('<cWORD>')