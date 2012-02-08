" parajump - 段落移動(空白のみの行を空行として扱う)
" Version: 0.0.1
" Copyright (C) 2012 deris0126
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

" 段落後方に移動(空白のみの行を空行として扱う)
function! parajump#backward(mode_p) "{{{2
  return parajump#jump(-1, a:mode_p)
endfunction
"}}}

" 段落前方に移動(空白のみの行を空行として扱う)
function! parajump#forward(mode_p) "{{{2
  return parajump#jump(1, a:mode_p)
endfunction
"}}}

"}}}

" Private {{{1
" 段落移動(空白のみの行を空行として扱う)
"  direct_pが0より大きければ前方に向かって
"  上記以外であれば後方に向かって移動する
function! parajump#jump(direct_p, mode_p) "{{{2
  if a:mode_p == 'v'
    normal! gv
  endif

  for i in range(v:count1)
    let l:cur_line = line('.')
    let l:last_line = line('$')

    if s:is_end_of_jump(a:direct_p, l:cur_line, l:last_line)
      break
    endif

    let l:cur_line_str = getline('.')

    " 現在行が空白のみの行かチェック
    if l:cur_line_str =~ "^\\s*$"
      " 空白のみの行をスキップするモード
      let l:skip_space_line = 1
    else
      " 空白のみの行をスキップしないモード
      let l:skip_space_line = 0
    endif

    while 1
      silent! foldopen!
      if a:direct_p > 0
        normal! j
      else
        normal! k
      endif

      if s:is_end_of_jump(a:direct_p, line('.'), l:last_line)
        break
      endif

      let l:tmp_line = getline('.')
      if l:skip_space_line == 1
        if l:tmp_line !~ "^\\s*$"
          " 空白のみの行をスキップするモードでは空白以外の行に
          " なったら空白行をスキップしないモードに移行する
          let l:skip_space_line = 0
        endif
      else
        if l:tmp_line =~ "^\\s*$"
          " 空白のみの行をスキップしないモードでは
          " 空白のみの行で移動を終了する
          break
        endif
      endif
    endwhile
  endfor

  " とりあえず一律0を返す
  return 0
endfunction
"}}}

function! s:is_end_of_jump(direct_p, line_p, last_line_p) "{{{2
  if a:direct_p <= 0 && a:line_p <= 1
    " 先頭行だったら終了
    return 1
  endif
  if a:direct_p > 0 && a:line_p >= a:last_line_p
    " 終端行だったら終了
    return 1
  endif

  return 0
endfunction
"}}}

"}}}

" __END__ "{{{1
" vim: foldmethod=marker
