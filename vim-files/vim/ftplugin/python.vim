
" Syntastic
let g:syntastic_python_checkers = ['pyflakes', 'pep8', 'pep257']
let g:syntastic_python_pep8_args='--ignore=E501'

""" Handy remaps
noremap <leader>b Oimport ipdb;ipdb.set_trace()<Esc>

setlocal ts=4
setlocal sw=4
setlocal expandtab

" Don't use tabs in python files
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4

function! RunTests(filename, test_path, debug)
    let tmux_pane = substitute(system("tmux display-message -p '#S'"),'\n','','')
    let tmux_pane_target = tmux_pane."_testing:1.0"
    echo tmux_pane_target

    let command = ""
    if l:tmux_pane == "checkout"
        " checkout uses py.test (or uh it will)
        if a:test_path != ' '
            let pytest_path = substitute(a:test_path, "\\.", "::", "")
            let full_test_path = a:filename."::".l:pytest_path
        else
            let full_test_path = a:filename
        endif

    if a:debug == 1
      let test_args = "-- -x --ipdb "
    else
      let test_args = ''
    endif

        if l:full_test_path != "::"
            let command = "silent !tmux send-keys -t ".tmux_pane_target." C-c ' tox ".test_args.full_test_path." -- --currency USD 2>/dev/null' Enter"
        else
            let command = "silent !tmux send-keys -t ".tmux_pane_target." C-c ' make test 2>/dev/null' Enter"
        endif
    else
        " yelp-main uses testify
        if a:test_path != ' '
            let full_test_path = a:filename." ".a:test_path
        else
            let full_test_path = a:filename
        endif

    if a:debug == 1
      let test_args = "-d "
    else
      let test_args = ''
    endif

        if l:full_test_path != " "
            let command = "silent !tmux send-keys -t ".tmux_pane_target." C-c ' testify ".test_args.full_test_path."' Enter"
        endif
    endif
    echo command
    exec command
    exec "redraw!"
endfun

function! StoreTestPath(filename, lineno)
    let g:t= a:filename
    " trololol sorry hbai
    let g:f = system("python ~hbai/point_at_test/point_at_test.py ".shellescape(a:filename)." ".shellescape(a:lineno))
    let g:f=substitute(strtrans(g:f),'\^@',' ','g')
    echo g:t g:f
endfun

map <LEADER>s :call StoreTestPath(expand("%"), line("."))<CR>
map <LEADER>T :w\|:call StoreTestPath(expand("%"), line("."))<CR>\|:call RunTests(g:t, g:f, 0)<CR>
map <LEADER>t :w\|:call RunTests(g:t, g:f, 0)<CR>
map <LEADER>dt :w\|:call RunTests(g:t, g:f, 1)<CR>
map <LEADER>m :call RunTests("", "", 0)<CR>
