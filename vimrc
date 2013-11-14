"Be IMproved
set nocompatible

" OS Dependent {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" define environment
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_darwin = has('mac') || has('macunix') || has('gui_macvim')
let s:is_linux = !s:is_windows && !s:is_cygwin && !s:is_darwin

" gvimrc
if !exists($MYGVIMRC)
  if s:is_windows
    let $MYGVIMRC = expand('~/_gvimrc')
  else
    let $MYGVIMRC = expand('~/.gvimrc')
  endif
endif

" config directory
if s:is_windows
  let s:config_root = expand('~/vimfiles')
else
  let s:config_root = expand('~/.vim')
endif

" use english interface
if s:is_windows
  language message en
else
  language message C
endif

" path separator
if s:is_windows
  set shellslash
endif
" }}} OS Dependent

" Basic Settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

" open quickfix window after commands like :make
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

" create new directory automatically
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

" set current directory to the parent directory of the file spcified by commandline arg
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd' . a:directory
  endif
  if a:bang == ''
    pwd
  endif
endfunction
autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')

" use ';' insted of '\'
" use <Leader> in global plugin
let g:mapleader = ';'
" release keymappings for plugin
nnoremap ; <Nop>
xnoremap ; <Nop>

" suppress tex formula conversion
let g:tex_conceal = ''
" }}} Basic Settings

" Key Mappings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remove highlight with pressing ESC twice
nmap <silent> <Esc><Esc> :<C-u>noh<CR>

" make the word center when jumped
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" increase scrolling speed
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" remap j and k to act as expected when used on long, wrapped lines
nnoremap j gj
nnoremap k gk

" select till a end of a line
vnoremap v $

" window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" redraw window
nnoremap <C-d> :<C-u>redraw!<CR>

" toggle
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :<C-u>setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :<C-u>setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :<C-u>setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :<C-u>setl wrap!<CR>:setl wrap?<CR>
nnoremap <silent> [toggle]p :<C-u>setl paste!<CR>:setl paste?<CR>
" }}} Key Mappings

" Plugins {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:bundle_root = s:config_root . '/bundle'
let s:neobundle_root = s:bundle_root . '/neobundle.vim'
if has('vim_starting')
  execute 'set runtimepath+=' . s:neobundle_root
endif
call neobundle#rc(s:bundle_root)
NeoBundleFetch 'Shougo/neobundle.vim'

" recognize charcode automatically
NeoBundle 'banyan/recognize_charcode.vim'

" enable async processing
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin'  : 'make -f make_cygwin.mak',
      \     'mac'     : 'make -f make_mac.mak',
      \     'unix'    : 'make -f make_unix.mak',
      \    },
      \ }

NeoBundle 'Shougo/vimshell.vim', { 'depends': ['Shougo/vimproc'] }
let g:vimshell_prompt_expr = 'getcwd()." > "'
let g:vimshell_prompt_pattern = '^\f\+ > '

" Unite.vim and relating plugins {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundleLazy 'Shougo/unite.vim', {
      \ 'autoload': {
      \   'commands': ['Unite', 'UniteWithBufferDir']
      \ }}
NeoBundleLazy 'h1mesuke/unite-outline', {
      \ 'autoload': {
      \   'unite_sources': ['outline'],
      \ }}
nnoremap [unite] <Nop>
nmap U [unite]
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]r :<C-u>Unite register<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
nnoremap <silent> [unite]w :<C-u>Unite window<CR>
let s:hooks = neobundle#get_hooks('unite.vim')
function! s:hooks.on_source(bundle)
  " start unite in insert mode
  let g:unite_enable_start_insert = 1
  " use vimfiler to open directory
  call unite#custom_default_action('source/bookmark/directory', 'vimfiler')
  call unite#custom_default_action('directory', 'vimfiler')
  call unite#custom_default_action('directory_mru', 'vimfiler')
  autocmd MyAutoCmd FileType unite call s:unite_settings()
  function! s:unite_settings()
    imap <buffer> <Esc><Esc> <Plug>(unite_exit)
    nmap <buffer> <Esc> <Plug>(unite_exit)
    nmap <buffer> <C-n> <Plug>(unite_select_next_line)
    nmap <buffer> <C-p> <Plug>(unite_select_previous_line)
  endfunction
endfunction

NeoBundle 'Shougo/vimfiler', { 'depends': ['Shougo/unite.vim'] }
" close vimfiler automatically when there are only vimfiler open
autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
let s:hooks = neobundle#get_hooks('vimfiler')
function! s:hooks.on_source(bundle)
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_enable_auto_cd = 1
  " ignore swap, backup, temporary files
  let g:vimfiler_ignore_pattern = '\.pyc$'
  " vimfiler specific key mappings
  autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
  function! s:vimfiler_settings()
    " ^^ to go up
    nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
    " overwrite C-j ignore <Plug>(vimfiler_switch_to_history_directory)
    nmap <buffer> <C-j> <C-w>j
    " use R to refresh
    nmap <buffer> R <Plug>(vimfiler_redraw_screen)
    " overwrite C-l ignore <Plug>(vimfiler_redraw_screen)
    nmap <buffer> <C-l> <C-w>l
  endfunction
endfunction
function! g:exec_vimfiler()
  VimFilerExplorer -simple -winwidth=30
  if &filetype == 'vimfiler'
    setl nonumber
  endif
endfunction
function! s:exec_vimfiler_on_vimenter()
  call g:exec_vimfiler()
  wincmd l
  if expand('%') == ''
    wincmd h
  endif
endfunction
command! ExecVimFiler :call g:exec_vimfiler()
nnoremap <Leader>e :<C-u>ExecVimFiler<CR>
autocmd MyAutoCmd VimEnter * call s:exec_vimfiler_on_vimenter()
" }}} Unite.vim and relating plugins

" Display plugins {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" yet another powerline alternative
NeoBundle 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }
function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction
function! MyFilename()
  let fname = expand('%:t')
  return fname =~ '__Gundo' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
function! MyFugitive()
  try
    if expand('%:t') !~? 'Gundo' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction
function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction
function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction
function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction
function! MyMode()
  let fname = expand('%:t')
  return fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" restore folding/cursor position/etc when re-opening files
NeoBundle 'vim-scripts/restore_view.vim'

" indentation guide
NeoBundle 'Yggdroot/indentLine'
" }}} Display plugins

" Git plugins {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-fugitive'

NeoBundleLazy 'gregsexton/gitv', {
      \ 'depends': ['tpope/vim-fugitive'],
      \ 'autoload': {
      \   'commands': ['Gitv'],
      \ }}
" }}} Git plugins

" Editing support plugins {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" pseudo-capslock function
NeoBundle 'tpope/vim-capslock'
nnoremap <silent> [toggle]c <Plug>CapsLockToggle

" support to manage 'surroundings'
NeoBundle 'tpope/vim-surround'

" code alignment
NeoBundle 'vim-scripts/Align'
let g:Align_xstrlen=3

" clipboard history
NeoBundle 'vim-scripts/YankRing.vim'
let yankring_history_file = '.yankring_history'

if has('lua') && ( (v:version == 703 && has('patch885')) || v:version == 704 )
  NeoBundleLazy 'Shougo/neocomplete.vim', {
        \ 'autoload': {
        \   'insert': 1,
        \ }}
  let s:hooks = neobundle#get_hooks('neocomplete.vim')
  function! s:hooks.on_source(bundle)
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
else
  NeoBundleLazy 'Shougo/neocomplcache.vim', {
        \ 'autoload': {
        \   'insert': 1,
        \ }}
  let s:hooks = neobundle#get_hooks('neocomplcache.vim')
  function! s:hooks.on_source(bundle)
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
endif

" undo history
NeoBundleLazy 'sjl/gundo.vim', {
      \ 'autoload': {
      \   'commands': ['GundoToggle'],
      \}}
nnoremap <Leader>g :GundoToggle<CR>
" }}} Editing support plugins

" Programming support plugins {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" run/make sources on vim
NeoBundleLazy 'thinca/vim-quickrun', {
      \ 'autoload': {
      \   'mappings': [['nxo', '<Plug>(quickrun)']]
      \ }}
nmap <Leader>r <Plug>(quickrun)
let s:hooks = neobundle#get_hooks('vim-quickrun')
function! s:hooks.on_source(bundle)
  let g:quickrun_config = {
        \ '_': {'runner': 'remote/vimproc'}
        \ }
endfunction

" syntax checker
NeoBundle 'scrooloose/syntastic', {
      \ 'build': {
      \   'unix': ['pip install pyflake', 'npm -g install coffeelint'],
      \ }}

" highlight quickfix errors
NeoBundle 'jceb/vim-hier'
" }}} Programming support plugins

" Syntax plugins {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundleLazy 'tpope/vim-git', {'autoload': {
      \ 'filetypes': 'git' }}

NeoBundleLazy 'othree/html5.vim', {'autoload': {
      \ 'filetypes': ['html', 'eruby'] }}

NeoBundleLazy 'hail2u/vim-css3-syntax', {'autoload': {
      \ 'filetypes': ['css', 'html', 'eruby', 'sass', 'scss'] }}

NeoBundleLazy 'cakebaker/scss-syntax.vim', {'autoload': {
      \ 'filetypes': ['sass', 'scss'] }}

NeoBundleLazy 'groenewege/vim-less.git', {'autoload': {
      \ 'filetypes': 'less' }}

NeoBundleLazy 'jQuery', {'autoload': {
      \ 'filetypes': ['coffee', 'coffeescript', 'javascript', 'html', 'eruby'] }}

NeoBundleLazy 'kchmck/vim-coffee-script', {'autoload': {
      \ 'filetypes': ['coffee', 'coffeescript'] }}

NeoBundleLazy 'vim-ruby/vim-ruby', {'autoload': {
      \ 'filetypes': ['ruby', 'eruby'] }}

NeoBundleLazy 'iTakeshi/EcellModel.vim', {'autoload': {
      \ 'filetypes': ['EcellModel'] }}
" }}} Syntax plugins

filetype plugin indent on
unlet s:hooks
NeoBundleCheck
" }}} Plugins

" Search {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
if has('multi_byte_ime')
  set iminsert=0 imsearch=0
endif

cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
" }}} Search

" Edit {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set smarttab
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set autoindent
set copyindent

set autoread
set infercase

set virtualedit=block

set modeline

set showmatch
set matchtime=2

set formatoptions-=o

" use clipboard register
if has('unnamedplus')
  set clipboard=unnamedplus,autoselect
else
  set clipboard& clipboard+=unnamed
endif

set backspace=indent,eol,start

set matchpairs& matchpairs+=<:>

set grepprg=grep\ -nH

set isfname-==

set timeout timeoutlen=3000 ttimeoutlen=100

set updatetime=1000

" set tag file. don't search tags in pwd and search upward
set tags& tags-=tags tags+=./tags;
if v:version < 703 || (v:version == 7.3 && !has('patch336'))
  set notagbsearch
endif

set keywordprg=:help

set hidden
set switchbuf=useopen

set nowritebackup
set nobackup
set noswapfile
set backupdir=~/.vim/tmp

set spelllang=en_us
set nospell

" automaticaly remove trailing whitespaces
autocmd InsertLeave * :%s/\s\+$//e
" }}} Edit

" Display {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on

set number
set list
set listchars=tab:>-,trail:_,extends:&,precedes:&,nbsp:%,eol:$

set wrap
set textwidth=0
set whichwrap+=h,l,<,>,[,],b,s,~

set laststatus=2
set cmdheight=2
set showcmd

set scrolloff=4

set breakat=\ \ ;:,!?
set linebreak
set showbreak=>\ \ \

set shortmess=aTI

set viewoptions=cursor,folds,slash,unix

set t_vb=
set novisualbell

set nowildmenu
set wildmode=list:longest,full

set history=200

set showfulltag
set wildoptions=tagfile

set completeopt=menuone
set complete=.
set pumheight=20

set report=0

set nostartofline

set lazyredraw

set display=lastline

if v:version >= 703
  set conceallevel=2 concealcursor=iv
  set colorcolumn=80
endif

if !has('gui_running')
  set t_Co=256
  set background=dark
endif
colorscheme desertEx
" }}} Display

" Fold {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable
set foldcolumn=2
set foldlevel=1
set foldnestmax=5
set foldmethod=marker
" }}} Fold
