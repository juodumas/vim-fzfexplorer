if exists('g:loaded_fzfexplorer')
  finish
endif
let g:loaded_fzfexplorer = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:explorer_sink(startdir, bang, fzf_common_sink, selected)
  if empty(a:selected)
    return
  endif
  let action = a:selected[0]
  let selection = a:selected[1]
  let path = join([a:startdir, selection], "/")
  if isdirectory(path)
    call fzfexplorer#start(path, a:bang)
  else
    call a:fzf_common_sink([action, path])
  endif
endfunction

function! fzfexplorer#start(startdir, bang)
  let startdir = a:startdir
  if empty(startdir)
    let startdir = getcwd()
  endif
  let s:spec = fzf#wrap({
        \ 'source': 'ls --group-directories-first --ignore=. -pa1 ' . fzf#shellescape(startdir),
        \ 'options': ['--tac', '--no-sort', '--no-multi']
        \ }, a:bang)
  let s:fzf_common_sink = s:spec['sink*']
  echom s:spec
  let s:spec['sink*'] = function('s:explorer_sink', [startdir, a:bang, s:fzf_common_sink])
  call fzf#run(s:spec)
endfunction

command! -bang -nargs=? -complete=file FZFExplore call fzfexplorer#start(<q-args>, <bang>0)

let &cpo = s:save_cpo
unlet s:save_cpo
