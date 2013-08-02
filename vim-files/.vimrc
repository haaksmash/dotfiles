filetype off

call pathogen#infect()
call pathogen#helptags()
let g:pymode_lint=0

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


set backspace=indent,eol,start
set showmode
set number
set numberwidth=1
set background=dark
set cursorline
set cursorcolumn
set ruler

set matchpairs+=<:>

set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>
set list


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

""" Powerline
""" set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim


""" Handy remaps
:noremap ; :
:inoremap jj <Esc>
nnoremap <silent> <F8> :TlistToggle<CR>
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

""" Use the mouse
set mouse=a

