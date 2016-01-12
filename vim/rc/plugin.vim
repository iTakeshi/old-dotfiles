let s:bundle_root    = g:util#normpath('bundle', 'config')
let s:neobundle_root = s:bundle_root . g:pathsep . 'neobundle.vim'
let s:unite_root     = s:bundle_root . g:pathsep . 'unite.vim'
let s:vimproc_root   = s:bundle_root . g:pathsep . 'vimproc.vim'
let s:neobundle_url  = 'https://github.com/Shougo/neobundle.vim'
let s:unite_url      = 'https://github.com/Shougo/unite.vim'
let s:vimproc_url    = 'https://github.com/Shougo/vimproc.vim'

function! s:install_neobundle() abort
  if !executable('git')
    echohl Error
    echo 'git is required to be installed.'
    echohl None
    return 1
  endif

  if !executable('make')
    echohl Error
    echo 'gcc is required to be installed.'
    echohl None
    return 1
  endif

  if g:is_linux
    let l:vimproc_build_cmd = 'make'
  endif

  redraw | echo 'Installing neobundle.vim, unite.vim, and vimproc.vim ...'
  call system(printf('git clone --depth 1 %s %s', s:neobundle_url, s:neobundle_root))
  call system(printf('git clone --depth 1 %s %s', s:unite_url,     s:unite_root))
  call system(printf('git clone --depth 1 %s %s', s:vimproc_url,   s:vimproc_root))
  let l:currentdir = system('pwd')
  execute(printf('cd %s', s:vimproc_root))
  echo system('pwd')
  call system(l:vimproc_build_cmd)
  execute(printf('cd %s', l:currentdir))
  redraw | echo 'neobundle.vim, unite.vim, and vimproc.vim were installed. continue to install other plugins...'
  return 0
endfunction

function! s:configure_neobundle() abort
  call g:neobundle#begin(s:bundle_root)

  if g:neobundle#load_cache(
        \ $MYVIMRC,
        \ g:util#normpath('rc' . g:pathsep . 'plugin.vim', 'config'),
        \ g:util#normpath('rc' . g:pathsep . 'plugin.define.toml', 'config'),
        \ )
    " manage completion plugins
    if g:is_neovim && has("python3")
      NeoBundle 'Shougo/deoplete.nvim'
    elseif has('lua') && ( (v:version == 703 && has('patch885')) || v:version >= 704 )
      NeoBundle 'Shougo/neocomplete.vim'
    else
      NeoBundle 'Shougo/neocomplecache.vim'
    endif

    " other plugins
    call g:neobundle#load_toml(g:util#normpath('rc' . g:pathsep . 'plugin.define.toml', 'config'), { })

    NeoBundleSaveCache
  endif

  call g:util#source(g:util#normpath('rc' . g:pathsep . 'plugin.config.vim', 'config'))

  call g:neobundle#end()

  filetype plugin indent on
  syntax on

  NeoBundleCheck

  if !has('vim_starting')
    call neobundle#call_hook('on_source')
  endif
endfunction

if !filereadable(s:neobundle_root . g:pathsep . 'plugin' . g:pathsep . 'neobundle.vim')
  call s:install_neobundle()
endif

if has('vim_starting')
  execute printf('set runtimepath+=%s', s:neobundle_root)
endif
call s:configure_neobundle()

