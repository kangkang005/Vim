" toggle hightlight syntax
function! ToggleSyntax()
   if exists("g:syntax_on")
      syntax off
      echo "syntax off"
   else
      syntax enable
      echo "syntax enable"
   endif
endfunction

nmap <silent>  ;s  :call ToggleSyntax()<CR>