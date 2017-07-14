" vim: set ts=2 sw=2 sts=2 tw=78 et :

if exists("g:loaded_diffedit_plugin")
  finish
endif
let g:loaded_diffedit_plugin = 1

nnoremap <unique> <silent> <Leader>hp :call g:__textobj_diff.do_by_pattern("move-p","hunk","n")<CR>zz
nnoremap <unique> <silent> <Leader>hn :call g:__textobj_diff.do_by_pattern("move-n","hunk","n")<CR>zz
nnoremap <unique> <silent> <Leader>fp :call g:__textobj_diff.do_by_pattern("move-p","file","n")<CR>zz
nnoremap <unique> <silent> <Leader>fn :call g:__textobj_diff.do_by_pattern("move-n","file","n")<CR>zz

nnoremap <unique> <silent> <Leader>hc :call diffedit#CopyHunk()<CR>
nnoremap <unique> <silent> <Leader>hm :call diffedit#MoveHunk()<CR>
nnoremap <unique> <silent> <Leader>hd :call diffedit#DeleteHunk()<CR>

nnoremap <unique> <silent> <Leader>fc :call diffedit#CopyFile()<CR>
nnoremap <unique> <silent> <Leader>fm :call diffedit#MoveFile()<CR>
nnoremap <unique> <silent> <Leader>fd :call diffedit#DeleteFile()<CR>
