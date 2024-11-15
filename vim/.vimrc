" Somewhat Based on the Primeagen's vimrc 
" https://www.youtube.com/watch?v=n9k9scbTuvQ

"Note to self: Add the following on a new machine's .profile to map caps lock
"to control when being used as a modifier
"setxkbmap -option 'caps:ctrl_modifier'
" or in https://superuser.com/questions/949385/map-capslock-to-control-in-windows-10

" Make sure to create ~/.vim/undodir and ~/.vim/backupdir

syntax on " Syntax highlighting on

set visualbell
set noerrorbells "No annoying sound effects when you go to the end of a line
set tabstop=4
set softtabstop=4
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
set nohlsearch "Highlight searched items
set incsearch
set colorcolumn=80
set scrolloff=8
set signcolumn=auto
set updatetime=50
set termguicolors

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

Plug 'tpope/vim-commentary', "Comments!
Plug 'terryma/vim-multiple-cursors' "Multiple Cursors
Plug 'psliwka/vim-smoothie' "Smooth scrolling

" Magic. Mainly for faster latex typing
Plug 'SirVer/ultisnips'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'lervag/vimtex', { 'for': 'tex' }

" LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" " Autocompletion
" Plug 'hrsh7th/nvim-cmp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-path'
" Plug 'saadparwaiz1/cmp_luasnip'
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-nvim-lua'

"  Snippets
" Plug 'L3MON4D3/LuaSnip'
" Plug 'rafamadriz/friendly-snippets'

" Plug 'VonHeikemen/lsp-zero.nvim'

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
" Most of the remaps below were from the Primeagen
""""""""""""""""""

nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>pv :Ex<CR>
" let g:netrw_browse_split = 2
" let g:netrw_banner = 0
" let g:netrw_winsize = 25

" Allows you to move a highlighted line up or down
vnoremap J :m '>+1<CR>gv=gv 
vnoremap K :m '<-2<CR>gv=gv 

" Allows for centering of screen when scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Allows for centering of screen when searching
nnoremap n nzzzv
nnoremap N Nzzzv

" Allows for pasting without moving deleted text into current buffer
xnoremap <leader>p "_dP

nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Quickfix
nnoremap <C-k> <cmd>cnext<CR>zz
nnoremap <C-j> <cmd>cprev<CR>zz
nnoremap <leader>k <cmd>lnext<CR>zz
nnoremap <leader>j <cmd>lprev<CR>zz

" Cool remap for finding and replacing current word your cursor is on
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" https://vi.stackexchange.com/a/3877
" "_ selects the 'blackhole' buffer and D deletes as expected
nnoremap <leader>o o<Esc>0"_D
nnoremap <leader>O O<Esc>0"_D

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
let g:python3_host_prog='/usr/bin/python3'

""""""""""""""""
" LATEX
""""""""""""""""
set wrap

let g:tex_flavor='latex'
" let g:vimtex_view_method='zathura_simple'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

let g:fasttex = 0

if g:fasttex == 1
	" Fast tex rendering from
	" https://github.com/ejmastnak/dotfiles
	function! JumpAndWrite() abort
		write
		call UltiSnips#JumpForwards()
	endfunction

	noremap <C-n> <Cmd>call JumpAndWrite()<CR>
	inoremap <C-n> <Cmd>call JumpAndWrite()<CR>
	let g:UltiSnipsJumpForwardTrigger = '<tab>'
    if has('win32') || (has('unix') && exists('$WSLENV'))
      let g:vimtex_view_general_viewer = 'mupdf.exe'
	else
	  let g:vimtex_view_method = 'mupdf'
    endif

else
	let g:UltiSnipsJumpForwardTrigger = '<C-n>'
endif

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<c-p>'

" The two below are from 
" https://www.ejmastnak.com/tutorials/vim-latex/compilation.html#using-vimtexs-compilation-interface
" Don't open QuickFix for warning messages if no errors are present
let g:vimtex_quickfix_open_on_warning = 0
" Filter out some compilation warning messages from QuickFix display
let g:vimtex_quickfix_ignore_filters = [
      \ 'Underfull \\hbox',
      \ 'Overfull \\hbox',
      \ 'LaTeX Warning: .\+ float specifier changed to',
      \ 'LaTeX hooks Warning',
      \ 'Package siunitx Warning: Detected the "physics" package:',
      \ 'Package hyperref Warning: Token not allowed in a PDF string',
      \]
