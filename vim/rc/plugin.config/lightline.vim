" TODO: syntastic/neomake

if neobundle#tap('lightline.vim')
  function! neobundle#hooks.on_source(bundle) abort
    let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [
      \     ['mode', 'paste'],
      \     ['filename', 'currenttag'],
      \     ['gita_debug', 'gita_branch', 'gita_traffic', 'gita_status', 'cwd'],
      \   ],
      \   'right': [
      \     ['lineinfo'],
      \     ['percent']
      \     ['fileformat', 'fileencoding', 'filetype'],
      \   ],
      \ },
      \ 'inactive': {
      \   'left': [
      \     ['filename'],
      \   ],
      \   'right': [
      \     ['fileformat', 'fileencoding', 'filetype'],
      \   ],
      \ },
      \ 'component_visible_condition': {
      \   'lineinfo': '(winwidth(0) >= 70)',
      \ },
      \ 'component_function': {
      \   'mode': 'lightline#mode',
      \   'cwd': 'g:lightline.my.cwd',
      \   'filename': 'g:lightline.my.filename',
      \   'fileformat': 'g:lightline.my.fileformat',
      \   'fileencoding': 'g:lightline.my.fileencoding',
      \   'filetype': 'g:lightline.my.filetype',
      \   'gita_debug': 'g:lightline.my.gita_debug',
      \   'gita_branch': 'g:lightline.my.gita_branch',
      \   'git_branch': 'g:lightline.my.git_branch',
      \   'gita_traffic': 'g:lightline.my.gita_traffic',
      \   'gita_status': 'g:lightline.my.gita_status',
      \ },
      \}

    function! g:lightline.my.modified()
    function! MyModified()
      return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction
    function! MyReadonly()
      return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
    endfunction
    function! MyFilename()
      let fname = expand('%:t')
      return fname =~ '__Gundo' ? '' :
            \ fname == '__Tagbar__' ? g:lightline.fname :
            \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
            \ &ft == 'unite' ? unite#get_status_string() :
            \ &ft == 'vimshell' ? vimshell#get_status_string() :
            \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
            \ ('' != fname ? fname : '[No Name]') .
            \ ('' != MyModified() ? ' ' . MyModified() : '')
    endfunction
    function! MyFugitive()
      try
        if expand('%:t') !~? 'Tagbar\|Gundo' && &ft !~? 'vimfiler' && exists('*fugitive#head')
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
            \ fname == '__Tagbar__' ? 'Tagbar' :
            \ &ft == 'unite' ? 'Unite' :
            \ &ft == 'vimfiler' ? 'VimFiler' :
            \ &ft == 'vimshell' ? 'VimShell' :
            \ winwidth(0) > 60 ? lightline#mode() : ''
    endfunction
    function! MyCurrentTag()
      return tagbar#currenttag('%s', '')
    endfunction
    function! TagbarStatusFunc(current, sort, fname, ...) abort
        let g:lightline.fname = a:fname
      return lightline#statusline(0)
    endfunction
    let g:tagbar_status_func = 'TagbarStatusFunc'
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
  endfunction
  call neobundle#untap()
endif
