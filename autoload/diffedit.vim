" vim: set ts=2 sw=2 sts=2 tw=78 et :

function! diffedit#MoveHunk()
  let hunk = s:getCurrentHunk()
  echo hunk
endfunction

function! s:getCurrentHunk()
  let origline = line('.')
  let leader = get(g:, "mapleader", "\\")
  exe "normal " . leader . 'dk'
  let hstart = line('.')
  exe "normal " . leader . 'dJ'
  let hend = line('.')
  exe "normal " . leader . 'dfk'
  let fstart = line('.')
  exe "normal " . leader . 'djk'
  let fend = line('.')
  exe "normal " . origline . "G"
  return [fstart, fend, hstart, hend]
endfunction
