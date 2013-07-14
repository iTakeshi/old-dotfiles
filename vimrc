" Be IMproved
set nocompatible

" variables {{{

if !exists($MYGVIMRC)
  let $MYGVIMRC = expand('~/.gvimrc')
endif

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_darwin = has('mac') || has('macunix') || has('gui_macvim')
let s:is_linux = !s:is_windows && !s:is_cygwin && !s:is_darwin

let s:config_root = expand('~/.vim')
let s:bundle_root = s:config_root . '/bundle'

if s:is_windows
  " use english interface
  language message en
  " exchange path separator
  set shellslash
else
  " use english interface
  language message C
endif

" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

" use ';' insted of '\'
" use <Leader> in global plugin
let g:mapleader = ';'
" release keymappings for plugin
nnoremap ; <Nop>
xnoremap ; <Nop>

" reset runtimepath
if has('vim_starting')
  if s:is_windows
    " set runtimepath
    let &runtimepath = join([
          \ s:config_root,
          \ expand('$VIM/runtime'),
          \ s:config_root . '/after'], ',')
  else
    " reset runtimepath to default
    set runtimepath&
  endif
endif

" }}} end variables

" keymappings {{{
" remove highlight with pressing ESC twice
nmap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

" Make the word center when jumped
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Increase scrolling speed
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk

" Select till a end of a line
vnoremap v $h

" Jump to matching pairs easily with Tab
nnoremap <Tab> %
vnoremap <Tab> %

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" Redraw window
nnoremap <C-d> :redraw!<CR>

" toggle
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :<C-u>setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :<C-u>setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :<C-u>setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :<C-u>setl wrap!<CR>:setl wrap?<CR>
" }}} end keymappings

" plugins {{{
let s:neobundle_root = expand('~/.vim/neobundle.vim')
if has('vim_starting')
  execute 'set runtimepath+=' . s:neobundle_root
endif
call neobundle#rc(s:bundle_root)

NeoBundleFetch 'Shougo/neobundle.vim'

" Enable async process via vimproc
NeoBundle 'Shougo/vimproc', {
      \ 'build': {
      \   'windows'   : 'make -f make_mingw32.mak',
      \   'cygwin'    : 'make -f make_cygwin.mak',
      \   'mac'       : 'make -f make_mac.mak',
      \   'unix'      : 'make -f make_unix.mak',
      \ }}

" Recognize charcode automatically
NeoBundle 'banyan/recognize_charcode.vim'

" display plugins {{{
NeoBundle 'taichouchou2/alpaca_powertabline'
NeoBundle 'Lokaltog/vim-powerline'
let g:Powerline_symbols = 'fancy'

NeoBundle 'jceb/vim-hier'
NeoBundle 'vim-scripts/restore_view.vim'

NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=239
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=239
nnoremap <silent> [toggle]i  :IndentGuidesToggle<CR>

NeoBundleLazy 'skammer/vim-css-color', {
      \ 'autoload': {
      \   'filetypes': ['html', 'css', 'less', 'sass', 'javascript', 'coffee', 'coffeescript']
      \ }}
" }}} end display plugins

" syntax plugin {{{
NeoBundleLazy 'tpope/vim-git', {'autoload': {
      \ 'filetypes': 'git' }}

NeoBundleLazy 'hail2u/vim-css3-syntax', {'autoload': {
      \ 'filetypes': ['css', 'html', 'eruby', 'sass', 'scss'] }}

NeoBundleLazy 'othree/html5.vim', {'autoload': {
      \ 'filetypes': ['html', 'eruby'] }}

NeoBundleLazy 'groenewege/vim-less.git', {'autoload': {
      \ 'filetypes': 'less' }}

NeoBundleLazy 'cakebaker/scss-syntax.vim', {'autoload': {
      \ 'filetypes': ['sass', 'scss'] }}

NeoBundleLazy 'vim-ruby/vim-ruby', {'autoload': {
      \ 'filetypes': ['ruby', 'eruby'] }}
" }}} end syntax plugin

" file management {{{
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

NeoBundle 'Shougo/vimfiler.vim', {'depends': ['Shougo/unite.vim'] }
nnoremap <Leader>e :VimFilerExplorer<CR>
" close vimfiler automatically when there are only vimfiler open
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_enable_auto_cd = 1
" ignore swap, backup, temporary files
let g:vimfiler_ignore_pattern = '\.pyc$'
" vimfiler specific key mappings
autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
function! s:vimfiler_settings()
  " ^^ to go up
  nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
  " use R to refresh
  nmap <buffer> R <Plug>(vimfiler_redraw_screen)
  " overwrite C-l ignore <Plug>(vimfiler_redraw_screen)
  nmap <buffer> <C-l> <C-w>l
  " overwrite C-j ignore <Plug>(vimfiler_switch_to_history_directory)
  nmap <buffer> <C-j> <C-w>j
endfunction
autocmd VimEnter * :VimFilerExplorer

NeoBundle 'tpope/vim-fugitive'
NeoBundleLazy 'gregsexton/gitv', {
      \ 'depends': ['tpope/vim-fugitive'],
      \ 'autoload': {
      \   'commands': ['Gitv'],
      \ }}
" }}} end file management

" editing support {{{
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/Align'
NeoBundle 'vim-scripts/YankRing.vim'
let yankring_history_file = '.yankring_history'

if has('lua') && (v:version == 703 && has('patch885')) || v:version == 704
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

NeoBundleLazy 'Shougo/neosnippet.vim', {
      \ 'depends': ['honza/vim-snippets'],
      \ 'autoload': {
      \   'insert': 1,
      \ }}
let s:hooks = neobundle#get_hooks('neosnippet.vim')
function! s:hooks.on_source(bundle)
  " Plugin key-mappings.
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)
  "  " SuperTab like snippets behavior.
  "  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  "        \ '\<Plug>(neosnippet_expand_or_jump)'
  "        \: pumvisible() ? '\<C-n>' : '\<TAB>'
  "  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  "        \ '\<Plug>(neosnippet_expand_or_jump)'
  "        \: '\<TAB>'
  " For snippet_complete marker.
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif
  " Enable snipMate compatibility feature.
  let g:neosnippet#enable_snipmate_compatibility = 1
  " Tell Neosnippet about the other snippets
  let g:neosnippet#snippets_directory=s:bundle_root . '/vim-snippets/snippets'
endfunction

NeoBundleLazy 'sjl/gundo.vim', {
      \ 'autoload': {
      \   'commands': ['GundoToggle'],
      \}}
nnoremap <Leader>g :GundoToggle<CR>

NeoBundleLazy 'vim-scripts/TaskList.vim', {
      \ 'autoload': {
      \   'mappings': ['<Plug>TaskList'],
      \}}
nmap <Leader>T <plug>TaskList
" }}} end editing support

" Programming {{{
NeoBundleLazy 'thinca/vim-quickrun', {
      \ 'autoload': {
      \   'mappings': [['nxo', '<Plug>(quickrun)']]
      \ }}
nmap <Leader>r <Plug>(quickrun)
let s:hooks = neobundle#get_hooks('vim-quickrun')
function! s:hooks.on_source(bundle)
  if has('clientserver')
    let g:quickrun_config = {
          \ '*': {'runner': 'remote/vimproc'}
          \ }
  else
    let g:quickrun_config = {
          \ '*': {'runner': 'remote/vimproc'}
          \ }
  endif
endfunction

NeoBundleLazy 'majutsushi/tagbar', {
      \ 'autload': {
      \   'commands': ['TagbarToggle']
      \ }}
nmap <Leader>t :TagbarToggle<CR>

NeoBundle 'scrooloose/syntastic', {
      \ 'build': {
      \   'unix': ['pip install pyflake', 'npm -g install coffeelint'],
      \ }}

NeoBundleLazy 'jQuery', {'autoload': {
      \ 'filetypes': ['coffee', 'coffeescript', 'javascript', 'html', 'eruby'] }}
NeoBundleLazy 'kchmck/vim-coffee-script', {'autoload': {
      \ 'filetypes': ['coffee', 'coffeescript'] }}

" Python {{{
NeoBundleLazy 'jmcantrell/vim-virtualenv', {
      \ 'autoload': {
      \   'filetypes': ['python', 'python3', 'djangohtml']
      \ }}
NeoBundleLazy 'davidhalter/jedi-vim', {
      \ 'autoload': {
      \   'filetypes': ['python', 'python3', 'djangohtml'],
      \   'build': {
      \     'mac': 'pip install jedi',
      \     'unix': 'pip install jedi',
      \   }
      \ }}
let s:hooks = neobundle#get_hooks('jedi-vim')
function! s:hooks.on_source(bundle)
  let g:jedi#auto_vim_configuration = 0
  let g:jedi#popup_select_first = 0
  let g:jedi#show_function_definition = 1
  let g:jedi#rename_command = '<Leader>R'
  let g:jedi#goto_command = '<Leader>G'
endfunction
" }}}

"}}}

NeoBundleCheck
unlet s:hooks
filetype plugin indent on
" }}} end plugins

" search {{{
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch      " highlight search terms
if has('multi_byte_ime')
  set iminsert=0 imsearch=0
endif

cnoremap <expr> /
      \ getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ?
      \ getcmdtype() == '?' ? '\?' : '?'
" }}} end search

" edit {{{
set smarttab
set expandtab       " exchange tab to spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround      " use multiple of shiftwidth when indenting with '<' and '>'
set autoread        " automatically reload when the file is changed
set infercase       " ignore case on insert completion

set autoindent
set copyindent      " copy the previous indentation level

set virtualedit=block

set modeline        " enable modeline
set showmatch       " highlight partner
set matchtime=3

" do not start with comment on pressing 'o'
set formatoptions-=o

" use clipboard register
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus
else
  set clipboard& clipboard+=unnamed
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" highlight when cursor moved
set cpoptions-=m
" add <>
set matchpairs& matchpairs+=<:>

" use grep
set grepprg=grep\ -nH
" exclude = from isfilename
set isfname-==

" keymapping timeout
set timeout timeoutlen=3000 ttimeoutlen=100
" CursorHold time
set updatetime=1000

" set swap directory
set directory& directory-=.
if v:version >= 703
  set undofile
  let &undodir=&directory
endif

" set tag file. don't search tags in pwd and search upward
set tags& tags-=tags tags+=./tags;
if v:version < 703 || (v:version == 7.3 && !has('patch336'))
  set notagbsearch
endif

set keywordprg=:help

" hide buffer insted of closing to prevent Undo history
set hidden
" use opend buffer insted of create new buffer
set switchbuf=useopen

" do not create backup
set nowritebackup
set nobackup
set noswapfile
set backupdir=~/.vim/tmp

" set default lang for spell check
set spelllang=en_us
set nospell

" automaticaly remove trailing whitespaces
autocmd InsertLeave * :%s/\s\+$//e
" }}} end edit

" display {{{
syntax on
set list
set number
set listchars=tab:>-,trail:_,extends:&,precedes:&,nbsp:%,eol:$
set wrap                            " wrap long text
set textwidth=0                     " do not automatically insert newline
set whichwrap+=h,l,<,>,[,],b,s,~
set laststatus=2                    " always display statusline
set scrolloff=4
set cmdheight=2                     " height of command line
set showcmd                         " show command on statusline

" turn down a long line appointed in 'breakat'
set linebreak
set showbreak=>\ \ \
set breakat=\ \ ;:,!?

" do not display greeting message
set shortmess=aTI

" store cursor, folds, slash, unix on view
set viewoptions=cursor,folds,slash,unix

" disable bells
set t_vb=
set novisualbell

" display candidate supplement
set nowildmenu
set wildmode=list:longest,full

set history=200
set showfulltag                     " display all the information of the tag
" by the supplement of the Insert mode
set wildoptions=tagfile             " can supplement a tag in a command-line

" completion settings
set completeopt=menuone
set complete=.                      " don't complete from other buffer
set pumheight=20                    " height of popup menu

set report=0                        " report changes

" maintain a current line at the time of movement as much as possible
set nostartofline

" don't redraw while macro executing
set lazyredraw

" do not omit it in @.
set display=lastline

if v:version >= 703
  set conceallevel=2 concealcursor=iv
  set colorcolumn=80
endif
" }}} end display

" folding {{{
set foldenable
set foldcolumn=2
set foldlevel=1
set foldnestmax=5
set foldmethod=marker
" }}} end folding

" style {{{
if !has('gui_running')
  set t_Co=256
  set background=dark
  colorscheme desertEx
endif
" }}} end style

" filetype detection {{{
augroup filetypedetect
  autocmd!
  " Markdown
  autocmd! BufNewFile,BufRead *.md setfiletype markdown
  autocmd! BufNewFile,BufRead *.mkd setfiletype markdown
  autocmd! BufNewFile,BufRead *.markdown setfiletype markdown
  " CoffeeScript
  autocmd! BufNewFile,BufRead *.coffee setfiletype coffee
  autocmd! BufNewFile,BufRead Cakefile setfiletype coffee
  " LESS
  autocmd! BufNewFile,BufRead *.less setfiletype less
  " SASS/SCSS
  autocmd! BufNewFile,BufRead *.sass setfiletype sass
  autocmd! BufNewFile,BufRead *.scss setfiletype scss
  " Python
  autocmd! BufNewFile,BufRead SConstruct setfiletype python
augroup END
" }}} end filetype detection
