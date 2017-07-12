" vim: set ts=2 sw=2 sts=2 tw=78 et :

if exists("g:loaded_diffedit_plugin")
  finish
endif
let g:loaded_diffedit_plugin = 1

nnoremap <silent> <Leader>hp :call g:__textobj_diff.do_by_pattern("move-p","hunk","n")<CR>zz
nnoremap <silent> <Leader>hn :call g:__textobj_diff.do_by_pattern("move-n","hunk","n")<CR>zz

nnoremap <silent> <Leader>hc :call diffedit#CopyHunk()<CR>
nnoremap <silent> <Leader>hm :call diffedit#MoveHunk()<CR>
nnoremap <silent> <Leader>hm :call diffedit#DeleteHunk()<CR>
