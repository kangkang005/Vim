.   the cursor position
$   the last line in the current buffer
'x  position of mark x (if the mark is not set, return 0)
w0  first line visiable in current window
w$  last line visiable in current window
'<  first line of the last selected Visual area in the current buffer
'>  end line of the last selected Visual area in the current buffer

Examples:
    line(".")                           line number of the cursor
    line("'t")                          line number of mark t
    line("'".marker)                    line number of mark marker
    let lines = getline('w0', 'w$')     get visiable text at current buffer