# execute do concatenation but not normal can't do concatenation
```
function! GotoClass(className)
    normal! 1G
    normal! /class\s\+ . a:className<CR>
endfunction
nnoremap <key> :call GotoClass(input('Class name: '))<CR>
```
Now, the most obvious issue is that `:help :normal` can't do concatenation.

A simple fix would be to use `:help :execute`, which does concatenation:
```
function! GotoClass(className)
    normal! 1G
    execute "normal! /class\s\+" . a:className
endfunction
nnoremap <key> :call GotoClass(input('Class name: '))<CR>
```
But we can do better. Instead of abusing `:normal`, which doesn't really add any value here, let's use `:help :/` to replace these two lines:
```
normal! 1G
execute "normal! /class\s\+" . a:className
```
with a single line:
```
function! GotoClass(className)
    execute "1/class\s\+" . a:className
endfunction
nnoremap <key> :call GotoClass(input('Class name: '))<CR>
```
Let's not stop there! Is that custom function really necessary? We could use `:help search()` and get rid of it:
```
nnoremap <key> <Cmd>1call search('class\s\+' . input('Class name: '))<CR>
```
# reference
https://vi.stackexchange.com/questions/41461/how-to-search-within-a-vimscript-function