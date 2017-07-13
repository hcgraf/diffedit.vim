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
  if ((hunk[1]+1) == hunk[2]) && (hunk[3] == hunk[4]) " only hunk in this file
    exe "silent! ".hunk[0].",".hunk[3]."delete"
  else
    exe "silent! ".hunk[2].",".hunk[3]."delete"
  endif
endfunction

function! diffedit#MoveHunk()
  call diffedit#CopyHunk()
  call diffedit#DeleteHunk()
endfunction

function! s:getCurrentHunk()
  let origline = line('.')
  call g:__textobj_diff.do_by_pattern("move-p","hunk","n")
  let hunkstart = line('.')
  call g:__textobj_diff.do_by_pattern("move-N","hunk","n")
  let hunkend = line('.')
  call g:__textobj_diff.do_by_pattern("move-p","file","n")
  let headstart = line('.')
  call g:__textobj_diff.do_by_pattern("move-n","hunk","n")
  let headend = line('.') - 1
  call g:__textobj_diff.do_by_pattern("move-p","file","n")
  call g:__textobj_diff.do_by_pattern("move-N","file","n")
  let fileend = line('.')
  exe "normal " . origline . "G"
  return [headstart, headend, hunkstart, hunkend, fileend]
endfunction
