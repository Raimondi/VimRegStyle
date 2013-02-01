call vimtest#StartTap()
call vimtap#Plan(7) " <== XXX  Keep plan number updated.  XXX

call extended_regex#register_lookup('VimVar')
let foo = 'bar'
let t = '\<\%{g:foo,4,.}\>'
echo extended_regex#expand_composition_atom(t)

let s:baz = 'one'
let u = '\<\%{s:baz,4,.}\>'
echo extended_regex#expand_composition_atom(u)

call vimtest#Quit()
