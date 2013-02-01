" XXX Should we have the "original" pcre regex in the dict too?
let s:vrs_patterns = {}
let g:vrs_collection = []
let g:vrs_collection_stack = []

function! vrs#set(name, pattern)
  let s:vrs_patterns[a:name] = a:pattern
endfunction

function! vrs#get(name)
  " Allow using a list of names as well.
  return type(a:name) == type("")
        \ ? get(s:vrs_patterns, a:name, '')
        \ : map(a:name, 's:vrs_patterns[v:val]')
endfunction

function! vrs#match(string, pattern, ...)
  let args = extend([a:string, vrs#get(a:pattern)], a:000)
  return call('match', args)
endfunction

function! vrs#matches(string, pattern, ...)
  return call('vrs#match', extend([a:string, a:pattern], a:000)) != -1
endfunction

" XXX Should these two return the filtered dict or just a list of keys?
function! vrs#from_partial(partial)
  return keys(filter(copy(s:vrs_patterns), 'stridx(v:key, a:partial) > -1'))
endfunction

function! vrs#from_sample(sample)
  return keys(filter(copy(s:vrs_patterns), 'a:sample =~# v:val'))
endfunction

" operate on each match within a string
" TODO: allow this to work over a range
"       perhaps make the default callback be a new collection
" example:  :call vrs#each(getline(1, '$'), 'ip4', 'vrs#collect')
function! vrs#each(source, pattern, callback)
  let pattern = vrs#get(a:pattern)
  let remaining = match(a:source, pattern)
  while remaining != -1
    call call(a:callback, [matchlist(a:source, vrs#get(a:pattern), remaining)])
    let remaining = match(a:source, pattern, 1 + remaining)
  endwhile
endfunction

" callback for adding to the current collection
function! vrs#collect(item)
  call add(g:vrs_collection, a:item)
endfunction

" reset the current collection
function! vrs#delete_collection()
  let g:vrs_collection = []
endfunction

" extract a common submatch from the collection (defaults to 0 - the whole match)
function! vrs#slice_collection(...)
  let submatch = a:0 ? a:1 : 0
  return map(copy(g:vrs_collection), 'v:val[' . submatch . ']')
endfunction

" dump the collection submatch (default 0) at cursor point
function! vrs#append_collection(...)
  call append('.', call('vrs#slice_collection', a:000))
endfunction

" save this collection on the stack
function! vrs#push_collection()
  call add(g:vrs_collection_stack, g:vrs_collection)
endfunction

" save this collection and clear it ready for new collection
function! vrs#new_collection()
  call vrs#push_collection()
  call vrs#delete_collection()
endfunction

" restore a saved collection
function! vrs#pop_collection()
  if len(g:vrs_collection_stack) > 0
    let g:vrs_collection = remove(g:vrs_collection_stack, 0)
  else
    let g:vrs_collection = []
  endif
endfunction

" TODO: Add commands for the collection functions to make them simpler to use

" load VRS patterns
for pfile in split(glob(expand('<sfile>:p:h:h') . '/patterns/*.vim'), "\n")
  exe "source " . pfile
endfor
