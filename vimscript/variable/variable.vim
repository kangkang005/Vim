g:var - 全局
a:var - 函数参数
l:var - 函数局部变量
b:var - buffer 局部变量
w:var - window 局部变量
t:var - tab 局部变量
s:var - 当前脚本内可见的局部变量
v:var - Vim 预定义的内部变量

" get g:enabled, return g:enabled value if exist, otherwise, return 1
get(g:, 'enabled', 1)
" exist g:enabled or not
exists('g:enabled')