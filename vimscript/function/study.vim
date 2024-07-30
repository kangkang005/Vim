" left key
<left>
" ledaer key
<leader>
" space key
<space>
" esc key
<esc>
" ctrl-r
<c-r>
" backspace key
<bs>
" return key
<cr>

" is replaced with the word under the cursor
" Note that <cword> is forward-looking, and skips space between the cursor and the next word,
" e.g. expand('<cword>') on apple| pie will return 'pie' rather than empty string.
<cword>
" is replaced with the WORD under the cursor
<cWORD>
" such as:
"   function()
"      ^
" expand('<cword>') return 'function'
" expand('<cWORD>') return 'function()'

" escape particular char, such as .
\V

" hightlight inside paran
/\[\zs.\+\ze\]

" return map rhs
echo maparg('<cr>', 'n')
" return map dict
echo maparg('<cr>', 'n', 0, 1)

function! Pos() abort
    if line('$') - line('.') <= 1
        return
    endif
    let line = getline('.')
    let pos = col('.') - 1
    let prev_char = line[pos-1]
    let cur_char = line[pos]
    let next_char = line[pos+1]
    let before_str = strpart(line, 0, pos)
    let after_str = strpart(line, pos)

    let pprev_char = line[pos-2]
    let nprev_char = line[pos+2]
endfunction
nmap <silent>  <CR>  :call Pos()<CR>

function! MoveCursor() abort
    let save_pos = getpos('.')
    echo save_pos
    call setpos('.', save_pos)
endfunction
nmap <silent>  <CR>  :call MoveCursor()<CR>

function! MoveCursor() abort
    let save_pos = getcurpos()
    echo save_pos
    call setpos('.', save_pos)
endfunction
nmap <silent>  <CR>  :call MoveCursor()<CR>

function! NextLine() abort
    let next_lineno = line('.') + 1
    " skip whitespace line
    let next_line = getline(nextnonblank(next_lineno))

    let prev_lineno = line('.') - 1
    let prev_line = getline(prevnonblank(prev_lineno))

    echo next_line
    echo prev_line
endfunction
nmap <silent>  <CR>  :call NextLine()<CR>

function! Multi(first, last) abort
    echo col(a:first)
    echo col(a:last)
endfunction
vmap <silent>  <CR>  :call Multi("'<", "'>")<CR>

function! CrossLineJump() abort
    let l:distance = 1
    execute 'noraml!' (-l:distance).'k'
    execute 'noraml!' (l:distance).'j'
endfunction
nmap <silent>  <CR>  :call CrossLineJump()<CR>

function! MoveLinesToLineno() abort
    let l:first = 1
    let l:last = 3
    let l:lineno = 20
    execute l:first ',' l:last 'move' l:lineno
endfunction
nmap <silent>  <CR>  :call MoveLinesToLineno()<CR>

function! IndentLines() abort
    let l:first = 1
    let l:last = 3

    call cursor(l:first, 1)
    let l:old_indent = indent('.')
    " auto indent
    normal! ==
    let l:new_indent = indent('.')

    if l:first < l:last && l:old_indent != l:new_indent
        let l:delta = l:new_indent - l:old_indent
        let l:op = (l:delta > 0) ?
                    \ repeat('>', abs(l:delta)) :
                    \ repeat('<', abs(l:delta))
        let l:old_sw = &shiftwidth
        " indent width is 1 temporaily
        let &shiftwidth = 1
        execute l:first ',' l:last l:op
        " recover indent width
        let &shiftwidth = l:old_sw
    endif
endfunction
nmap <silent>  <CR>  :call IndentLines()<CR>

function! SelectMultiLine() abort
    let l:first = 1
    let l:last = 3

    call cursor(l:first, 1)
    normal! m<
    call cursor(l:last, 1)
    normal! m>
    normal! gv
endfunction
nmap <silent>  <CR>  :call SelectMultiLine()<CR>

" or
function! SelectMultiLine() abort
    let l:first = 1
    let l:last = 3

    call setpos("'<", [0, l:first, 1])
    call setpos("'>", [0, l:first, 1])
    normal! gv
endfunction
nmap <silent>  <CR>  :call SelectMultiLine()<CR>

function! SimulateSelectMultiLine() abort
    let l:first = 1
    let l:last = 3

    call cursor(l:first, 1)
    normal! 0m[
    call cursor(l:last, 1)
    normal! $m]
endfunction
nmap <silent>  <CR>  :call SimulateSelectMultiLine()<CR>

function! DeleteBefore() abort
    normal! d^
endfunction
nmap <silent>  <CR>  :call DeleteBefore()<CR>

function! DeleteAfter() abort
    normal! d$
endfunction
nmap <silent>  <CR>  :call DeleteAfter()<CR>

function! DistanceBefore() abort
    let l:col = col('.')
    normal! ^
    let l:before_col = col('.')
    let l:distance = l:col - l:before_col
    call cursor(line('.', l:col))
    echo l:distance
endfunction
nmap <silent>  <CR>  :call DistanceBefore()<CR>

function! SelectPrevRegion() abort
    execute "normal! g`<\<C-v>g`>"
endfunction
nmap <silent>  <CR>  :call SelectPrevRegion()<CR>

function! FindDown() abort
    let l:keyword = 'function'
    " regexp and variabel insert
    while getline('.') !~# '^\s*' . l:keyword . '!* '
        let l:lineno = line('.')
        " go to r-paran and next line
        " before:
        "     test (  << here
        "     )
        " after:
        "     test (
        "     ) << here
        normal! 0
        normal! %
        normal! j
        if l:lineno == line('.')
            break
        endif
    endwhile
endfunction
nmap <silent>  <CR>  :call FindDown()<CR>

" if
"     xxxxxx
" if
"     xxxxxx
"     if
"         xxxxxx
"     if
"         xxxxxx
function! FindUpIf() abort
    let l:cur_indent = indent('.')
    while search('^\s*if', 'bW')
        if indent('.') < l:cur_indent
            break
        endif
    endwhile
endfunction
nmap <silent>  <CR>  :call FindUpIf()<CR>

function! MoveBottom() abort
    while 1
        if line('.') == line('$')
            break
        endif
        normal! j
    endwhile
endfunction
nmap <silent>  <CR>  :call MoveBottom()<CR>

function! MoveTop() abort
    while 1
        if line('.') == 1
            break
        endif
        normal! k
    endwhile
endfunction
nmap <silent>  <CR>  :call MoveTop()<CR>

function! MoveToDef() abort
    let l:keyword = 'def'
    while 1
        " regexp
        " todo
        if getline('.') =~# '^\s*' . l:keyword . '\[^:\]\+:\s*\[^#\]'
            break
        endif
        if line('.') == 1
            break
        endif
        normal! k
    endwhile
endfunction
nmap <silent>  <CR>  :call MoveToDef()<CR>

function! s:ltrim(str)
    return substitute(a:str, '^\s\+', '', '')
endfunction

function! s:rtrim(str)
    return substitute(a:str, 's\+$', '', '')
endfunction

function! s:trim(str)
    return substitute(a:str, '^\s\+\(.\)s\+$', '\1', '')
endfunction

" shift([12, 1, 0], 1)
function! s:shift(queue, cycle)
    let l:item = remove(a:queue, 0)
    if a:cycle || empty(a:queue)
        call add(a:queue, l:item)
    endif
    return l:item
endfunction

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

let s:is_hi = 0
function! Highlight()
    let l:word = 'test'
    hi def link highlight_word cursorline
    if s:is_hi
        let w:match_id = matchadd('highlight_word', l:word)
    else
        if exists('w:match_id')
            call matchdelete()
        endif
    endif
    let s:is_hi = 1 - s:is_hi
endfunction
nmap <silent>  <CR>  :call Highlight()<CR>

" search
call search('\<break\>\|\<return\>\|\<continue\>')  " search break, return or continue
let [l:lnum, l:col] = searchpos("break", 'n', 6)    " not move cursor, stop at line 6
let [l:lnum, l:col] = searchpos("break", 'e')       " move

" setline
" insert text at cursor
call setline('.', strpart(getline('.'), 0, col('.') - 1) . l:text . strpart(getline('.'), col('.') - 1))