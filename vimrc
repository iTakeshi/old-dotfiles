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

NeoBundle 'godlygeek/tabular'

"General Settings
set cindent
set cinoptions=g0
set smartindent
set title
set mouse=a
set binary
set noeol

"Edit Settings
set tabstop=2
set shiftwidth=2
set shiftround
set smarttab
set expandtab     "replace tab to spaces
set showmatch     "auto complete )
set matchtime=1   "wait time for showmatch
set backspace=indent,eol,start
set virtualedit=all
set whichwrap=b,s,h,l,<,>,[,]
set hidden
set switchbuf=useopen
set infercase
set matchpairs& matchpairs+=<:>
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus,unnamed
else
  set clipboard& clipboard+=unnamed
endif

set nowritebackup
set nobackup
set noswapfile

"Display Settings
set number
set list
set listchars=eol:$,tab:>-,extends:&,trail:_
set ruler
set nowrap
set shellslash
set textwidth=0
set colorcolumn=80
set t_vb=
set novisualbell

"Search Settings
set hlsearch
set incsearch
set ignorecase
set smartcase
set grepprg=grep\ -nH\ $*

"Plugin Settings
filetype on
filetype plugin on
filetype plugin indent on
filetype indent on
syntax on

"color
set t_Co=256
color desertEx
