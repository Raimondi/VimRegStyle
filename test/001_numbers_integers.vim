call vimtest#StartTap()
call vimtap#Plan(35) " <== XXX  Keep plan number updated.  XXX

" hundredths      vim   \<\%(\d\|[1-9]\d\)\>
" z_hundredths    vim   \<\d\{2}\>
" thousandths     vim   \<\%(\%{hundredths}\|[1-9]\d\d\)\>
" z_thousandths   vim   \<\d\{3}\>

call vimtap#Is(vrs#matches('0',     'natural'),     1,  'natural - int')
call vimtap#Is(vrs#matches('1',     'natural'),     1,  'natural - int')
call vimtap#Is(vrs#matches('99',    'natural'),     1,  'natural - int')
call vimtap#Is(vrs#matches('123',   'natural'),     1,  'natural - int')
call vimtap#Is(vrs#matches('+1',    'natural'),     1,  'natural + posint')
call vimtap#Is(vrs#matches('-1',    'natural'),     0,  'natural - negint')
call vimtap#Is(vrs#matches('',      'natural'),     0,  'natural - empty')
call vimtap#Is(vrs#matches('a',     'natural'),     0,  'natural - char')

call vimtap#Is(vrs#matches('0',     'integer'),     1,  'integer + int')
call vimtap#Is(vrs#matches('1',     'integer'),     1,  'integer + int')
call vimtap#Is(vrs#matches('99',    'integer'),     1,  'integer + int')
call vimtap#Is(vrs#matches('123',   'integer'),     1,  'integer + int')
call vimtap#Is(vrs#matches('-1',    'integer'),     1,  'integer + negint')
call vimtap#Is(vrs#matches('-99',   'integer'),     1,  'integer + negint')
call vimtap#Is(vrs#matches('-123',  'integer'),     1,  'integer + negint')
call vimtap#Is(vrs#matches('+1',    'integer'),     1,  'integer + posint')
call vimtap#Is(vrs#matches('+99',   'integer'),     1,  'integer + posint')
call vimtap#Is(vrs#matches('+123',  'integer'),     1,  'integer + posint')
call vimtap#Is(vrs#matches('',      'integer'),     0,  'integer - empty')
call vimtap#Is(vrs#matches('a',     'integer'),     0,  'integer - char')
call vimtap#Is(vrs#matches('1.0',   'integer'),     0,  'integer - float')

call vimtap#Is(vrs#matches('0',     'hundredths'),  1,  'hundredths - int')
call vimtap#Is(vrs#matches('00',    'hundredths'),  1,  'hundredths - int')
call vimtap#Is(vrs#matches('000',   'hundredths'),  1,  'hundredths - int')
call vimtap#Is(vrs#matches('1',     'hundredths'),  1,  'hundredths - int')
call vimtap#Is(vrs#matches('01',    'hundredths'),  1,  'hundredths - int')
call vimtap#Is(vrs#matches('001',   'hundredths'),  1,  'hundredths - int')
call vimtap#Is(vrs#matches('22',    'hundredths'),  1,  'hundredths - int')
call vimtap#Is(vrs#matches('333',   'hundredths'),  1,  'hundredths - int')
call vimtap#Is(vrs#matches('999',   'hundredths'),  1,  'hundredths - upperbound int')
call vimtap#Is(vrs#matches('1000',  'hundredths'),  0,  'hundredths - overbounds')
call vimtap#Is(vrs#matches('',      'hundredths'),  0,  'hundredths - empty')
call vimtap#Is(vrs#matches('a',     'hundredths'),  0,  'hundredths - char')

call vimtest#Quit()
