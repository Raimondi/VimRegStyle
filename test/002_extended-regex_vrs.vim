call vimtest#StartTap()
call vimtap#Plan(16 + 7) " <== XXX  Keep plan number updated.  XXX

let erex = ExtendedRegexObject('vrs#get')

let t = '\<\%{_ip4_segment,4,.}\>'
let t_expanded = '\<\%(25[0-5]\|2[0-4]\d\|[01]\?\d\d\?\)\.\%(25[0-5]\|2[0-4]\d\|[01]\?\d\d\?\)\.\%(25[0-5]\|2[0-4]\d\|[01]\?\d\d\?\)\.\%(25[0-5]\|2[0-4]\d\|[01]\?\d\d\?\)\>'

call vimtap#Is(erex.expand_composition_atom(t), t_expanded, 'expand _ip4_segment')
call vimtap#Is(erex.expand_composition_atom('\%{_ip4_segment,2,.}'), '\%(25[0-5]\|2[0-4]\d\|[01]\?\d\d\?\)\.\%(25[0-5]\|2[0-4]\d\|[01]\?\d\d\?\)', 'explicit count of 2 and explicit sep of dot')
call vimtap#Is(erex.expand_composition_atom('\%{funcs,1,}'), '^\s*function!\?\s*\(.\{-}\)(', 'explicit count of 1 and explicitly empty sep')
call vimtap#Is(erex.expand_composition_atom('\%{funcs,1}'), '^\s*function!\?\s*\(.\{-}\)(', 'explicit count of 1 and implicit sep')
call vimtap#Is(erex.expand_composition_atom('\%{funcs}'), '^\s*function!\?\s*\(.\{-}\)(', 'implicitly expand name only')
call vimtap#Is(erex.expand_composition_atom('\%{funcs,2,}'), '^\s*function!\?\s*\(.\{-}\)(^\s*function!\?\s*\(.\{-}\)(', 'explicit count and explicitly empty sep')
call vimtap#Is(erex.expand_composition_atom('\%{funcs,2}'), '^\s*function!\?\s*\(.\{-}\)(^\s*function!\?\s*\(.\{-}\)(', 'explicit count, implicit sep')
call vimtap#Is(erex.expand_composition_atom('\%{funcs,3,\n}'), '^\s*function!\?\s*\(.\{-}\)(\n^\s*function!\?\s*\(.\{-}\)(\n^\s*function!\?\s*\(.\{-}\)(', 'explicit literal sep')

call vimtap#Is(erex.parse(t), t_expanded, 'expand _ip4_segment')
call vimtap#Is(erex.parse('\%{_ip4_segment,2,.}'), '\%(25[0-5]\|2[0-4]\d\|[01]\?\d\d\?\)\.\%(25[0-5]\|2[0-4]\d\|[01]\?\d\d\?\)', 'explicit count of 2 and explicit sep of dot')
call vimtap#Is(erex.parse('\%{funcs,1,}'), '^\s*function!\?\s*\(.\{-}\)(', 'explicit count of 1 and explicitly empty sep')
call vimtap#Is(erex.parse('\%{funcs,1}'), '^\s*function!\?\s*\(.\{-}\)(', 'explicit count of 1 and implicit sep')
call vimtap#Is(erex.parse('\%{funcs}'), '^\s*function!\?\s*\(.\{-}\)(', 'expand name only')
call vimtap#Is(erex.parse('\%{funcs,2,}'), '^\s*function!\?\s*\(.\{-}\)(^\s*function!\?\s*\(.\{-}\)(', 'explicit count and explicitly empty sep')
call vimtap#Is(erex.parse('\%{funcs,2}'), '^\s*function!\?\s*\(.\{-}\)(^\s*function!\?\s*\(.\{-}\)(', 'explicit count, implicit sep')
call vimtap#Is(erex.parse('\%{funcs,3,\n}'), '^\s*function!\?\s*\(.\{-}\)(\n^\s*function!\?\s*\(.\{-}\)(\n^\s*function!\?\s*\(.\{-}\)(', 'explicit literal sep')

" with spaces

let t = '\<\%{_ip4_segment, 4, .}\>'
call vimtap#Is( erex.parse(t), t_expanded, 'expand _ip4_segment with spaces')
call vimtap#Is( erex.parse('\%{funcs , 1 , }'), '^\s*function!\?\s*\(.\{-}\)(', 'expand explicitly empty sep with spaces')
call vimtap#Is( erex.parse('\%{funcs ,1}'), '^\s*function!\?\s*\(.\{-}\)(', 'expand implicit sep with spaces')
call vimtap#Is( erex.parse('\%{funcs }'), '^\s*function!\?\s*\(.\{-}\)(', 'expand name only with space')
call vimtap#Is( erex.parse('\%{funcs, 2, }'), '^\s*function!\?\s*\(.\{-}\)(^\s*function!\?\s*\(.\{-}\)(', 'expand count of 2 and explicitly empty sep with spaces')
call vimtap#Is( erex.parse('\%{funcs , 2}'), '^\s*function!\?\s*\(.\{-}\)(^\s*function!\?\s*\(.\{-}\)(', 'expand count of 2 and implicit sep with spaces')
call vimtap#Is( erex.parse('\%{ funcs , 3 , \n }'), '^\s*function!\?\s*\(.\{-}\)(\n^\s*function!\?\s*\(.\{-}\)(\n^\s*function!\?\s*\(.\{-}\)(', 'expand count of 3 and explicit of \\n sep with spaces')

call vimtest#Quit()
