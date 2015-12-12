set number                " show line numbers
set list                  " show invisible characters
set laststatus=2          " always shows statusline
set scrolloff=4           " minimum number of screen lines to keep in scroll
set sidescrolloff=4       " minimum number of screen columns to keep in scroll
set cmdheight=2           " the number of screen lines to use for command line
set showcmd               " show command on statusline
set lazyredraw            " do not redraw while command execution
set nosplitbelow          " split to top
set splitright            " vsplit to right
set report=0              " report any changes
set display=lastline      " display last line in a window AMAP

set nowrap                " wrap long text
set textwidth=0           " do not automatically break
set breakat=\ \ ;:,!?     " characters which might cause a line break

" enable to move to next/previous line by h/l/<BS>
set whichwrap+=h,l,<,>,[,],b,s,~

" do not display greeting message
set shortmess=aTI

" use rich completion system in command line
set wildmenu
set wildmode=list:longest,full
set wildoptions=tagfile

" completion settings
set completeopt=menu,longest
set complete=.            " don't complete from other buffer
set pumheight=20          " height of popup menu
set showfulltag           " show both the tag name and the search pattern
if has('patch-7.4.314')
  " don't give ins-completion-menu messages
  set shortmess+=c
endif

" Conceal
set conceallevel=2
set concealcursor=c
set colorcolumn=80

" set fillchars=vert: fold:-
set listchars=tab:>-,trail:_,extends:&,precedes:&,nbsp:%,eol:$

colorscheme desertEx
