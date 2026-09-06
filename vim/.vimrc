" ----------
"  Search
" ----------
set ignorecase
set hlsearch    " Highlight search resut
set incsearch   " Enable incremental search
set smartcase   " ignore case with lowrcase search word
set wrapscan    " Search reached the bottom of file, search again from the top

" ------------
"  Appearance
" ------------

" Show line number
" https://qiita.com/spyder1211/items/c5dd49a3a799bd146599
set number

set noerrorbells

" ------------
"  Edit
" ------------
set showmatch matchtime=1

" Turn off paste mode when leaving insert
" https://archive.craftz.dog/blog.odoruinu.net/2014/01/29/how-to-turn-off-paste-mode-when-becoming-normal-mode-on-vim/index.html
autocmd InsertLeave * set nopaste

" ------------
"  Key map
" ------------
nnoremap + <C-a>
nnoremap - <C-x>
