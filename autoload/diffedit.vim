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
  call s:sortHunks()
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

function! s:getCurrentFile()
  let origpos = getpos('.')
  call g:__textobj_diff.do_by_pattern("move-p","file","n")
  let filestart = line('.')
  call g:__textobj_diff.do_by_pattern("move-n","hunk","n")
  let firsthunk = line('.')
  call g:__textobj_diff.do_by_pattern("move-p","file","n")
  call g:__textobj_diff.do_by_pattern("move-N","file","n")
  let fileend = line('.')
  call setpos('.',origpos)
  return [filestart, fileend, firsthunk]
endfunction

function! s:getCurrentHunk()
  let origpos = getpos('.')
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
  call setpos('.',origpos)
  return [headstart, headend, hunkstart, hunkend, fileend]
endfunction

function! s:sortHunks()
  let origpos = getpos('.')
  let curfile = s:getCurrentFile()
  " idea: reduce hunks to one line, replacing \n by C-v C-j (NL),
  " sorting, replacing back
  call cursor(curfile[1],1)
  while line('.') > curfile[2]
    let end = line('.') - 1
    call g:__textobj_diff.do_by_pattern("move-p","hunk","n")
    let start = line('.')
    exe "silent! ".start.",".end."substitute/\\n/\<C-v>\<C-j>/"
    call g:__textobj_diff.do_by_pattern("move-P","hunk","n")
  endwhile
  call cursor(curfile[1],1)
  call g:__textobj_diff.do_by_pattern("move-N","file","n")
  let newend = line('.')
  exe "silent! ".curfile[2].",".newend."sort"
  exe "silent! ".curfile[2].",".newend."substitute/\<C-v>\<C-j>/\\r/g"
  call setpos('.',origpos)
endfunction
