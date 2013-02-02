function! ExtendedRegexObject(...)
  return call('extended_regex#ExtendedRegex', a:000)
endfunction

function! s:ex(key, ...) "{{{1
  let pattern = vrs#get(a:key)
  if empty(pattern)
    return ''
  endif
  let dest = a:0 ? a:1 : '@/'
  return 'let ' . dest . ' = ' . string(pattern)
endfunction

function! s:get_re()
  return vrs#get(input('Pattern name: ', '',
        \             'customlist,'.s:SID().'get_names'))
endfunction

function! s:get_names(a, c, p)
  return vrs#from_partial(a:a)
endfunction

function! s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID$')
endfun

" first arg is the name of the pattern, second is the destination of the
" pattern found (defaults to @/.
" TODO add completion support.
command! -nargs=+ VRS exec s:ex(<f-args>)

ino <leader>re <C-R>=<SID>get_re()<CR>

