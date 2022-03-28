
" zo : open a single fold under the cursor
" zc : close the fold under the cursor
" zR : open all folds
" zM : close all folds
"####################################################################
"########################## Key Binding #############################
"####################################################################
" MAPPINGS ------------------------------------------------------ {{{

" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <C-j> <c-w>j
nnoremap <C-k> <c-w>k
nnoremap <C-h> <c-w>h
nnoremap <C-l> <c-w>l

nnoremap k gk
nnoremap j gj

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" Set the backslash as the leader key.
let mapleader = "\\"

" Press \\ to jump back to the last cursor position.
nnoremap <leader>\ ``

" Press \p to print the current file to the default printer
" from a Linux operating system.
" View available printers:   lpstat -v
" Set default printer:       lpoptions -d <printer_name>
" <silent> means do not display output.
nnoremap <silent> <leader>p :%w !lp<CR>

" Type jj to exit insert mode quickly.
inoremap jj <Esc>


" Press the space bar to type the : character in command mode.
nnoremap <space> :

" Pressing the letter o will open a new line below the current one.
" Exit insert mode after creating a new line above or below the current line.
"nnoremap o o<esc>
"nnoremap O O<esc>


" Yank from cursor to the end of line.
nnoremap Y y$

" Map the F5 key to run a Python script inside Vim.
" We map F5 to a chain of commands here.
" :w saves the file.
" <CR> (carriage return) is like pressing the enter key.
" !clear runs the external clear screen command.
" !python3 % executes the current file with Python.
nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>


" NERDTree specific mappings.
" Map the F3 key to toggle NERDTree open and close.
nnoremap <F3> :NERDTreeToggle<cr>

" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$',
			\ '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$',
			\ '\.odt$', '\.png$', '\.gif$', '\.db$']

nnoremap <c-\>q :wq!<CR>

"# to use ctrl + c, add the following line to .bashrc
"# enable control-s and control-q
"stty -ixon
nmap <silent> <c-s> :w!<CR>

" }}}

"####################################################################
"########################## Search option############################
"####################################################################
"
" SEARCH OPTION ------------------------------------------------- {{{
" highlight all search pattern
set hlsearch

" While searching though a file incrementally
" highlight matching characters as you type.
set incsearch
"set noincsearch

" case insensitive or sensitive search
"	smarcase option is vaild when if the ignorecase is set
set ignorecase
"set noignorecase

" smart search
"		enable both ignorecase and noignorecase
"		if search keyword contains lowercase only,
"		search with ignorecase but if search keyword
"		contains one or more uppercase, search with
"		noignorecase
set smartcase
" set nosmartcase

" Show matching words during a search.
set showmatch

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz
"}}}

"####################################################################
"########################## Cscope ##################################
"####################################################################
" CSCOPE ----------------- {{{
if has('cscope')
    set cscopetag cscopeverbose

    if has('quickfix')
        set cscopequickfix=s-,c-,d-,i-,t-,e-
    endif

    cnoreabbrev csa cs add
    cnoreabbrev csf cs find
    cnoreabbrev csff cs find f
    cnoreabbrev csfe cs find e
    cnoreabbrev csk cs kill
    cnoreabbrev csr cs reset
    cnoreabbrev csss cs show
    cnoreabbrev csh cs help

    "command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
    set nocscopeverbose
    set cscopetagorder=0
    set cscopetag
    set cscopeverbose
    set tagbsearch
endif
" }}}

"####################################################################
"########################## Etc option ##############################
"####################################################################
" ETC OPTION -----------------------------------{{{

set autochdir

syntax on " syntax highlighting
set tabstop=4 " Set tab width to 4 columns.
set shiftwidth=4 " Set shift width to 4 spaces.
set background=dark
set autoindent " automatic indentation
" set noautoindent
set smartindent
set ruler
set number " Add numbers to the file.
set title
set visualbell "blink when press wrong key

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" influnce how many idential lines are kept around changes(default: 6)
set diffopt+=context:0



" config colorscheme
" there are list of colorscheme
"		blue       default    desert     evening    koehler    murphy
"		peachpuff  shine      torte      darkblue   delek      elflord
"		industry   morning    pablo      ron        slate      zellner
"colorscheme desert

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection.
" Vim will be able to try to detect the type of file is use.
filetype on

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
"set cursorcolumn



" Use space characters instead of tabs.
set expandtab

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode



" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

set backspace=indent,start,eol

"" Need to be check"

set omnifunc=syntaxcomplete#Complete

map <F3> :match Errormsg '.\%>80v.\+'<CR>
map <F5> <c-o>
map <F6> <c-i>

"enable folding
set foldmethod=indent
set foldlevel=99
set shortmess+=A

map <c-\>b :silent call BuildSpringProject() \| redraw!<CR>


set wrap " turn on word wrap
"set wrap! " turn off word wrap

" configuration for auto-pairs
" disable to call AutoPairsDelete() function
let g:AutoPairsMapBS=0
let g:AutoPairsMapCh=0
" }}}

"####################################################################
"########################## Plugins option###########################
"####################################################################
" PLUGINS ------------------------------------------------------- {{{

"call plug#begin('~/.vim/plugged')
"
"  Plug 'dense-analysis/ale'
"
"  Plug 'preservim/nerdtree'
"
"call plug#end()

" }}}

"####################################################################
"########################## VIM Script ##############################
"####################################################################
" VIMSCRIPT ----------------------------------------------------- {{{

" Enable the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END


" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" You can split a window into sections by typing `:split` or `:vsplit`.
" Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    "autocmd WinEnter * set cursorline cursorcolumn
    autocmd WinEnter * set cursorline
augroup END

" If GUI version of Vim is running set these options.
if has('gui_running')

    " Set the background tone.
    set background=dark

    " Set the color scheme.
    colorscheme molokai

    " Set a custom font you have installed on your computer.
    " Syntax: <font_name>\ <weight>\ <size>
    set guifont=Monospace\ Regular\ 12

    " Display more of the file by default.
    " Hide the toolbar.
    set guioptions-=T

    " Hide the the left-side scroll bar.
    set guioptions-=L

    " Hide the the left-side scroll bar.
    set guioptions-=r

    " Hide the the menu bar.
    set guioptions-=m

    " Hide the the bottom scroll bar.
    set guioptions-=b

    " Map the F4 key to toggle the menu, toolbar, and scroll bar.
    " <Bar> is the pipe character.
    " <CR> is the enter key.
    nnoremap <F4> :if &guioptions=~#'mTr'<Bar>
        \ set guioptions-=mTr<Bar>
        \else<Bar>
        \ set guioptions+=mTr<Bar>
        \endif<CR>

endif

" }}}

"####################################################################
"########################## Status Line #############################
"####################################################################
"
"STATUS LINE ---------------------------------------------------- {{{
"set statusline=%h%f%m%r%=[%l:%c(%p%%)]
" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
"set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2

" }}}

"####################################################################
"########################## File specific ###########################
"####################################################################
"
" MAPPINGS ------------------------------------------------------ {{{
set noexpandtab

autocmd BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    "\ set noexpandtab |
    \ set expandtab |
    \ set autoindent |
    \ set smartindent cinwords=
			\if,elif,else,for,while,try,except,finally,def,class |
    \ set nocindent |
    "\ set textwidth=79 |
    \ set fileformat=unix |
    \ let g:python_recomented_style = 0

"autocmd BufNewFile,Bufread *.java
"    \ set tabstop=4 |
"    \ set softtabstop=4 |
"    \ set shiftwidth=4 |
"    "\ set expandtab |
"    \ set noexpandtab |
"    \ set autoindent |
"    \ set smarttab |
"    \ set nocindent |
"    \ set textwidth=79 |
"    \ set fileformat=unix |
"    \ let b:comment_leader = '//'

autocmd BufNewFile,BufRead *.java
    \ set tabstop=4 |
    \ set softtabstop=0 |
    \ set shiftwidth=4 |
    "\ set noexpandtab |
    \ set expandtab |
    \ set autoindent |
    \ set smarttab |
    \ set smartindent cinwords=
			\if,elif,else,for,while,try,except,finally,def,class |
    \ set nocindent |
    \ set fileformat=unix |
    \ let b:comment_leader = '//' |
    \ let g:python_recomented_style = 0

autocmd BufNewFile,BufRead *.sh
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    "\ set noexpandtab |
    \ set expandtab |
    \ set autoindent |

autocmd BufNewFile,BufRead *.html
    \ set tabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab

autocmd BufNewFile,BufRead *.*
    \ call CustomMark()
" }}}
"####################################################################
"############################ vim scheme ############################
"####################################################################

" VIM SCHEME ---------------------------------------------------- {{{
let airline_themes="../vim-airline/autoload/airline/themes.vim"
let airline_themes_dark="../vim-airline/autoload/airline/themes/dark.vim"
if !empty(glob(airline_themes)) && !empty(glob(airline_themes_dark))
	execute "source "airline_themes
	execute "source "airline_themes_dark

	let s:airline_a_inactive = [ '#4e4e4e' , '#1c1c1c' , 239 , 234 , '' ]
	let s:airline_b_inactive = [ '#4e4e4e' , '#262626' , 239 , 235 , '' ]
	let s:airline_c_inactive = [ '#4e4e4e' , '#303030' , 239 , 236 , '' ]

	let s:airline_a_normal   = [ '#00005f' , '#dfff00' , 17  , 190 ]
	let s:airline_b_normal   = [ '#ffffff' , '#444444' , 255 , 238 ]
	let s:airline_c_normal   = [ '#9cffd3' , '#202020' , 85  , 234 ]

	if exists('g:airline#themes#dark#palette') &&
		\ exists('*airline#themes#generate_color_map')
		let g:airline#themes#dark#palette.inactive =
			\ airline#themes#generate_color_map(
				\ s:airline_a_inactive,
				\ s:airline_b_inactive,
				\ s:airline_c_normal)
	endif
endif

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
" }}}
