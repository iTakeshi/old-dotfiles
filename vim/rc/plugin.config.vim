let s:plugin_config_dir =
      \ dotfile_util#normpath('rc'. g:pathsep . 'plugin.config', 'config')
      \ . g:pathsep
call dotfile_util#source(s:plugin_config_dir . 'complete.vim')
call dotfile_util#source(s:plugin_config_dir . 'unite.vim')
call dotfile_util#source(s:plugin_config_dir . 'vimfiler.vim')

" tagbar
let hooks = neobundle#get_hooks('tagbar')
function! hooks.on_source(bundle)
  let g:tagbar_width = 40
  nnoremap <silent> [toggle]t :<C-u>TagbarToggle<CR>
endfunction

" choosewin
let hooks = neobundle#get_hooks('vim-choosewin')
function! hooks.on_source(bundle)
  let g:choosewin_overlay_enable = 1
  let g:choosewin_overlay_clear_multibyte = 1
  nmap - <Plug>(choosewin)
endfunction

" capslock
let hooks = neobundle#get_hooks('vim-capslock')
function! hooks.on_source(bundle)
  nnoremap <silent> [toggle]c <Plug>CapsLockToggle
endfunction

" easy-align
let hooks = neobundle#get_hooks('vim-easy-align')
function! hooks.on_source(bundle)
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
endfunction

" Gundo
let hooks = neobundle#get_hooks('gundo.vim')
function! hooks.on_source(bundle)
  nnoremap <silent> [toggle]g :<C-u>GundoToggle<CR>
endfunction

" echodoc
let hooks = neobundle#get_hooks('echodoc.vim')
function! hooks.on_source(bundle)
  set noshowmode
  let g:echodoc_enable_at_startup = 1
endfunction

" incsearch
let hooks = neobundle#get_hooks('incsearch.vim')
function! hooks.on_source(bundle)
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  function! s:noregexp(pattern) abort
    return '\V' . escape(a:pattern, '\')
  endfunction
  function! s:config() abort
    return {'converters': [function('s:noregexp')]}
  endfunction
  noremap <silent><expr> z/ incsearch#go(<SID>config())
endfunction

" vim-anzu
let hooks = neobundle#get_hooks('vim_anzu')
function! hooks.on_source(bundle)
  let g:anzu_enable_CursorMoved_AnzuUpdateSearchStatus = 1
endfunction

" unified-diff
let hooks = neobundle#get_hooks('vim-unified-diff')
function! hooks.on_source(bundle)
  set diffexpr=unified_diff#diffexpr()
endfunction
