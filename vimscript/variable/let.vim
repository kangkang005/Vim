" g:varname	变量为全局变量
" s:varname	变量的范围为当前的脚本文件
" w:varname	变量的范围为当前的编辑器窗口
" t:varname	变量的范围为当前的编辑器选项卡
" b:varname	变量的范围为当前的编辑器缓冲区
" l:varname	变量的范围为当前的函数
" a:varname	变量是当前函数的一个参数
" v:varname	变量是 Vim 的预定义变量

" &varname	一个 Vim 选项（如果指定的话，则为本地选项，否则为全局选项）
" &l:varname	本地 Vim 选项
" &g:varname	全局 Vim 选项
" @varname	一个 Vim 注册器
" $varname	一个环境变量

let name = "Damian"
let height = 165
let interests = [ 'Cinema', 'Literature', 'World Domination', 101 ]
let phone     = {
    \ 'cell':5551017346,
    \ 'home':5558038728,
    \ 'work':'?'
    \ }
echo name
echo height
echo interests
echo phone