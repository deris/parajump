" parajump - paragraphs move that treat only space line as empty line.
" Version: 0.1.0
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

if exists('g:loaded_parajump')
  finish
endif

nnoremap <silent> <Plug>(parajump-backward)  :<C-u>call parajump#backward('n')<CR>
nnoremap <silent> <Plug>(parajump-forward)   :<C-u>call parajump#forward('n')<CR>
vnoremap <silent> <Plug>(parajump-backward)  :<C-u>call parajump#backward('v')<CR>
vnoremap <silent> <Plug>(parajump-forward)   :<C-u>call parajump#forward('v')<CR>
onoremap <silent> <Plug>(parajump-backward)  :<C-u>call parajump#backward('o')<CR>
onoremap <silent> <Plug>(parajump-forward)   :<C-u>call parajump#forward('o')<CR>

if !get(g:, 'parajump_no_default_key_mappings', 0)
  map { <Plug>(parajump-backward)
  map } <Plug>(parajump-forward)
endif


let g:loaded_parajump = 1

" __END__
" vim: foldmethod=marker
