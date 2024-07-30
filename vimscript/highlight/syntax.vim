""""" highlight keyword """""
" syntax keyword
" link potionKeyword to Keyword group
syntax keyword potionKeyword loop times to while
syntax keyword potionKeyword if elsif else
syntax keyword potionKeyword class return
"            syntax group    vim standard name
highlight link potionKeyword Keyword

syntax keyword potionFunction print join string
highlight link potionFunction Function

""""" highlight comment """""
" syntax match: use regexp
" \v is very magic
syntax match potionComment "\v#.*$"
highlight link potionComment Comment

""""" highlight special """""
" highlight upcase word, \u is upcase, \l is lowercase
syntax match upcase /\<\u\+\>/
highlight link upcase Keyword

""""" highlight contain """""
" highlight TODO in comment, tag contained only is include
" such as: %Get input  TODO: Skip white space
syntax keyword xTodo TODO contained
syntax match xComment /%.*/ contains=xTodo
highlight link xTodo Keyword
highlight link xComment Comment

""""" highlight nest """""
" example:
" while i < b {
"     if a {
"         b = c;
"     }
" }
syntax region xBlock start=/{/ end=/}/ contains=xBlock
highlight link xBlock Function

""""" highlight tail """""
" keepend ensure $ not eaten
"    #define X = Y  % Comment text
"    int foo = 1;
syntax region xComment start=/%/ end=/$/ contained
syntax region xPreProc start=/#/ end=/$/ contains=xComment keepend
highlight link xBlock Statement

""""" highlight constain items """""
" highlight all included []
syntax region xList start=/\[/ end=/\]/ contains=ALL
" highlight exclude string included []
syntax region xList start=/\[/ end=/\]/ contains=ALLBUT,xString
highlight link xList Statement

""""" highlight followed group """""
" if (...) then ...
syntax match xIf /if/ nextgroup=xIfCondition skipwhite
syntax match xIfCondition /([^)]*)/ contained nextgroup=xThen skipwhite
syntax match xThen /then/ contained
highlight link xIf Statement
highlight link xIfCondtion Keyword
highlight link xThen String

""""" transparent """""
syntax region cWhile matchgroup=cWhile start=/while\s*(/ end=/)/
                \ contains=cCondNest
syntax region cFor matchgroup=cFor start=/for\s*(/ end=/)/
        \ contains=cCondNest
syntax region cCondNest start=/(/ end=/)/ contained transparent
highlight link xWhile Statement
highlight link xFor Keyword
highlight link xCondNest String

""""" offset """""
syntax region xCond start=/if\s*(/ms=e+1 end=/)/me=s-1
highlight link xCond Keyword

""""" continuation """""
" #define SPAM  spam spam spam \
"     bacon and spam
syntax region xPreProc start=/^#/ end=/$/ contains=xLineContinue
syntax match xLineContinue "\\$" contained
highlight link xPreProc Comment
highlight link xLineContinue Comment
" excludenl
syntax region xPreProc start=/^#/ end=/$/
                \ contains=xLineContinue,xPreProcEnd
syntax match xPreProcEnd excludenl /end$/ contained
syntax match xLineContinue "\\$" contained
highlight link xPreProc Comment
highlight link xLineContinue Comment

""""" highlight cluster """""
syntax cluster xState contains=Number,Identifier
syntax match xFor /^for.*/ contains=@xState
syntax match xIf /^if.*/ contains=@xState
syntax match xWhile /^while.*/ contains=@xState
highlight link xFor Statement
highlight link xIf Statement
highlight link xWhile Statement

""""" highlight operation """""
syntax match potionOperator "\v\="
syntax match potionOperator "\v\*"
syntax match potionOperator "\v/"
syntax match potionOperator "\v\+"
syntax match potionOperator "\v-"
syntax match potionOperator "\v\?"
syntax match potionOperator "\v\*\="
syntax match potionOperator "\v/\="
syntax match potionOperator "\v\+\="
syntax match potionOperator "\v-\="
highlight link potionOperator Operator

""""" highlight string """""
" syntax region: skip escape string, such as: "She said: \"Vimscript is tricky, but useful\"!"
syntax region potionString start=/\v"/ skip=/\v\\./ end=/\v"/
highlight link potionString String

""""" highlight default link """""
" for plugin, Keyword syntax
highlight default link potionKeyword Keyword
" for vimrc, overrule plugin and change to String syntax
highlight link potionKeyword String

""""" highlight the next word prefixed with class """""
" https://vi.stackexchange.com/questions/39771/highlight-a-single-word-that-would-be-encountered-after-a-specific-word
hi ClassName guibg=#A0A0A0
match ClassName /\(class\s\+\)\@<=\w\+/
" or
hi ClassName guibg=#A0A0A0
match ClassName /class\s\+\zs\w\+/