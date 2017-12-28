" enable pathogen plugin system
" mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" syntax highlighting
syntax on

" associate uncommon filetypes with the right syntax
au BufRead,BufNewFile *.pde setfiletype java

" indentation with spaces
let num_spaces_for_tab = 2
let &tabstop = num_spaces_for_tab
let &shiftwidth = num_spaces_for_tab
set smartindent
set expandtab

" incremental searching
set incsearch

" highlight matches
set hlsearch

" disable folding
set nofoldenable

" prevent comment continuation
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" send more characters for redraws
set ttyfast

" enable mouse
set mouse=a
set ttymouse=xterm2

" share system clipboard
set clipboard=unnamed

" NERDTree stuff
" git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
" 	hide executables
let NERDTreeIgnore = ['\.o$', '\.bin$', '\.class$', '\.jar$', '\.pyc$']

"   nicer width
let g:NERDTreeWinSize = 16

" no annoying ~ files that end up as litter on Windows
if has("win32")
    set nobackup
endif

