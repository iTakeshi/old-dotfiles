let s:plugin_config_dir =
    \ dotfile_util#normpath('rc'. g:pathsep . 'plugin.config', 'config')
    \ . g:pathsep
call dotfile_util#source(s:plugin_config_dir . 'unite.vim')
call dotfile_util#source(s:plugin_config_dir . 'vimfiler.vim')

" tagbar
let g:tagbar_width = 40
nnoremap <silent> [toggle]t :<C-u>TagbarToggle<CR>
" autocmd MyAutoCmd VimEnter * TagbarToggle
