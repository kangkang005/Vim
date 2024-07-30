# How to remove tail of line ^M
```
:%s/\r//gc
```
if vim > 7.1
```
:e ++ff=dos
```
if vim <= 7.1
```
:set ff=dos
:%s/\r\+$//e
```