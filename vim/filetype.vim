if exists('did_load_filetypes')
  finish
endif

augroup filetypedetect
  autocmd!
  " Markdown
  au BufNewFile,BufRead *.md setf markdown
  au BufNewFile,BufRead *.mkd setf markdown
  au BufNewFile,BufRead *.markdown setf markdown
  " CoffeeScript
  au BufNewFile,BufRead *.coffee setf coffee
  au BufNewFile,BufRead Cakefile setf coffee
  " LESS
  au BufNewFile,BufRead *.less setf less
  " SASS/SCSS
  au BufNewFile,BufRead *.sass setf sass
  au BufNewFile,BufRead *.scss setf scss
  " Python
  au BufNewFile,BufRead SConstruct setf python
  " EcellModel
  au BufNewFile,BufRead *.em setf EcellModel
augroup END