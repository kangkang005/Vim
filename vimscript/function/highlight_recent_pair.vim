" todo: vimscript have response time
let g:pairs = get(g:, 'g:pairs', [['subckt', 'end'], ['if', 'endif']])

" define highlight gray
if !hlexists('highlight_word')
    hi HighlightPair guibg=#D3D3D3 ctermbg=7
    hi def link highlight_word HighlightPair
endif

" autocmd {
augroup autocmd
    autocmd!
    autocmd CursorMoved,InsertLeave * call s:highlight_recent_pair()
augroup END
" autocmd }

function! s:keyword(word) abort
    return '\<'.'\c'.a:word.'\>'
endfunction

function! s:highlight_recent_pair()
    let l:recent_pos_group = []
    for l:pair in g:pairs
        let l:pos0 = searchpairpos(s:keyword(l:pair[0]), '', s:keyword(l:pair[1]), 'nb')
        let l:pos1 = searchpairpos(s:keyword(l:pair[0]), '', s:keyword(l:pair[1]), 'n')
        call add(l:pos0, l:pair[0])
        call add(l:pos1, l:pair[1])
        if l:pos0[0] == 0 || l:pos1[0] == 0
            continue
        endif
        if empty(l:recent_pos_group)
            call add(l:recent_pos_group, l:pos0)
            call add(l:recent_pos_group, l:pos1)
        elseif l:pos0[0] < l:recent_pos_group[0][0]
            let l:recent_pos_group[0] = l:pos0
            let l:recent_pos_group[1] = l:pos1
        endif
    endfor
    if len(l:recent_pos_group) != 2
        return
    endif
    let l:match_id = matchaddpos('highlight_word', [[l:recent_pos_group[0][0], l:recent_pos_group[0][1], len(l:recent_pos_group[0][2])]])
endfunction