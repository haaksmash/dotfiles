" Neomake
let g:neomake_python_enabled_makers = ['flake8']

""" Handy remaps
noremap <leader>b Oimport ipdb;ipdb.set_trace()<Esc>

" Don't use tabs in python files
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4
