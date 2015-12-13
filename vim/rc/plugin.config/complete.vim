let hooks = neobundle#get_hooks('deoplete.nvim')
function! hooks.on_source(bundle)
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use deoplete
  let g:deoplete#enable_at_startup = 1
  " Use smartcase.
  let g:deoplete_enable_smart_case = 1
endfunction

let hooks = neobundle#get_hooks('neocomplete.vim')
function! hooks.on_source(bundle)
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
endfunction

let hooks = neobundle#get_hooks('neocomplcache.vim')
function! hooks.on_source(bundle)
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplcache.
  let g:neocomplcache_enable_at_startup = 1
  " Use smartcase.
  let g:neocomplcache_enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
endfunction
