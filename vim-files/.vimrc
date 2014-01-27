filetype off

call pathogen#infect()
call pathogen#helptags()
""" Python-Mode settings
let g:pymode_lint=0 "don't syntax-check
let g:pymode_lint_checker = "pyflakes, pep8"

let g:pymode_rope=0 "don't rope autocomplete

let g:pymode_breakpoint_cmd = 'import ipdb;ipdb.set_trace # FIXME: breakpoint!'

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

if v:version >= 704
	let g:jedi#completions_enabled = 0
endif


set showmode
set number
set numberwidth=1
set background=dark
set cursorline
set cursorcolumn
set ruler

set matchpairs+=<:>

set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:+,eol:$


""" Searching and Patterns
set ignorecase
set smartcase
set smarttab
set hlsearch

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
let g:ctrlp_show_hidden = 1

""" Handy remaps
:noremap ; :
:inoremap jj <Esc>
nnoremap <silent> <F8> :TlistToggle<CR>
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
nnoremap <leader>d :NERDTreeToggle<cr>


" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


""" Use the mouse
set mouse=a

" Powerline!
set rtp+=~/dotfiles/misc-files/powerline/powerline/bindings/vim
