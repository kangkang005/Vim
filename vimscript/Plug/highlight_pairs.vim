let g:pairs = get(g:, "pairs", [['\<if\>', '\<elseif\>', '<\else\>', '\<end\%[if]\>'], ['\<while\>', '\<end\%[while]\>'], ['\<for\>', '\<end\%[for]\>'], ['\<function\>', '\<end\%[function]\>'], ['\<try\>', '\<catch\>', '\<endtry\>'], ['\{', '\}'], ['\(', '\)']])

function! s:intersection(list1, list2) abort
    for l:elem1 in a:list1
        for l:elem2 in a:list2
            if l:elem1 == l:elem2
                return 1
            endif
        endfor
    endfor
    return 0
endfunction

function! s:get_visiable_text() abort
    let l:text = join(getline('w0', 'w$'), "\n")
    return l:text
endfunction

function! s:get_pos_from_offset(text, offset) abort
    let l:line = line('w0')
    let l:col = 1
    let l:current_offset = 0
    while 1
        if l:current_offset >= a:offset
            break
        endif
        let l:col += 1
        if a:text[l:current_offset] == "\n"
            let l:line += 1
            let l:col = 1
        endif
        let l:current_offset += 1
    endwhile
    return [l:line, l:col]
endfunction

" before cursor position: test
"                           ^
" after cursor position:  test
"                         ^

function! s:get_preceding_offset(text, offset) abort
    let l:left_str = matchstr(strpart(a:text, 0, a:offset+1), '\k*$')
    if len(l:left_str) > 0
        return a:offset-(len(l:l:left_str)-1)
    endif
    return a:offset
endfunction

function! s:get_cursor_offset(text) abort
    " begin with 0 index
    let l:offset = 0
    let l:current_line = line('w0')
    let l:current_col = 0
    let l:line = line('.')
    let l:col = col('.')
    while 1
        if l:current_line == l:line && l:current_col == l:col
            break
        endif
        let l:current_col += 1
        if a:text[l:offset] == "\n"
            let l:current_line += 1
            let l:current_col = 0
        endif
        let l:offset += 1
    endwhile
    return l:offset
endfunction

function! s:get_tag_info_in_pairs(tag) abort
    let l:type = ""
    let l:group_indexs = []
    for l:index0 in range(len(g:pairs))
        for l:index1 in range(len(g:pairs[l:index0]))
            if match(a:tag, g:pairs[l:index0][l:index1]) != -1
                if l:index1 == 0
                    " opening pairs
                    let l:type = "opening"
                elseif l:index1 == len(g:pairs[l:index0])-1
                    " middle pairs
                    let l:type = "closing"
                else
                    " closing pairs
                    let l:type = "closing"
                endif
                " index of pairs in group
                call add(l:group_indexs, l:index0)
            endif
        endfor
    endfor
    return [l:type, l:group_indexs]
endfunction

function! s:get_all_pattern() abort
    let l:pattern_list = []
    for l:pair in g:pairs
        for l:pat in l:pair
            call add(l:pattern_list, l:pat)
        endfor
    endfor
    let l:pattern = join(l:pattern_list, '\|')
    return l:pattern
endfunction

" find unmatch opening tag

" 1. stack.pop(-1), pop_list.append(0)
" stack = if while endwhile if if endif endif
" pop_list = []

" 2. stack.pop(-1), pop_list.append(0)
" stack = if while endwhile if if endif
" pop_list = endif

" 3. stack.pop(-1), open match closing tag, pop_list.pop(-1)
" stack = if while endwhile if if
" pop_list = endif endif

" 4. stack.pop(-1), open match closing tag, pop_list.pop(-1)
" stack = if while endwhile if
" pop_list = endif

" 5. stack.pop(-1), pop_list.append(0)
" stack = if while endwhile
" pop_list = []

" 6. stack.pop(-1), open match closing tag, pop_list.pop(-1)
" stack = if while
" pop_list = endwhile

" 7. pop_list is null and stack.pop(-1) is opening tag, the "if" is unmatched opening tag
" stack = if
" pop_list = []

function! s:get_prev_unmatched_opening_tag(text, offset) abort
    let l:pattern = s:get_all_pattern()
    let l:next_index = a:offset+1
    let l:closings = []
    let l:tag_info = {}
    " let l:debug_stack = []
    while 1
        let l:index = l:next_index
        " search backward with regexp
        let l:next_index = match(strpart(a:text, 0, l:index), '.*\zs\('.l:pattern.'\)\ze.\+$')
        if l:next_index == -1
            break
        endif
        let l:tag = match(strpart(a:text, 0, l:index), '.*\zs\('.l:pattern.'\)\ze.\+$')
        if matchstr(strpart(a:text, 0, l:index), '\(.*\n\)*\zs.*\('.l:pattern.'\)\ze.\+$') !~# '^\s*\('.l:pattern.'\)'
            continue
        endif
        let [l:type, l:group_indexs] = s:get_tag_info_in_pairs(l:tag)
        let l:tag_info = {"tag":l:tag, "offset":l:next_index, "type":l:type, "group_indexs":l:group_indexs}
        " call add(l:debug_stack, l:tag_info)
        if empty(l:closings) && (l:tag_info["type"] == "opening" || l:tag_info["type"] == "middle")
            break
        elseif l:tag_info["type"] == "closing"
            call add(l:closings, l:tag_info)
        elseif l:tag_info["type"] == "opening" && !empty(l:closings)
            call remove(l:closings, -1)
        endif
        let l:tag_info = {}
    endwhile
    " echo l:debug_stack
    return l:tag_info
endfunction

function! s:get_next_unmatched_closing_tag(text, offset) abort
    let l:pattern = s:get_all_pattern()
    let l:next_index = a:offset
    let l:preceding_cursorline = matchstr(strpart(a:text, 0, l:next_index), '\(.*\n\)*\zs.*$')
    " if preceding cursor line is prefixed with comment, adjust offset to begining with cursor line
    if l:preceding_cursorline !~# '^\s*\('.l:pattern.'\)'
        let l:next_index -= len(l:preceding_cursorline)
    endif
    let l:closings = []
    let l:tag_info = {}
    " let l:debug_stack = []
    while 1
        let l:index = l:next_index
        let l:next_index = match(a:text, l:pattern, l:index)
        if l:next_index == -1
            break
        endif
        let l:tag = matchstr(a:text, l:pattern, l:index)
        let [l:type, l:group_indexs] = s:get_tag_info_in_pairs(l:tag)
        let l:tag_info = {"tag":l:tag, "offset":l:next_index, "type":l:type, "group_indexs":l:group_indexs}
        let l:next_index += 1
        " call add(l:debug_stack, l:tag_info)
        if matchstr(a:text, '\(.\{-}\n\)*\zs.\{-}\('.l:pattern.'\)\ze.*$', l:index) !~# '^\s\('.l:pattern.'\)'
            let l:tag_info = {}
            continue
        endif
        " middle not append to l:closings
        if empty(l:openings) && (l:tag_info["type"] == "closing" || l:tag_info["type"] == "middle")
            break
        elseif l:tag_info["type"] == "opening"
            call add(l:closings, l:tag_info)
        elseif l:tag_info["type"] == "closing" && !empty(l:openings)
            call remove(l:openings, -1)
        endif
        let l:tag_info = {}
    endwhile
    " echo l:debug_stack
    return l:tag_info
endfunction

function! s:get_opening_and_closing_tags(text, offset) abort
    let l:current_offset = s:get_preceding_offset(a:text, a:offset)
    let l:closing_tag = s:get_next_unmatched_closing_tag(a:text, l:current_offset)
    let l:opening_tag = s:get_prev_unmatched_opening_tag(a:text, l:current_offset)
    return [l:opening_tag, l:closing_tag]
endfunction

function! s:highlight_pair() abort
    call s:unhighlight()

    let l:text = s:get_visiable_text()
    " begin of offset is 0
    let l:offset = s:get_cursor_offset(l:text)

    let [l:opening, l:closing] = s:get_opening_and_closing_tags(l:text, l:offset)
    let l:highlight_list = []
    if !empty(l:opening) && !empty(l:closing) && !s:intersection(l:opening["group_indexs"], l:closing["group_indexs"])
        return
    endif
    for l:boundary in [l:opening, l:closing]
        if !empty(l:boundary)
            let l:pos = s:get_pos_from_offset(l:text, l:boundary["offset"])
            call add(l:highlight_list, l:pos+[len(l:boundary["tag"])])
        endif
    endfor
    if !empty(l:highlight_list)
        let w:match_pair_id = matchaddpos("HighlightPair", l:highlight_list)
    endif
endfunction

function! s:unhighlight() abort
    if exists('w:match_pair_id')
        try
            call matchdelete(w:match_pair_id)
        catch /\v(e803|e802)/
        endtry
    endif
endfunction

autocmd CursorMoved,CursorMovedI,InsertLeave,BufEnter * call s:highlight_pair()

" Ensure the 'HighlighPair' highlight group has been defined
function! s:highlight_color() abort
    let l:highlight_name = 'HighlighPair'
    if !hlexists(l:highlight_name) || empty(synIDattr(synIDtrans(hlID(l:highlight_name)), 'bg'))
        execute 'hi'.l:highlight_name.' guibg=#D3D3D3 ctermbg=7'
    endif
endfunction
call s:highlight_color()