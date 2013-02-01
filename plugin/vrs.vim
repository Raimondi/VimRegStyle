function! s:ex(key, ...) "{{{1
  let pattern = vrs#get(a:key)
  if empty(pattern)
    return ''
  endif
  let dest = a:0 ? a:1 : '@/'
  return 'let ' . dest . ' = ' . string(pattern)
endfunction

" first arg is the name of the pattern, second is the destination of the
" pattern found (defaults to @/.
" TODO add completion support.
command! -nargs=+ VRS exec s:ex(<f-args>)
