" https://vi.stackexchange.com/questions/36494/how-to-move-cursor-up-to-nearest-upward-smaller-level-of-indentation/36497#36497
let g:pairs = get(g:, 'g:pair', [['subckt', 'end'], ['if', 'endif']])

function! s:keyword(word) abort
    return '\<'.'\c'.a:word.'\>'
endfunction

function! s:select_nested_pair() abort
    for l:pair in g:pairs:
        let [l:lnum0, l:col0] = searchpairpos(s:keyword(l:pair[0]), '', s:keyword(l:pair[0]), 'nb')
        let [l:lnum1, l:col1] = searchpairpos(s:keyword(l:pair[0]), '', s:keyword(l:pair[0]), 'n')
        if l:num0 == 0 || l:num1 == 0
            continue
        endif
        call setpos("'<", [0, l:lnum0, l:col0])
        call setpos("'>", [0, l:lnum1, l:col1])
        normal! gv
    endfor
endfunction
noremap <silent> <Plug>(SelectNestedPair) :<C-u>call <SID>select_nested_pair()<cr>
nmap <cr> <Plug>(SelectNestedPair)