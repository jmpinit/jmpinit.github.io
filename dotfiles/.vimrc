" enable pathogen plugin system
" mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" syntax highlighting
syntax on

" associate uncommon filetypes with the right syntax
au BufRead,BufNewFile *.pde setfiletype java

" indentation with 4 spaces
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" incremental searching
set incsearch

" highlight matches
set hlsearch

" disable folding
set nofoldenable

" prevent comment continuation
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" NERDTree stuff
" cd ~/.vim/bundle && git clone https://github.com/scrooloose/nerdtree.git
" 	hide executables
let NERDTreeIgnore = ['\.o$', '\.bin$', '\.class$', '\.jar$', '\.pyc$']

"   nicer width
let g:NERDTreeWinSize = 16

" no annoying ~ files that end up as litter on Windows
if has("win32")
    set nobackup
endif

