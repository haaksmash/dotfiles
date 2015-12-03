" Syntastic
let g:syntastic_python_checkers = ['pyflakes', 'pep8', 'pep257']
let g:syntastic_python_pep8_args='--ignore=E501'

""" Handy remaps
noremap <leader>b Oimport ipdb;ipdb.set_trace()<Esc>

" Don't use tabs in python files
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4
