" Syntax highlighting
set t_Co=256 " 256 color term
set background=dark
syntax on
color molokai
hi ColorColumn ctermbg=lightgrey guibg=lightgrey
" 2014-09-20: added to improve readability of comments
highlight comment ctermfg=245

" General
set nocompatible " With vi
filetype plugin indent on
set autochdir " Change into file's dir.
set fileformats=unix,dos,mac " Support all, prefer unix
set encoding=utf8 " Use UTF-8 as standard encoding
set hidden

set ofu=syntaxcomplete#Complete " Omnicomplete
let g:SuperTabDefaultCompletionType = "context" " Supertab

let g:syntastic_python_checkers=['flake8']
" Set max line length to 80 instead of 79 for flake8 plugin.
let g:syntastic_python_checker_args = '--max-line-length=80'
" let g:syntastic_python_python_exec = '/usr/bin/python2.7'
call pathogen#infect()

set nobackup
set nowritebackup
set noswapfile

set textwidth=80 " 80 chars per line
set colorcolumn=+1 " 80 char mark
set linebreak " Break lines after 80 chars at logical points
set wrap " And otherwise always
set number " Line numbers
set numberwidth=5 " 99999 lines max
set showmatch " Matching braces
set cursorline
set laststatus=2 " Always show status line
set wildmenu " Better tab-complete when selecting files
set wildmode=list:longest " Like bash (complete to common string, show list)
set wildignore=*.pdf,*.pyc,*.o,*.so,*.jpg,*.png,main,*~
set scrolloff=5 " Always keep current line five lines off the screen edge

" No sound/bells
set noerrorbells
set novisualbell " Don't flash screen
set t_vb=
set tm=500

" Searching
set incsearch " Incremental search
set ignorecase
set smartcase
set hlsearch " Highlight search results
set wrapscan " Wrap around

" Indentation (4 spaces)
set smarttab
set expandtab
set autoindent
"set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Also map : to ; for no-shift
nnoremap ; :

" Escape from insert mode with jj
inoremap jj <Esc>

" Move a line of text using alt+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Remove trailing whitespace
au BufWrite * :%s/\s\+$//e

" Spell check in LaTeX files
autocmd FileType tex setlocal spell spelllang=en_gb

" Smart home
map <khome> <home>
nmap <khome> <home>
inoremap <silent> <home> <C-O>:call Home()<CR>
nnoremap <silent> <home> :call Home()<CR>
function! Home()
    let curcol = wincol()
    normal ^
    let newcol = wincol()
    if newcol == curcol
        normal 0
    endif
endfunction

" Restore last cursor position
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

command! W w
command! Q q
command! WQ wq
command! Wq wq
command! Bd bd
command! Tlo TlistOpen
command! Qa qa


" Auto reload vimrc after editing
autocmd! bufwritepost ~/.vimrc source ~/.vimrc

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Disable F1
map <F1> <nop>
imap <F1> <nop>
