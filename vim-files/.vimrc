call pathogen#infect()
call pathogen#helptags()
""" Python-Mode settings
let g:pymode_lint_checker = "pyflakes, pep8"

let g:pymode_rope=0 "don't rope autocomplete

let g:pymode_breakpoint_cmd = 'import ipdb;ipdb.set_trace() # FIXME: breakpoint!'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0
""" End Python-Mode settings

let mapleader=","
set nobackup
set noswapfile
set pastetoggle=<F2>

filetype on
filetype plugin indent on
syntax on

colorscheme lucius

set t_Co=256
if &term =~ 'xterm-color'
	set t_ut=
endif
let g:Powerline_symbols = 'fancy'
set nocompatible
set laststatus=2

if v:version >= 703
	    "undo settings
	set undodir=~/.vim/undofiles
	set undofile

	set colorcolumn=+1 "mark the ideal max text width
endif


set showmode
set number
set numberwidth=1
set background=dark
set cursorline
set cursorcolumn
set ruler
" do not redraw while macroing
set lazyredraw

set matchpairs+=<:>

set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:+,eol:$

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

""" Searching and Patterns
set ignorecase
set smartcase
set smarttab
set hlsearch
" Add the g flag to search/replace by default
set gdefault

""" Folding
set nofoldenable


""" Statusline
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline =%#identifier#
set statusline+=%{fugitive#statusline()}
set statusline+=[%f]    "tail of the filename
set statusline+=%*

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"modified flag
set statusline+=%#identifier#
set statusline+=%m
set statusline+=%*
set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2


"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected return '' otherwise
function! StatuslineTrailingSpaceWarning()
	if !exists("b:statusline_trailing_space_warning")

		if !&modifiable
			let b:statusline_trailing_space_warning = ''
			return b:statusline_trailing_space_warning
		endif

		if search('\s\+$', 'nw') != 0
			let b:statusline_trailing_space_warning = '[\s]'
		else
			let b:statusline_trailing_space_warning = ''
		endif
	endif
	return b:statusline_trailing_space_warning
endfunction


""" CtrlP


""" Handy remaps
noremap ; :
inoremap jj <Esc>
nnoremap <silent> <F8> :TlistToggle<CR>
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
"nnoremap <leader>d :NERDTreeToggle<cr>
map \q :q<CR>
map \w :w<CR>


" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Don’t reset cursor to start of line when moving around.
set nostartofline
" minimal number of lines to keep above/below cursorline
set scrolloff=10


""" Use the mouse
set mouse=a

" Powerline!
set rtp+=~/dotfiles/misc-files/powerline/powerline/bindings/vim
"
" Don't use tabs in python files
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction
