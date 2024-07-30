" search, return -1 if no match
let l:match = search('\<break\>\|\<return\>\|\<continue\>')  " search 'break', 'return' or 'continue'
" searchpos, return [0, 0] if no match
let [l:lnum, l:col] = searchpos('break', 'n', 6)            " not move cursor, stop at line 6
let [l:lnum, l:col] = searchpos('break', 'e')               " move match word end, such as move to end of 'break'
let [l:lnum, l:col] = searchpos('break', '', 6)             " not any flags, stop at line 6
let [l:lnum, l:col] = searchpos('break', 'nb')              " not move cursor, search backward
let [l:lnum, l:col] = searchpos('\c'.'break')               " ignore case
let [l:lnum, l:col] = searchpos('\C'.'break')               " not ignore case
let [l:lnum, l:col] = searchpos('break', 'c')               " match include under cursor
let [l:lnum, l:col] = searchpos('break', 'c', line('.'))    " match 'break' in current line

" searchpair, return 0 if no match
let l:match = searchpair('(', '', ')', 'synIDattr(synID(line("."), col("."), 0), "name") =~? "String"')         " reject match that syntax highlighling recognized as strings
" Example: "this is string ( in bracket )"
let l:match = searchpair('\<if\>', '\<el\%[seif]\>', '\<end\%[if]\>', 'W', 'getline(".") =~ "^\\s*\""')         " match <if> <else> <end>, skip comment with begin \"
" \zs, put cursor position
let l:match = searchpair('\<if\>', '\<el\%[seif]\>\zs', '\<end\%[if]\>\zs', 'W', 'getline(".") =~ "^\\s*\""')   " match <if> <else> <end>, skip comment with begin \", and put cursor at end of <else> or <end>
" if cursor position at outside if region, search will skip comment and inside if
" Example:
if 1

"   this is else comment

elseif 1
    if 2

    endif
else

endif

" Example:  https://github.com/gregsexton/MatchTag/blob/master/ftplugin/html.vim#L27
fu! s:SearchForMatchingTag(tagname, forwards)
    "returns the position of a matching tag or [0 0]

    let starttag = '\V<'.escape(a:tagname, '\').'\%(\_s\%(\.\{-}\|\_.\{-}\%<'.line('.').'l\)/\@<!\)\?>'
    let midtag = ''
    let endtag = '\V</'.escape(a:tagname, '\').'\_s\*'.(a:forwards?'':'\zs').'>'
    let flags = 'nW'.(a:forwards?'':'b')

    " When not in a string or comment ignore matches inside them(htmlString, xmlString, htmlCommentPart, xmlCommentPart).
    let skip ='synIDattr(synID(line("."), col("."), 0), "name") ' .
                \ '=~?  "\\%(html\\|xml\\)String\\|\\%(html\\|xml\\)CommentPart"'
    if skip | let skip = 0 | endif

    " Limit the search to lines visible in the window. if search forward, stop at end of visible window; if search backward, stop at first of visiable window.
    let stopline = a:forwards ? line('w$') : line('w0')
    let timeout = 300

    " The searchpairpos() timeout parameter was added in 7.2
    if v:version >= 702
        return searchpairpos(starttag, midtag, endtag, flags, skip, stopline, timeout)
    else
        return searchpairpos(starttag, midtag, endtag, flags, skip, stopline)
    endif
endfu