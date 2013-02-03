" Vim global plugin for short description
" Maintainer:	Barry Arthur <barry.arthur@gmail.com>
" 		Israel Chauca F. <israelchauca@gmail.com>
" Version:	0.1
" Description:	Long description.
" Last Change:	2013-02-03
" License:	Vim License (see :help license)
" Location:	plugin/vrs.vim
" Website:	https://github.com/Raimondi/vrs
"
" See vrs.txt for help.  This can be accessed by doing:
"
" :helptags ~/.vim/doc
" :help vrs

" Vimscript Setup: {{{1
" Allow use of line continuation.
let s:save_cpo = &cpo
set cpo&vim

" load guard
" uncomment after plugin development.
" XXX The conditions are only as examples of how to use them. Change them as
" needed. XXX
"if exists("g:loaded_vrs")
"      \ || v:version < 700
"      \ || v:version == 703 && !has('patch338')
"      \ || &compatible
"  let &cpo = s:save_cpo
"  finish
"endif
"let g:loaded_vrs = 1

" Options: {{{1

" Private Functions: {{{1

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

" Public Interface: {{{1

function! ExtendedRegexObject(...)
  return call('extended_regex#ExtendedRegex', a:000)
endfunction

" Commands: {{{1
" first arg is the name of the pattern, second is the destination of the
" pattern found (defaults to @/.
" TODO add completion support.
command! -nargs=+ VRS exec s:ex(<f-args>)

" Maps: {{{1

nnoremap <leader>re a<C-R>=<SID>get_re()<CR>

" cno <leader>re <C-R>=<SID>get_re()<CR>

" Teardown:{{{1
"reset &cpo back to users setting
let &cpo = s:save_cpo

" vim: set sw=2 sts=2 et fdm=marker:
