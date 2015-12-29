let s:plugin_config_dir =
      \ dotfile_util#normpath('rc'. g:pathsep . 'plugin.config', 'config')
      \ . g:pathsep
call dotfile_util#source(s:plugin_config_dir . 'complete.vim')
call dotfile_util#source(s:plugin_config_dir . 'unite.vim')
call dotfile_util#source(s:plugin_config_dir . 'vimfiler.vim')

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

" Gundo
if neobundle#tap('gundo.vim')
  function! neobundle#hooks.on_source(bundle) abort
    nnoremap <silent> [toggle]g :<C-u>GundoToggle<CR>
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

" incsearch
if neobundle#tap('incsearch.vim')
  function! neobundle#hooks.on_source(bundle) abort
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
