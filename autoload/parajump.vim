" parajump - paragraphs move that treat only space line as empty line.
" Version: 0.1.1
" Copyright (C) 2012-2013 deris0126
" License: MIT license  {{{
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

" Public API {{{1

" paragraphs backward that treat only space line as empty line.
function! parajump#backward(mode_p) "{{{2
  call s:paragraph_jump(-1, a:mode_p)
endfunction
"}}}

" paragraphs forward that treat only space line as empty line.
function! parajump#forward(mode_p) "{{{2
  call s:paragraph_jump(1, a:mode_p)
endfunction
"}}}

"}}}

" Private {{{1
" paragraphs move that treat only space line as empty line.
" move forward if direct_p is more than 0.
" move backward is direct_p is less equal than 0.
function! s:paragraph_jump(direct_p, mode_p) "{{{2
  if a:mode_p == 'v'
    " gv at the beginning because current pos is always
    " equal to getpos("'<") if no gv at the beginning.
    normal! gv
  endif

  if getline('.') =~ '^\s*$'
    if a:direct_p > 0
      let pos = searchpos('\S.*\n^\zs\s*$\|\%$', 'W')
    else
      let pos = searchpos('^\s*$\n^.*\S\|\%^', 'bW')
    endif
  else
    let pos = searchpos('^\s*$\|' .
      \ (a:direct_p > 0 ? '\%$' : '\%^'),
      \ a:direct_p > 0 ? 'W' : 'bW')
  endif

  if pos == [0, 0]
    return
  endif

  call setpos('.', [0, pos[0], pos[1], 0])

  try
    normal! zO
  catch
    " ignore E490 error
  endtry

  if a:mode_p == 'v'
    " gv again because zO escape visual mode
    normal! gv
  endif
endfunction
"}}}

"}}}

" __END__ "{{{1
" vim: foldmethod=marker
