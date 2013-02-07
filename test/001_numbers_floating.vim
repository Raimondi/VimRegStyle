let match_list = [
      \ '1000',
      \ '1',
      \ '01.',
      \ '1.0',
      \ '.1',
      \ '+1',
      \ '-1.234',
      \ '3.14e2',
      \ '3.14e+14',
      \ '3.14E+14',
      \ '3.14e-14'
      \]

let no_match_list = [
      \ '1.00.0',
      \ '1,0',
      \ '-1. 234',
      \ '3.14 e2',
      \ '3.14 e+14',
      \ '3.14 E+14',
      \ '3.14 e-14'
      \]

call vimtest#StartTap()
call vimtap#Plan(len(match_list) + len(no_match_list))

if !vimtap#Skip(len(no_match_list), 0, 'no exactly().')
for v in no_match_list
  call vimtap#Is(vrs#matches(v, 'floating'), 0, v)
endfor
endif

for v in match_list
  call vimtap#Is(vrs#matches(v, 'floating'), 1, v)
endfor

call vimtest#Quit()
