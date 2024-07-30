" color
hi CursorLine term=NONE cterm=NONE ctermbg=238
hi Search term=reverse ctermfg=229 ctermbg=136
hi StatusLine ctermfg=16 ctermbg=179 cterm=NONE
hi StatusLineNC ctermfg=244 ctermbg=144 cterm=NONE
hi Comment term=bold ctermfg=74
hi Constant term=underline ctermfg=217
hi LineNr term=underline ctermfg=143
hi Folded ctermfg=220
hi FoldColumn ctermfg=220
hi Special ctermfg=214
hi NonText ctermfg=152 ctermbg=239
hi Visual ctermfg=186 ctermbg=64 cterm=NONE
hi PmenuSel ctermfg=16 ctermbg=179 cterm=NONE
hi Pmenu ctermfg=16 ctermbg=138
hi ColorColumn ctermbg=88
hi WarningMsg ctermfg=202
hi ErrorMsg ctermfg=15 ctermbg=160
hi Error ctermfg=15 ctermbg=160
hi Modifier cterm=inverse ctermfg=118 gui=inverse guifg=#87ff00
hi StatuslineWarning cterm=inverse ctermfg=210 gui=inverse guifg=#ff8787

" vim syntax keyword
Comment         any constant

Constant        any constant
String          a string constant: "this is a string"
Character       a character constant: 'c', '\n'
Number          a number constant: 234, 0xff
Boolean         a boolean constant: TRUE, false
Float           a floating point constant: 2.3e10

Identifier      any variable name
Function        function name(also: methods for classes)

Statement       any statement
Conditional     if, then, else, endif, switch, etc.
Repeat          for, do, while, etc.
Label           case, default, etc.
Operator        "sizeof", "+", "*", etc.
Keyword         any other keyword
Exception       try, catch, throw

PreProc         generic Preproessor
Include         preproessor #include
Define          preproessor #define
Macro           same as Define
PreCondit       preproessor #if, #else, #endif, etc.

Type            int, long, char, etc.
StorageClass    static, register, volatile, etc.
Structure       struct, union, enum, etc.
Typedef         A typedef

Special         any special symbol
SpecialChar     special character in a constant
Tag             you can use CTRL-] on this
Delimiter       character that needs attention
SpecialComment  special things inside a comment
Debug           debugging statements

Underlined      text that stands out, HTML links

Ignore          left blank, hidden hl-Ignore

Error           any erroneousa construct

Todo            anything that needs extra attention; mostly the keywords TODO FIXME and XXX