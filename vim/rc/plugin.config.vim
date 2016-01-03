let s:plugin_config_dir =
      \ dotfile_util#normpath('rc'. g:pathsep . 'plugin.config', 'config')
      \ . g:pathsep
call dotfile_util#source(s:plugin_config_dir . 'lightline.vim')
call dotfile_util#source(s:plugin_config_dir . 'complete.vim')
call dotfile_util#source(s:plugin_config_dir . 'unite.vim')
call dotfile_util#source(s:plugin_config_dir . 'vimfiler.vim')

" sudo
if neobundle#tap('sudo.vim')
  function! neobundle#hooks.on_source(bundle) abort
    cabbr w!! :w sudo:%
  endfunction
  call neobundle#untap()
endif

" tagbar
if neobundle#tap('tagbar')
  function! neobundle#hooks.on_source(bundle) abort
    let g:tagbar_width = 40
    nnoremap <silent> [toggle]t :<C-u>TagbarToggle<CR>
  endfunction
  call neobundle#untap()
endif

" choosewin
if neobundle#tap('vim-choosewin')
  function! neobundle#hooks.on_source(bundle) abort
    let g:choosewin_overlay_enable = 1
    let g:choosewin_overlay_clear_multibyte = 1
    nmap - <Plug>(choosewin)
  endfunction
  call neobundle#untap()
endif

" capslock
if neobundle#tap('vim-capslock')
  function! neobundle#hooks.on_source(bundle) abort
    nnoremap <silent> [toggle]c <Plug>CapsLockToggle
  endfunction
  call neobundle#untap()
endif

" easy-align
if neobundle#tap('vim-easy-align')
  function! neobundle#hooks.on_source(bundle) abort
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)
  endfunction
  call neobundle#untap()
endif

" echodoc
if neobundle#tap('echodoc.vim')
  function! neobundle#hooks.on_source(bundle) abort
    set noshowmode
    let g:echodoc_enable_at_startup = 1
  endfunction
  call neobundle#untap()
endif

" vim-anzu
if neobundle#tap('vim_anzu')
  function! neobundle#hooks.on_source(bundle) abort
    let g:anzu_enable_CursorMoved_AnzuUpdateSearchStatus = 1
  endfunction
  call neobundle#untap()
endif

" unified-diff
if neobundle#tap('vim-unified-diff')
  function! neobundle#hooks.on_source(bundle) abort
    set diffexpr=unified_diff#diffexpr()
  endfunction
  call neobundle#untap()
endif

" unified-diff
if neobundle#tap('vim-unified-diff') && executable('git')
  function! neobundle#hooks.on_source(bundle) abort
    let unified_diff#arguments = [
          \   'diff',
          \   '--no-index',
          \   '--no-color',
          \   '--no-ext-diff',
          \   '--unified=0',
          \   '--histogram',
          \ ]
    set diffexpr=unified_diff#diffexpr()
  endfunction
  call neobundle#untap()
endif

" repeat
if neobundle#tap('vim-repeat')
  function! neobundle#hooks.on_source(bundle) abort
    nmap .     <Plug>(repeat-.)
    nmap u     <Plug>(repeat-u)
    nmap U     <Plug>(repeat-U)
    nmap <C-r> <Plug>(repeat-<C-r>)
    nmap g-    <Plug>(repeat-g-)
    nmap g+    <Plug>(repeat-g+)
  endfunction
  call neobundle#untap()
endif

" operator-surround
if neobundle#tap('vim-operator-surround')
  function! neobundle#hooks.on_source(bundle) abort
    map <silent>sa <Plug>(operator-surround-append)
    map <silent>sd <Plug>(operator-surround-delete)
    map <silent>sr <Plug>(operator-surround-replace)
  endfunction
  call neobundle#untap()
endif

" operator-flashy
if neobundle#tap('vim-operator-flashy')
  function! neobundle#hooks.on_source(bundle) abort
    map y <Plug>(operator-flashy)
    nmap Y <Plug>(operator-flashy)$
  endfunction
  call neobundle#untap()
endif

" committia
if neobundle#tap('committia.vim')
  function! neobundle#hooks.on_source(bundle) abort
    let g:committia_hooks = {}
    function! g:committia_hooks.edit_open(info)
      setlocal spell
    endfunction
  endfunction
  call neobundle#untap()
endif
