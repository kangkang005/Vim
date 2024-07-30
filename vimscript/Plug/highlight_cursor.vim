" hlsearch priority is -1, matchadd() default to 10, hence all matches prior to hlsearch
let g:highlight_priority = get(g:, 'highlight_priority', -1)
let g:insert_mode_highlight = get(g:, 'insert_mode_highlight', 1)
let b:hi_enabled = 1

" define highlight gray
if !hlexists('highlight_word')
    hi CursorHighlight guibg=#D3D3D3 ctermbg=7
    hi default link highlight_word CursorHighlight
endif

" autocmd {
augroup autocmd
    autocmd!
    autocmd CursorMoved,InsertLeave * call s:highlight()
    autocmd CursorMovedI * call s:on_cursor_moved_i()
    autocmd InsertEnter * call s:on_insert_entered()
augroup END
" autocmd }

" command {
" <bang> is !, such as :HiEnable!
" if have !, <bang> is 1. otherwise, <bang> is 0
command! -nargs=0 -bang HiEnable call s:enable_hi(<bang>0)
command! -nargs=0 -bang HiDisable call s:disable_hi(<bang>0)
command! -nargs=0 -bang HiToggle call s:toggle_hi(<bang>0)
" command }

let s:prev_word = ''
function! s:highlight() abort
    if !get(b:, 'hi_enabled', 1)
        return
    endif
    call s:unhighlight()
    " if s:prev_word !=# s:get_cur_word()
    "     call s:unhighlight()
    " endif
    " if s:get_cur_word() ==# '\<\>'
    "     return
    " endif
    let w:match_id = matchadd('highlight_word', '\V'.s:get_cur_word())
    let s:prev_word = s:get_cur_word()
endfunction

function! s:unhighlight() abort
    if exists('w:match_id')
        try
            call matchdelete(w:match_id)
        catch /\v(E803|E802)/
        endtry
    endif
endfunction

function! s:get_cur_word() abort
    let l:line = getline('.')
    let l:col = col('.')-1
    let l:left_part = strpart(l:line, 0, l:col+1)
    let l:right_part = strpart(l:line, l:col, col('$'))
    let l:word = matchstr(l:left_part, '\k*$') . matchstr(l:right_part, '\k*')[1:]
    return '\<' . escape(l:word, '/\') . '\>'
endfunction

function! s:on_insert_entered() abort
    if get(g:, 'insert_mode_highlight', 0)
        call s:highlight()
    endif
endfunction

function! s:on_cursor_moved_i() abort
    if get(g:, 'insert_mode_highlight', 0)
        call s:highlight()
    endif
endfunction

function! s:enable_hi(bufonly) abort
    let b:hi_enabled = 1
    call s:highlight()
endfunction

function! s:disable_hi(bufonly) abort
    let b:hi_enabled = 0
    call s:unhighlight()
endfunction

function! s:toggle_hi(bufonly) abort
    if get(b:, 'hi_enabled', 1)
        call s:disable_hi(0)
    else
        call s:enable_hi(0)
    endif
endfunction