function! extended_regex#ExtendedRegex(...)
  let erex = {}
  let erex.lookup_function = ''

  func erex.default_lookup(name) dict
    return eval(a:name)
  endfunc

  func erex.lookup(name) dict
    if empty(self.lookup_function)
      return call(self.default_lookup, [a:name], self)
    else
      return call(self.lookup_function, [a:name])
    endif
  endfunc

  func erex.expand_composition_atom(ext_reg) dict
    let ext_reg = a:ext_reg
    let composition_atom = '\\%{\s*\([^,} \t]\+\)\%(\s*,\s*\(\d\+\)\%(\s*,\s*\(.\{-}\)\)\?\)\?\s*}'
    let remaining = match(ext_reg, composition_atom)
    while remaining != -1
      let [_, name, cnt, sep ;__] = matchlist(ext_reg, composition_atom)
      let cnt = cnt ? cnt : 1
      let sep = escape(escape(sep, '.*[]$^'), '\\')
      let pattern = escape(self.lookup(name), '\\' )
      let ext_reg = substitute(ext_reg, composition_atom, join(repeat([pattern], cnt), sep), '')
      let remaining = match(ext_reg, composition_atom)
    endwhile
    return ext_reg
  endfunc

  func erex.expand(ext_reg) dict
    return self.expand_composition_atom(a:ext_reg)
  endfunc

  func erex.parse_multiline_regex(ext_reg) dict
    return substitute(substitute(a:ext_reg, '# \S\+', '', 'g'), '\\\@<! ', '', 'g')
  endfunc

  " common public API

  func erex.register_lookup(callback) dict
    let self.lookup_function = a:callback
  endfunc

  func erex.parse(ext_reg) dict
    return self.expand(self.parse_multiline_regex(a:ext_reg))
  endfunc

  if a:0
    call erex.register_lookup(a:1)
  endif

  return erex
endfunction
