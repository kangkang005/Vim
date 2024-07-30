" (string) is enclosed with brack
let l:open = '('
let l:close = ')'
let l:enclose = matchstr(getline('.'), '\V'.l:open.'\m\zs.*\V'.l:close)