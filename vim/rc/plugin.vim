let s:bundle_root    = dotfile_util#normpath('bundle', 'config')
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
    let vimproc_build_cmd = 'make'
  endif

  redraw | echo 'Installing neobundle.vim, unite.vim, and vimproc.vim ...'
  call system(printf('git clone --depth 1 %s %s', s:neobundle_url, s:neobundle_root))
  call system(printf('git clone --depth 1 %s %s', s:unite_url,     s:unite_root))
  call system(printf('git clone --depth 1 %s %s', s:vimproc_url,   s:vimproc_root))
  let currentdir = system('pwd')
  execute(printf('cd %s', s:vimproc_root))
  echo system('pwd')
  call system(vimproc_build_cmd)
  execute(printf('cd %s', currentdir))
  redraw | echo 'neobundle.vim, unite.vim, and vimproc.vim were installed. continue to install other plugins...'
  return 0
endfunction

function! s:configure_neobundle() abort
  call neobundle#begin(s:bundle_root)
  if neobundle#load_cache()
    NeoBundleFetch 'Shougo/neobundle.vim'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'Shougo/vimproc.vim', { 'build': { 'linux': 'make' } }
    call neobundle#load_toml(
        \ dotfile_util#normpath('rc' . g:pathsep . 'plugin.define.toml', 'config'), { })
    NeoBundleSaveCache
  endif
  call dotfile_util#source(dotfile_util#normpath('rc' . g:pathsep . 'plugin.config.vim', 'config'))
  call neobundle#end()

  filetype plugin indent on
  syntax on

  " Unite neobundle/install -auto-quit

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

