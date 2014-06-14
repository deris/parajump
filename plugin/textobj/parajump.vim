" textobj-parajump - Text objects for parajump
" Version: 0.1.2
" Copyright (C) 2013-2014 deris0126
" License: So-called MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}

if exists('g:loaded_textobj_parajump')
  finish
endif


" Public " {{{
call textobj#user#plugin('parajump', {
  \   '-': {
  \     '*sfile*': expand('<sfile>:p'),
  \     'select-a': 'ap',  '*select-a-function*': 's:select_a',
  \     'select-i': 'ip',  '*select-i-function*': 's:select_i'
  \   }
  \ })
" }}}


" Private {{{
function! s:select_a()
  let sel_i = s:select_i()

  if type(sel_i) == type(0)
    return 0
  endif

  let [mode_v, spos, epos] = sel_i

  if getline('.') =~ '\S'
    let epos = searchpos('\m^\s*\n^.*\S\|\%$', 'cnW')
  else
    let epos = searchpos('\m\S.*\n^\s*$\|\%$', 'cnW')
  endif

  return [mode_v, spos, [0, epos[0], epos[1], 0]]
endfunction

function! s:select_i()
  if getline('.') =~ '\S'
    let spos = searchpos('\m^\s*$\n^\zs.*\S\|\%^', 'bcnW')
    let epos = searchpos('\m\S.*\n^\s*$\|\%$', 'cnW')
  else
    let spos = searchpos('\m\S.*\n^\zs\_s*\|\%^', 'bcnW')
    let epos = searchpos('\m\_s*\zs$', 'cnW')
  endif

  if spos == [0, 0] ||
    \epos == [0, 0]
    return 0
  endif

  return ['V', [0, spos[0], spos[1], 0], [0, epos[0], epos[1], 0]]
endfunction
" }}}


let g:loaded_textobj_parajump = 1


" __END__
" vim: foldmethod=marker
