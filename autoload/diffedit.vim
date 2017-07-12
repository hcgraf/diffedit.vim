" vim: set ts=2 sw=2 sts=2 tw=78 et :

function! diffedit#CopyHunk()
  let hunk = s:getCurrentHunk()
  echo hunk
endfunction

function! diffedit#DeleteHunk()
  let hunk = s:getCurrentHunk()
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
