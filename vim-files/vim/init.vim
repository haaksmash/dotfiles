set nocompatible " required
filetype off " required

"""" VIM-PLUG
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'

Plug 'nanotech/jellybeans.vim'

Plug 'bling/vim-airline'
Plug 'myusuf3/numbers.vim'
Plug 'mhinz/vim-signify'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'kien/rainbow_parentheses.vim'

Plug 'danro/rename.vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/tpope-vim-abolish'
Plug 'terryma/vim-multiple-cursors'

Plug 'tpope/vim-eunuch'

Plug 'majutsushi/tagbar'
Plug 'SirVer/ultisnips'
Plug 'zhaocai/GoldenView.Vim'


Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'simnalamburt/vim-mundo'
Plug 'janko-m/vim-test'

Plug 'tpope/vim-endwise'

Plug 'benekastah/neomake'
Plug 'Valloric/YouCompleteMe'

Plug 'vim-ruby/vim-ruby'
Plug 'elmcast/elm-vim'
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'mtscout6/vim-cjsx'
Plug 'mxw/vim-jsx'

Plug 'tpope/vim-rails'

call plug#end()

filetype plugin indent on     " required
""" end vim-plug

"""" PLUGIN SETTINGS

" YouCompleteMe
nnoremap K :YcmCompleter GoTo<CR>
nnoremap ˚ :YcmCompleter GoToDeclaration<CR>
let g:ycm_goto_buffer_command = 'horizontal-split'
let g:ycm_autoclose_preview_window_after_insertion = 1

" Easymotion
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)
let g:EasyMotion_landing_highlight = 0

" CtrlP
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Gundo
map <leader>u :GundoToggle<CR>

" Indent guides
let g:indent_guides_start_level = 2

" Syntastic
let g:syntastic_quiet_messages = {'level': []} " do NOT silence warnings
let g:syntastic_aggregate_errors = 1

" Neomake
autocmd! BufWritePost * Neomake

" NERDTree / netrw
let g:netrw_liststyle = 3 " let netrw look like NERDTree

" Rainbow parentheses
autocmd VimEnter * RainbowParenthesesToggleAll

" Vim-Test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
if has('nvim')
  let test#strategy = "neovim"
endif

" UltiSnips
let g:UltiSnipsUsePythonVersion = 2 " required for YCM compat
let g:ulti_expand_or_jump_res = 0
function! ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction

" IndentGuides
let g:indent_guides_enable_on_vim_startup = 1

" GoldenView
autocmd BufRead * EnableGoldenViewAutoResize
let g:goldenview__enable_default_mapping = 0

"""" END PLUGIN SETTINGS

let mapleader=","
set nobackup
set noswapfile
set pastetoggle=<F2>
set nowrap

filetype on
filetype plugin indent on
syntax on

try
  colorscheme jellybeans
catch
  " deal with it
endtry

set t_Co=256
if &term =~ 'xterm-color'
    set t_ut=
endif
set nocompatible
set laststatus=2

if v:version >= 703
    "undo settings
    set undodir=~/.vim/undofiles
    set undofile
    let &colorcolumn="80,".join(range(120,999), ",")
endif


set hidden
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
set ts=2
set shiftwidth=2
set expandtab

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

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

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

" strip trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

""" Handy remaps
noremap ; :
inoremap jj <Esc>
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
map \q :q<CR>
map \w :w<CR>
noremap Q <nop>

"terminal remaps
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Don’t reset cursor to start of line when moving around.
set nostartofline
" minimal number of lines to keep above/below cursorline
set scrolloff=10

""" Use the mouse
set mouse=a

""" smart path
set path=.,,**

" Local overrides?
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif