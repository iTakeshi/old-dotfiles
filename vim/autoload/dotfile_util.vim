let s:is_windows = 0 " placeholder
let s:is_macosx  = 0 " placeholder
let s:is_linux   = !s:is_windows && !s:is_macosx
let s:is_neovim  = has('nvim')
let s:delimiter  = s:is_windows ? ';' : ':'
let g:pathsep    = s:is_windows ? '\\' : '/'
let s:homepath   = expand($HOME)

if s:is_neovim
  let s:config_root = s:homepath . g:pathsep . '.config' . g:pathsep . 'nvim'
else
  let s:config_root = s:homepath . g:pathsep . '.vim'
endif

if s:is_linux
  let s:data_root = s:homepath . g:pathsep . '.local' . g:pathsep . 'share'
  let s:data_root = s:data_root . g:pathsep . (s:is_neovim ? 'nvim' : 'vim')
else
  " TODO windows configuration
end

if s:is_windows
  function! dotfile_util#is_abspath(path) abort
    return a:path =~# '\v^[A-Z]:\\'
  endfunction
else
  function! dotfile_util#is_abspath(path) abort
    return a:path =~# '\v^/'
  endfunction
endif

function! dotfile_util#is_relpath(path) abort
  return !dotfile_util#is_abspath(a:path)
endfunction

function! dotfile_util#normpath(path, type) abort
  let relpath = dotfile_util#is_relpath(a:path)
        \ ? a:path
        \ : fnamemodify(a:path, ':~:.')
  if a:type =~ 'c\%[onfig]'
    let typeroot = s:config_root
  elseif a:type =~ 'd\%[ata]'
    let typeroot = s:data_root
  endif
  return typeroot . g:pathsep . relpath
endfunction

function! dotfile_util#source(path) abort
  let path = expand(a:path)
  if filereadable(path)
    execute printf('source %s', path)
    return 1
  endif
  return 0
endfunction

