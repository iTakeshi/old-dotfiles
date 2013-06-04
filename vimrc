set nocompatible "Be iMproved

set runtimepath+=~/dotfiles/neobundle.vim
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'

NeoBundle 'vim-scripts/The-NERD-tree'
nmap <Leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

NeoBundle 'tpope/vim-fugitive'
set statusline+=%{fugitive#statusline()}

NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'othree/html5.vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'groenewege/vim-less'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'slim-template/vim-slim'

let g:Align_xstrlen = 3

"General Settings
set cindent
set cinoptions=g0
set backupdir=$HOME/.vimbackup
set directory=$HOME/.vimbackup
set smartindent
set title
set mouse=a
set clipboard=unnamed
set binary
set noeol

"Edit Settings
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab     "replace tab to spaces
set showmatch     "auto complete )
set matchtime=1   "wait time for showmatch
set backspace=indent,eol,start
set virtualedit=block
set whichwrap=b,s,h,l,<,>,[,]
set hidden

"Display Settings
set number
set list
set listchars=eol:$,tab:>-,extends:&,trail:_
set ruler
set nowrap
set shellslash

"Search Settings
set hlsearch       "enable highligt
set incsearch      "enable incremental search
set smartcase      "enable smart case
set grepprg=grep\ -nH\ $*
set ignorecase

"Plugin Settings
filetype on
filetype plugin on
filetype plugin indent on
filetype indent on
syntax on

"color
set t_Co=256
NeoBundle 'vim-scripts/Colour-Sampler-Pack'
color desertEx
