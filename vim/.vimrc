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

" Enable auto reload of files
set autoread
au FocusGained,BufEnter * :checktime

""""""""""""""""
" FTPLUGIN
""""""""""""""""
filetype on             " enable filetype detection
filetype plugin on      " load file-specific plugins
filetype indent on      " load file-specific indentation

"Plug, the plugin manager
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox' "Color scheme
Plug 'tpope/vim-fugitive' "Diffs, logs, git blame
Plug 'vim-airline/vim-airline' "Tells you what branch you're on and which file; recommended by primeagen in https://youtu.be/PO6DxfGPQvw?
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mbbill/undotree'
Plug 'ThePrimeagen/harpoon'

Plug 'tpope/vim-commentary', "Comments!
Plug 'terryma/vim-multiple-cursors' "Multiple Cursors
Plug 'psliwka/vim-smoothie' "Smooth scrolling

" Magic. Mainly for faster latex typing
Plug 'SirVer/ultisnips'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'lervag/vimtex'

" LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'

"  Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'VonHeikemen/lsp-zero.nvim'

Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'} "Game for vim

Plug 'chrisbra/csv.vim'

call plug#end()

colorscheme gruvbox "Sets colorscheme
set background=dark

" Make the spacebar the leader key
let mapleader = " "

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

""""""""""""""""""
" CUSTOM REMAPS
""""""""""""""""""
" https://vi.stackexchange.com/a/3877
" "_ selects the 'blackhole' buffer and D deletes as expected
nnoremap <Leader>o o<Esc>0"_D
nnoremap <Leader>O O<Esc>0"_D

nnoremap <leader>pv :Ex<CR>
" let g:netrw_browse_split = 2
" let g:netrw_banner = 0
" let g:netrw_winsize = 25

" Allows you to move a highlighted line up or down
vnoremap J :m '>+1<CR>gv=gv 
vnoremap K :m '<-2<CR>gv=gv 

"""""""""""""""""""""
" WSL YANK SUPPORT
"""""""""""""""""""""
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

""""""""""""""""
" SPELL CHECK
""""""""""""""""
setlocal spell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

""""""""""""""""
" ULTISNIPS
""""""""""""""""
let g:python3_host_prog='/usr/bin/python3.9'
" For some reason, need this
augroup filetype_tex
    set filetype=tex
augroup END
