function! GoBackToRecentBuffer()
  let startName = bufname('%')
  while 1
    exe "normal! \<c-o>"
    let nowName = bufname('%')
    if nowName != startName
      break
    endif
  endwhile
endfunction

nnoremap <silent> <C-U> :call GoBackToRecentBuffer()<Enter>

" Issues:
" If there is no previous buffer, it will continue silently looping until you hit CTRL-C!

" Related:
" :jumps lists the historical locations that CTRL-O will step back through.
" Vim's default CTRL-T is a good alternative to mashing CTRL-O, because it is coarser grained: it moves back through tag jumps only.