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

map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

set number
set numberwidth=1
set background=dark
set cursorline
set cursorcolumn
set ruler

set matchpairs+=<:>

set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>
set list
set wrap


""" Searching and Patterns
set ignorecase
set smartcase
set smarttab
set hlsearch


""" Handy remaps
:noremap ; :
:inoremap jj <Esc>

""" Use the mouse
set mouse=a

""" Whitspace woes?
function! TrimWhiteSpace()
	%s/\s*$//
	''
endfunction

autocmd FileWritePre * :call TrimWhiteSpace()
autocmd FileAppendPre * :call TrimWhiteSpace()
autocmd FilterWritePre * :call TrimWhiteSpace()
autocmd BufWritePre * :call TrimWhiteSpace()
