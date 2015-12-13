let s:plugin_config_dir =
    \ dotfile_util#normpath('rc'. g:pathsep . 'plugin.config', 'config')
    \ . g:pathsep
call dotfile_util#source(s:plugin_config_dir . 'complete.vim')
call dotfile_util#source(s:plugin_config_dir . 'unite.vim')
call dotfile_util#source(s:plugin_config_dir . 'vimfiler.vim')

" tagbar
let g:tagbar_width = 40
nnoremap <silent> [toggle]t :<C-u>TagbarToggle<CR>

" choosewin
nmap - <Plug>(choosewin)
let g:choosewin_overlay_enable = 1
let g:choosewin_overlay_clear_multibyte = 1

" capslock
nnoremap <silent> [toggle]c <Plug>CapsLockToggle

" easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Gundo
nnoremap <silent> [toggle]g :<C-u>GundoToggle<CR>

" hier
nmap <silent> <Esc><Esc> :<C-u>noh<CR>:<C-u>HierClear<CR>
