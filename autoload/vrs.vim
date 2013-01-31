let s:vrs_patterns = {}

function! vrs#set(name, pattern)
  let s:vrs_patterns[a:name] = a:pattern
endfunction

function! vrs#get(name)
  return s:vrs_patterns[a:name]
endfunction

function! vrs#match(string, pattern, ...)
  let args = extend([a:string, vrs#get(a:pattern)], a:000)
  return call('match', args)
endfunction

function! vrs#matches(string, pattern, ...)
  return call('vrs#match', extend([a:string, a:pattern], a:000)) != -1
endfunction

for pfile in split(glob(expand('<sfile>:p:h:h') . '/patterns/*.vim'), "\n")
  exe "source " . pfile
endfor
