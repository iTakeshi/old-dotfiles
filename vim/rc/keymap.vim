" define <Leader> and <LocalLeader>
let g:mapleader = ';'
let g:maplocalleader = ';'

" remove any existing keymap for leader and localleader
nnoremap ; <Nop>
xnoremap ; <Nop>

" remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" increase scrolling speed
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" Emacs like binding in Insert mode
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-f> <C-o>w
inoremap <C-b> <C-o>b
inoremap <C-d> <C-o>x

" Ctrl-h/j/k/l to move around in Insert mode
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l

" Y to yank until the end of line
nnoremap Y y$

" <C-p> to paste from 0 register
nnoremap <C-p> "0p

" vv to select the line, like yy, dd
nnoremap vv 0v$

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
nnoremap <silent> [toggle]e :<C-u>setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :<C-u>setl wrap!<CR>:setl wrap?<CR>
nnoremap <silent> [toggle]p :<C-u>setl paste!<CR>:setl paste?<CR>

" tag navigation
nnoremap [t  :<C-u>tprevious<CR>
nnoremap ]t  :<C-u>tnext<CR>
nnoremap g[t :<C-u>tfirst<CR>
nnoremap g]t :<C-u>tlast<CR>

" quickfix navigation
nnoremap [q  :<C-u>cprevious<CR>
nnoremap ]q  :<C-u>cnext<CR>
nnoremap g[q :<C-u>cfirst<CR>
nnoremap g]q :<C-u>clast<CR>
nnoremap [l  :<C-u>lprevious<CR>
nnoremap ]l  :<C-u>lnext<CR>
nnoremap g[l :<C-u>lfirst<CR>
nnoremap g]l :<C-u>llast<CR>

" file navigation
nnoremap [f  :<C-u>previous<CR>
nnoremap ]f  :<C-u>next<CR>
nnoremap g[f :<C-u>first<CR>
nnoremap g]f :<C-u>last<CR>

" tab operation (make similar mapping with window operation)
" ref.
" <C-w>n    Create a new window and start editing an empty file in it.
" <C-w>q    Quit the current window. (:quit)
" <C-w>c    Close the current window. (:close)
" <C-w>o    Only
" <C-w>w    Move to below/right
" <C-w>W    Move to top/left
" <C-w>p    Move to previous
function! s:tab_quit() abort
  if tabpagenr('$') == 1
    quit
  else
    tabclose
  endif
endfunction

nnoremap <silent> <Plug>(my-tab-new) :<C-u>tabnew<CR>
nnoremap <silent> <Plug>(my-tab-quit) :<C-u>call <SID>tab_quit()<CR>
nnoremap <silent> <Plug>(my-tab-close) :<C-u>tabclose<CR>
nnoremap <silent> <Plug>(my-tab-only) :<C-u>tabonly<CR>
nnoremap <silent> <Plug>(my-tab-next) :<C-u>tabnext<CR>
nnoremap <silent> <Plug>(my-tab-prev) :<C-u>tabprevious<CR>
nnoremap <silent> <Plug>(my-tab-move-0) :<C-u>0tabmove<CR>
nnoremap <silent> <Plug>(my-tab-move-L) :<C-u>-tabmove<CR>
nnoremap <silent> <Plug>(my-tab-move-R) :<C-u>+tabmove<CR>
nnoremap <silent> <Plug>(my-tab-move-$) :<C-u>$tabmove<CR>
nnoremap <silent> <Plug>(my-tab-0) :<C-u>tabfirst<CR>
nnoremap <silent> <Plug>(my-tab-1) :<C-u>tabnext1<CR>
nnoremap <silent> <Plug>(my-tab-2) :<C-u>tabnext2<CR>
nnoremap <silent> <Plug>(my-tab-3) :<C-u>tabnext3<CR>
nnoremap <silent> <Plug>(my-tab-4) :<C-u>tabnext4<CR>
nnoremap <silent> <Plug>(my-tab-5) :<C-u>tabnext5<CR>
nnoremap <silent> <Plug>(my-tab-6) :<C-u>tabnext6<CR>
nnoremap <silent> <Plug>(my-tab-7) :<C-u>tabnext7<CR>
nnoremap <silent> <Plug>(my-tab-8) :<C-u>tabnext8<CR>
nnoremap <silent> <Plug>(my-tab-9) :<C-u>tabnext9<CR>
nnoremap <silent> <Plug>(my-tab-$) :<C-u>tablast<CR>

nmap <C-t>n     <Plug>(my-tab-new)
nmap <C-t><C-n> <Plug>(my-tab-new)
nmap <C-t>q     <Plug>(my-tab-quit)
nmap <C-t><C-q> <Plug>(my-tab-quit)
nmap <C-t>c     <Plug>(my-tab-close)
nmap <C-t>o     <Plug>(my-tab-only)
nmap <C-t><C-o> <Plug>(my-tab-only)

nmap <C-t>t     <Plug>(my-tab-next)
nmap <C-t><C-t> <Plug>(my-tab-next)
nmap <C-t>l     <Plug>(my-tab-next)
nmap <C-t><C-l> <Plug>(my-tab-next)
nmap <C-t>T     <Plug>(my-tab-prev)
nmap <C-t>h     <Plug>(my-tab-prev)
nmap <C-t><C-h> <Plug>(my-tab-prev)
nmap <C-t>j     <Plug>(my-tab-$)
nmap <C-t><C-j> <Plug>(my-tab-$)
nmap <C-t>k     <Plug>(my-tab-0)
nmap <C-t><C-k> <Plug>(my-tab-0)

nmap <C-t>L     <Plug>(my-tab-move-R)
nmap <C-t>H     <Plug>(my-tab-move-L)
nmap <C-t>J     <Plug>(my-tab-move-$)
nmap <C-t>K     <Plug>(my-tab-move-0)

nmap <C-t>0 <Plug>(my-tab-0)
nmap <C-t>1 <Plug>(my-tab-1)
nmap <C-t>2 <Plug>(my-tab-2)
nmap <C-t>3 <Plug>(my-tab-3)
nmap <C-t>4 <Plug>(my-tab-4)
nmap <C-t>5 <Plug>(my-tab-5)
nmap <C-t>6 <Plug>(my-tab-6)
nmap <C-t>7 <Plug>(my-tab-7)
nmap <C-t>8 <Plug>(my-tab-8)
nmap <C-t>9 <Plug>(my-tab-9)
nmap <C-t>$ <Plug>(my-tab-$)
