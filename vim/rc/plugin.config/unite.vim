let hooks = neobundle#get_hooks('unite.vim')
function! hooks.on_source(bundle)
  " start unite in normal mode
  let g:unite_enable_start_insert = 1

  " use vimfiler to open directories
  call unite#custom_default_action('directory',     'vimfiler')
  call unite#custom_default_action('directory_mru', 'vimfiler')

  " unite specific key mappings
  autocmd MyAutoCmd FileType unite call s:unite_settings()
  function! s:unite_settings()
    imap <buffer> <C-j>      <Plug>(unite_select_next_line)
    imap <buffer> <C-k>      <Plug>(unite_select_previous_line)
    imap <buffer> <Esc><Esc> <Plug>(unite_exit)
    nmap <buffer> <Esc>      <Plug>(unite_exit)
  endfunction

  nnoremap [unite] <Nop>
  nmap U [unite]

  " Unite default
  nnoremap <silent> [unite]b  :<C-u>Unite buffer<CR>
  nnoremap <silent> [unite]d  :<C-u>Unite directory<CR>
  nnoremap <silent> [unite]f  :<C-u>Unite file<CR>
  nnoremap <silent> [unite]g  :<C-u>Unite grep/git<CR>
  nnoremap <silent> [unite]s  :<C-u>Unite source<CR>
  nnoremap <silent> [unite]t  :<C-u>Unite tab<CR>
  nnoremap <silent> [unite]w  :<C-u>Unite window<CR>

  " Unite plugins
  nnoremap <silent> [unite]du :<C-u>Unite directory_mru<CR>
  nnoremap <silent> [unite]fu :<C-u>Unite file_mru<CR>
  nnoremap <silent> [unite]gt :<C-u>Unite gtags/
  nnoremap <silent> [unite]m  :<C-u>Unite mark<CR>
  nnoremap <silent> [unite]o  :<C-u>Unite outline<CR>
  nnoremap <silent> [unite]qf :<C-u>Unite -no-quit -direction=botright quickfix<CR>
  nnoremap <silent> [unite]ra :<C-u>Unite rails/
  nnoremap <silent> [unite]ta :<C-u>Unite tag/
  nnoremap <silent> [unite]wc :<C-u>Unite webcolorname<CR>
  nnoremap <silent> [unite]y  :<C-u>Unite history/yank<CR>
endfunction

