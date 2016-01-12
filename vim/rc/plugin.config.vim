let s:plugin_config_dir =
      \ g:util#normpath('rc'. g:pathsep . 'plugin.config', 'config')
      \ . g:pathsep
call g:util#source(s:plugin_config_dir . 'lightline.vim')
call g:util#source(s:plugin_config_dir . 'complete.vim')
call g:util#source(s:plugin_config_dir . 'unite.vim')
call g:util#source(s:plugin_config_dir . 'vimfiler.vim')

" sudo
if g:neobundle#tap('sudo.vim')
  function! g:neobundle#hooks.on_source(bundle) abort
    cabbr w!! :w sudo:%
  endfunction
  call g:neobundle#untap()
endif

" tagbar
if g:neobundle#tap('tagbar')
  function! g:neobundle#hooks.on_source(bundle) abort
    let g:tagbar_width = 40
    nnoremap <silent> [toggle]t :<C-u>TagbarToggle<CR>
  endfunction
  call g:neobundle#untap()
endif

" choosewin
if g:neobundle#tap('vim-choosewin')
  function! g:neobundle#hooks.on_source(bundle) abort
    let g:choosewin_overlay_enable = 1
    let g:choosewin_overlay_clear_multibyte = 1
    nmap - <Plug>(choosewin)
  endfunction
  call g:neobundle#untap()
endif

" capslock
if g:neobundle#tap('vim-capslock')
  function! g:neobundle#hooks.on_source(bundle) abort
    nnoremap <silent> [toggle]c <Plug>CapsLockToggle
  endfunction
  call g:neobundle#untap()
endif

" easy-align
if g:neobundle#tap('vim-easy-align')
  function! g:neobundle#hooks.on_source(bundle) abort
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)
  endfunction
  call g:neobundle#untap()
endif

" echodoc
if g:neobundle#tap('echodoc.vim')
  function! g:neobundle#hooks.on_source(bundle) abort
    set noshowmode
    let g:echodoc_enable_at_startup = 1
  endfunction
  call g:neobundle#untap()
endif

" vim-anzu
if g:neobundle#tap('vim_anzu')
  function! g:neobundle#hooks.on_source(bundle) abort
    let g:anzu_enable_CursorMoved_AnzuUpdateSearchStatus = 1
  endfunction
  call g:neobundle#untap()
endif

" unified-diff
if g:neobundle#tap('vim-unified-diff') && executable('git')
  function! g:neobundle#hooks.on_source(bundle) abort
    let g:unified_diff#arguments = [
          \   'diff',
          \   '--no-index',
          \   '--no-color',
          \   '--no-ext-diff',
          \   '--unified=0',
          \   '--histogram',
          \ ]
    set diffexpr=unified_diff#diffexpr()
  endfunction
  call g:neobundle#untap()
endif

" operator-surround
if g:neobundle#tap('vim-operator-surround')
  function! g:neobundle#hooks.on_source(bundle) abort
    map <silent>sa <Plug>(operator-surround-append)
    map <silent>sd <Plug>(operator-surround-delete)
    map <silent>sr <Plug>(operator-surround-replace)
  endfunction
  call g:neobundle#untap()
endif

" operator-flashy
if g:neobundle#tap('vim-operator-flashy')
  function! g:neobundle#hooks.on_source(bundle) abort
    map y <Plug>(operator-flashy)
    nmap Y <Plug>(operator-flashy)$
  endfunction
  call g:neobundle#untap()
endif

" committia
if g:neobundle#tap('committia.vim')
  function! g:neobundle#hooks.on_source(bundle) abort
    let g:committia_hooks = {}
    function! g:committia_hooks.edit_open(info)
      setlocal spell
    endfunction
  endfunction
  call g:neobundle#untap()
endif

" caw
if g:neobundle#tap('caw.vim')
  function! g:neobundle#hooks.on_source(bundle) abort
    nmap <Leader>c <Plug>(caw:i:toggle)
    vmap <Leader>c <Plug>(caw:i:toggle)
  endfunction
  call g:neobundle#untap()
endif

" neosnippet
if g:neobundle#tap('neosnippet.vim')
  function! g:neobundle#hooks.on_source(bundle) abort
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)
    if has('conceal')
      set conceallevel=2 concealcursor=niv
    endif
  endfunction
  call g:neobundle#untap()
endif

" textobj-multiblock
if g:neobundle#tap('vim-textobj-multiblock')
  omap ab <Plug>(textobj-multiblock-a)
  omap ib <Plug>(textobj-multiblock-i)
  xmap ab <Plug>(textobj-multiblock-a)
  xmap ib <Plug>(textobj-multiblock-i)
  call g:neobundle#untap()
endif

" operator-replace
if g:neobundle#tap('vim-operator-replace')
  map gr <Plug>(operator-replace)
  call g:neobundle#untap()
endif

" operator-surround
if g:neobundle#tap('vim-operator-surround')
  function! g:neobundle#hooks.on_source(bundle) abort
    " add ```...``` surround when filetype is markdown
    let g:operator#surround#blocks = {
        \ 'markdown' : [
        \   {
        \     'block' : ['```\n', '\n```'],
        \     'motionwise' : ['line'],
        \     'keys' : ['`']
        \   },
        \ ]}
  endfunction

  map gsa <Plug>(operator-surround-append)
  map gsd <Plug>(operator-surround-delete)
  map gsr <Plug>(operator-surround-replace)

  nmap gsdd
        \ <Plug>(operator-surround-delete)<Plug>(textobj-multiblock-a)
  nmap gsrr
        \ <Plug>(operator-surround-replace)<Plug>(textobj-multiblock-a)
  vmap gsdd
        \ <Plug>(operator-surround-delete)<Plug>(textobj-multiblock-a)
  vmap gsrr
        \ <Plug>(operator-surround-replace)<Plug>(textobj-multiblock-a)
  call g:neobundle#untap()
endif

" undotree
if g:neobundle#tap('undotree')
  nnoremap [toggle]u :<C-u>UndotreeToggle<CR>

  call g:neobundle#untap()
endif

if g:neobundle#tap('vim-quickrun')
  function! g:neobundle#hooks.on_source(bundle) abort
    let g:quickrun_config = get(g:, 'quickrun_config', {})
    let g:quickrun_config['_'] = {
          \ 'runner' : 'vimproc',
          \ 'outputter/buffer/split': ':botright 8sp',
          \ 'outputter/buffer/close_on_empty': 1,
          \ 'hook/time/enable': 1,
          \}
    " Terminate the quickrun with <C-c>
    nnoremap <expr><silent> <C-c> quickrun#is_running()
          \ ? quickrun#sweep_sessions() : "\<C-c>"
  endfunction

  nnoremap <Plug>(my-quickrun) <Nop>
  nmap <LocalLeader>r <Plug>(my-quickrun)
  nmap <Plug>(my-quickrun) <Plug>(quickrun)

  call g:neobundle#untap()
endif

" watchdogs
if g:neobundle#tap('vim-watchdogs')
  function! g:neobundle#hooks.on_source(bundle) abort
    let g:watchdogs_check_CursorHold_enable = 0
    let g:watchdogs_check_BufWritePost_enable = 0
    let g:watchdogs_check_BufWritePost_enables = {
      \ 'vim': 1,
      \ 'python': 1,
      \ 'javascript': 1,
      \ 'scala': 1,
      \ 'ruby': 1,
      \}
    let g:watchdogs_check_BufWritePost_enable_on_wq = 0

    let g:quickrun_config = get(g:, 'quickrun_config', {})
    let g:quickrun_config = extend(g:quickrun_config, {
      \ 'watchdogs_checker/_': {
      \   'runner/vimproc/updatetime': 40,
      \   'outputter/quickfix/open_cmd': '',
      \   'hook/qfstatusline_update/enable_exit': 1,
      \   'hook/qfstatusline_update/priority_exit': 4,
      \   'hook/qfsigns_update/enable_exit': 1,
      \   'hook/qfsigns_update/priority_exit': 3,
      \ }
      \})
    if executable('vint')
      let g:quickrun_config['watchdogs_checker/vint'] = {
            \ 'command': 'vint',
            \ 'exec'   : '%c %o %s:p',
            \}
      let g:quickrun_config['vim/watchdogs_checker'] = {
            \ 'type': 'watchdogs_checker/vint',
            \}
    endif
    if executable('flake8')
      let g:quickrun_config['watchdogs_checker/pyflakes'] = {
          \ 'command': 'flake8',
          \}
    endif
    call g:watchdogs#setup(g:quickrun_config)

    function! s:run_watchdogs() abort
      for l:ft in keys(g:watchdogs_check_BufWritePost_enables)
        if l:ft == &filetype
          WatchdogsRun
          return 0
        endif
      endfor
      return 0
    endfunction
    autocmd MyAutoCmd BufEnter * call s:run_watchdogs()
  endfunction

  call g:neobundle#untap()
endif

if g:neobundle#tap('vim-qfstatusline')
  function! g:neobundle#hooks.on_source(bundle) abort
    let g:Qfstatusline#UpdateCmd = function('lightline#update')
    let g:Qfstatusline#Text = 0
  endfunction
  call g:neobundle#untap()
endif

if g:neobundle#tap('vim-hier')
  function! g:neobundle#hooks.on_source(bundle) abort
    nnoremap <silent> <Esc><Esc> :<C-u>HierClear<CR>:nohlsearch<CR>
  endfunction
  call g:neobundle#untap()
endif
