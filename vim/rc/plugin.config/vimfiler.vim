let s:hooks = neobundle#get_hooks('vimfiler')

function! s:hooks.on_source(bundle)
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_enable_auto_cd = 1

  " vimfiler specific key mappings
  autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
  function! s:vimfiler_settings()
    " use R to refresh
    nmap <buffer> R <Plug>(vimfiler_redraw_screen)
    " overwrite C-l ignore <Plug>(vimfiler_redraw_screen)
    nmap <buffer> <C-l> <C-w>l
  endfunction
endfunction

function! s:exec_vimfiler()
  VimFiler -split -simple -winwidth=30 -no-quit
  setl nonumber
  execute('normal .')
endfunction

function! s:exec_vimfiler_on_vimenter()
  call s:exec_vimfiler()
  wincmd l
  if expand('%') == ''
    wincmd h
  endif
endfunction
command! ExecVimFiler :call s:exec_vimfiler()
nnoremap <Leader>e :<C-u>ExecVimFiler<CR>
autocmd MyAutoCmd VimEnter * call s:exec_vimfiler_on_vimenter()
