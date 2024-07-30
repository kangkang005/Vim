" echo：打印的信息是瞬态的，在脚本执行完成后就会消失，后续无法再进行查看。
:echo "Hello, world!"
" echom：打印的信息是会被保存到消息列表的，后续可通过:messages 命令进行查看。
:echom "Hello again, world!"
" echoerr：打印错误信息，文本背景以红色进行强调，且打印的信息是会被保存到消息列表的，后续可通过:messages 命令进行查看。
:echoerr "show error message!"