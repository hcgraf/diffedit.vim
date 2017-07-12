" vim: set ts=2 sw=2 sts=2 tw=78 et :

function! diffedit#CopyHunk()
  let frombuf = bufnr('%')
  let hunk = s:getCurrentHunk()
  let firstline = getline(hunk[0])
  let header = getbufline(frombuf, hunk[0], hunk[1])
  let content  = getbufline(frombuf, hunk[2], hunk[3])
  wincmd w
  if search('\V' . firstline, 'w') <= 0
    normal G
    call append(line('.'), header)
    normal G
  else
    call g:__textobj_diff.do_by_pattern("move-N","file","n")
  endif
  call append(line('.'), content)
  wincmd w
endfunction

function! diffedit#DeleteHunk()
  let hunk = s:getCurrentHunk()
  exe "silent! ".hunk[2].",".hunk[3]."delete"
endfunction

function! diffedit#MoveHunk()
  call diffedit#CopyHunk()
  call diffedit#DeleteHunk()
endfunction

function! s:getCurrentHunk()
  let origline = line('.')
  call g:__textobj_diff.do_by_pattern("move-p","hunk","n")
  let hstart = line('.')
  call g:__textobj_diff.do_by_pattern("move-N","hunk","n")
  let hend = line('.')
  call g:__textobj_diff.do_by_pattern("move-p","file","n")
  let fstart = line('.')
  call g:__textobj_diff.do_by_pattern("move-n","hunk","n")
  let fend = line('.') - 1
  exe "normal " . origline . "G"
  return [fstart, fend, hstart, hend]
endfunction
