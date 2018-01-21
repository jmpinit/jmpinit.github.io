" Configuration for vim-plug plugin manager
" =========================================
" Project repo: https://github.com/junegunn/vim-plug

" Automatically install vim-plug if necessary
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Fuzzy finder
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" NERDTree file tree navigation
"Plug 'scrooloose/nerdtree', {
"  \'NERDTreeIgnore': ['\.o$', '\.bin$', '\.class$', '\.jar$', '\.pyc$'],
"  \'NERDTreeWinSize': 16,
"\}

Plug 'scrooloose/nerdtree'

" Initialize plugin system
call plug#end()

" General configuration
" =====================

" Syntax highlighting
syntax on

" Associate uncommon filetypes with the right syntax
au BufRead,BufNewFile *.pde setfiletype java " Processing.org

" Indentation with spaces
let num_spaces_for_tab = 2
let &tabstop = num_spaces_for_tab
let &shiftwidth = num_spaces_for_tab
set smartindent
set expandtab

" Incremental searching
set incsearch

" Highlight matches
set hlsearch

" Disable folding
set nofoldenable

" Prevent comment continuation
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Enable mouse
set mouse=a
set ttymouse=xterm2

" Windows-specific configuration
if has("win32")
  " No annoying '~' files that end up as litter on Windows
  set nobackup
endif

