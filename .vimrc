" Basically the same as Primeagen's vimrc 
" https://www.youtube.com/watch?v=n9k9scbTuvQ
" Will probably change a bit as I become more pro at vim

"Note to self: Add the following on a new machine's .profile to map caps lock
"to esc and to control when being used as a modifier
"setxkbmap -option 'caps:ctrl_modifier'
"xcape -e 'Caps_Lock=Escape' setxkbmap -option 'caps:ctrl_modifier'
"or on windows https://github.com/fenwar/ahk-caps-ctrl-esc

syntax on " Syntax highlighting on

set visualbell
set noerrorbells "No annoying sound effects when you go to the end of a line
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab "Spaces
set smartindent "Automatic indenting
set nu "Line numbers!
set rnu "Relative Line numbers
set nowrap "No wrapping
set ignorecase
set smartcase
set noswapfile "No swapfiles!
set nobackup "No backups!
set undodir=~/.vim/undodir
set undofile "Undos saved in above
set incsearch
set expandtab

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

"Plug, the plugin manager
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox' "Color scheme
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive' "Diffs, logs, git blame
Plug 'vim-airline/vim-airline' "Tells you what branch you're on and which file
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags' "C++
Plug 'ycm-core/YouCompleteMe' "Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Another autocomplete
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' "File finding
Plug 'mbbill/undotree'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

call plug#end()

colorscheme gruvbox "Sets colorscheme
set background=dark

" Helps detect your git root
if executable('rg')
    let g:rg_derive_root='true' 
endif

" Make the spacebar the leader key
let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

" Allows you to move a highlighted line up or down
vnoremap J :m '>+1<CR>gv=gv 
vnoremap K :m '<-2<CR>gv=gv 

"nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>
"nnoremap <silent> <Leader>gr :YcmCompleter GoToReferences<CR>
nmap <Leader>gd <Plug>(coc-definition)
nmap <Leader>gr <Plug>(coc-references)
nnoremap <C-p> :GFiles<CR> 

" For terminal
tnoremap <Esc> <C-\><C-n>

"Git fugitive
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>
