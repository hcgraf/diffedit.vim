" vim: set ts=2 sw=2 sts=2 tw=78 et :

if exists("g:loaded_diffedit_plugin")
  finish
endif
let g:loaded_diffedit_plugin = 1

noremap <Leader>hm :call diffedit#MoveHunk()<CR>
noremap <Leader>hc :call diffedit#CopyHunk()<CR>
