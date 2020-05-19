" Basically the same as Primeagen's vimrc 
" https://www.youtube.com/watch?v=n9k9scbTuvQ
" Will probably change a bit as I become more pro at vim

syntax on " Syntax highlighting on

set visualbell
set noerrorbells "No annoying sound effects when you go to the end of a line
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab "Spaces
set smartindent "Automatic indenting
set nu "Line numbers!
set nowrap "No wrapping
set ignorecase
set smartcase "Case insensitive searching unless it makes sense to
set noswapfile "No swapfiles!
set nobackup "No backups!
set undodir=~/.vim/undodir
set undofile "Undos saved in above
set incsearch "Get results while you search

set colorcolumn=80 "Column at 80 characters
highlight ColorColumn ctermbg=0 guibg=lightgrey

"Plug, the plugin manager
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox' "Best color scheme known to man
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive' "Diffs, logs, git blame
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags' "C++
Plug 'kien/ctrlp.vim' "File finding
Plug 'ycm-core/YouCompleteMe' "Autocomplete
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive' "Git integration
Plug 'vim-airline/vim-airline' "Tells you what branch you're on and which file

call plug#end()

colorscheme gruvbox "Sets colorscheme
set background=dark

" Helps detect your git root
if executable('rg')
    let g:rg_derive_root='true' 
endif

" Ignore stuff from search
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Make the spacebar the leader key
let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:ctrlp_use_caching = 0

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

"Move text up or down
vnoremap J :m '>+1<CR>gv=gv 
vnoremap K :m '<-2<CR>gv=gv 

"YouCompleteMe
nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <Leader>gr :YcmCompleter GoToReferences<CR>

"Git fugitive
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>
