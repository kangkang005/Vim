# How to select a regexp group in vim?
having this line:
```
bla bla bla [Corso De Stefanis 88 interno 4](address) blabla
```
search and highlight this string in square brackets.
```
Corso De Stefanis 88 interno 4
```
this is solution:
```
/\[\zs.\{-}\ze\]
```
In a sense, capture group seems not working, but you can select the "group" preceding sequence by `\zs` and finishing with `\ze`. vim regexp syntax is weird for me.