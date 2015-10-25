" Kod kiemeles
syntax on

" Filetipus erzekeles
filetype on
filetype indent on
filetype plugin on

" Eger
set mouse=a

" Sorszam mutatasa alul
set ruler

" Sorszamok bal oldalt
set number

" Hatter
if has('gui_running')
    colorscheme solarized
endif
set background=dark

" Parancs mutatas
set showcmd

" Zarojel parok mutatasa
set showmatch

" Leszarja a kisnagybetuket kereseskor
set ignorecase
set smartcase

" Keresesi talalatok kiemelese
set hlsearch

" Nem lathato karakterek muTatasa ( de csak sorvegi space es tab )
set list
set listchars=tab:>·,trail:·

" Kod kiegeszites (Ctrl+P)
set showfulltag
set completeopt=menu,longest,preview

" Szeretjuk a 80 oszlopot :) ... vagy nem
" set textwidth=80

" Tab
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set shiftround
set smartindent

" Ha egy fajl megvaltozott csak toltsd be, ne kerdezd
set autoread

" Ctrl+c masolas a vagolapra
vnoremap <C-c> "*y

" Jelenlegi sor szinezese
set cul
hi CursorLine term=none cterm=none ctermbg=8

" GUI Menu es Toolbar eltuntetese
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar

" Powerline
let $PYTHONPATH='/usr/lib/python3.4/site-packages'
set laststatus=2

" Airline tabline felul a nyitott pufferekkel
let g:airline#extensions#tabline#enabled = 1

let g:airline_powerline_fonts = 1
