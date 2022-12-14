" Somewhat Based on the Primeagen's vimrc 
" https://www.youtube.com/watch?v=n9k9scbTuvQ
" Will probably change a bit as I become more pro at vim (hopefully) and become less noob

"Note to self: Add the following on a new machine's .profile to map caps lock
"to control when being used as a modifier
"setxkbmap -option 'caps:ctrl_modifier'
" or in https://superuser.com/questions/949385/map-capslock-to-control-in-windows-10


" Make sure to create ~/.vim/undodir and ~/.vim/backupdir

syntax on " Syntax highlighting on

set visualbell
set noerrorbells "No annoying sound effects when you go to the end of a line
set tabstop=4 softtabstop=4
set shiftwidth=4
" No spaces now: set expandtab "Spaces
set smartindent "Automatic indenting
set nu "Line numbers!
set rnu "Relative Line numbers
set nowrap "No wrapping
set ignorecase
set smartcase
set noswapfile "No swapfiles!
"set nobackup "No backups!
set backup writebackup
set backupdir-=.
set backupdir^=~/.vim/backupdir,/tmp
set undodir=~/.vim/undodir
set undofile "Undos saved in above
set hlsearch "Highlight searched items
set noincsearch
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

set hidden
set cmdheight=2 "Better display messages

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" " delays and poor user experience.
set updatetime=300

"Plug, the plugin manager
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox' "Color scheme
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive' "Diffs, logs, git blame
Plug 'vim-airline/vim-airline' "Tells you what branch you're on and which file; recommended by primeagen in https://youtu.be/PO6DxfGPQvw?
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' "File finding
Plug 'mbbill/undotree'
Plug 'tpope/vim-commentary', "Comments!
Plug 'terryma/vim-multiple-cursors' "Multiple Cursors
Plug 'sheerun/vim-polyglot' "Support for a bunch of Languages
Plug 'psliwka/vim-smoothie' "Smooth scrolling
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

" Magic. Mainly for faster latex typing
Plug 'SirVer/ultisnips', { 'for': ['tex', 'markdown', 'pandoc'] } 

Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'} "Game for vim

Plug 'chrisbra/csv.vim'

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

" Space is still better than using ctrl-w on qwerty
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>

" nnoremap <silent> <Leader>+ :vertical resize +5<CR>
" nnoremap <silent> <Leader>- :vertical resize -5<CR>

" Allows you to move a highlighted line up or down
vnoremap J :m '>+1<CR>gv=gv 
vnoremap K :m '<-2<CR>gv=gv 

" Fzf File Finding
nnoremap <C-p> :GFiles<CR> 

"
" COC STUFF

"""""""""""""""
" GIT FUGITIVE
"""""""""""""""
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>

" Get rid of arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" For vim debugging (not vimspector)
let g:termdebug_wide=1
packadd termdebug
" Add mappings for :Step and :Over
noremap <silent> <leader>s :Step<cr>
" noremap <silent> <leader>o :Over<cr>

" Enable auto reload of files
set autoread
au FocusGained,BufEnter * :checktime

" DEBUGGER REMAPS FOR VIMSPECTOR
" Note to self: Make sure to install coc-java and coc-java-debug when debugging java
" Copied from https://github.com/awesome-streamers/awesome-streamerrc/blob/master/ThePrimeagen/init.vim

"
" CUSTOM REMAPS
"
" https://vi.stackexchange.com/a/3877
" "_ selects the 'blackhole' buffer and D deletes as expected
nnoremap <Leader>o o<Esc>0"_D
nnoremap <Leader>O O<Esc>0"_D

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
