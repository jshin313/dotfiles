" Basically the same as Primeagen's vimrc 
" https://www.youtube.com/watch?v=n9k9scbTuvQ
" Will probably change a bit as I become more pro at vim

"Note to self: Add the following on a new machine's .profile to map caps lock
"to esc and to control when being used as a modifier
"setxkbmap -option 'caps:ctrl_modifier'
"xcape -e 'Caps_Lock=Escape' setxkbmap -option 'caps:ctrl_modifier'
"or on windows https://github.com/fenwar/ahk-caps-ctrl-esc

" Make sure to create ~/.vim/undodir and ~/.vim/backupdir

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
"set nobackup "No backups!
set backup writebackup
set backupdir-=.
set backupdir^=~/.vim/backupdir,/tmp
set undodir=~/.vim/undodir
set undofile "Undos saved in above
set hlsearch "Highlight searched items
set noincsearch
set expandtab
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

set hidden
set cmdheight=2 "Better display messages

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" " delays and poor user experience.
set updatetime=300

"For latex
filetype plugin on
autocmd Filetype tex setl updatetime=1

"Plug, the plugin manager
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox' "Color scheme
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive' "Diffs, logs, git blame
Plug 'vim-airline/vim-airline' "Tells you what branch you're on and which file
Plug 'vim-utils/vim-man'
"Plug 'ycm-core/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Another autocomplete
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' "File finding
Plug 'mbbill/undotree'
Plug 'tpope/vim-commentary', "Comments!
Plug 'terryma/vim-multiple-cursors' "Multiple Cursors
Plug 'sheerun/vim-polyglot' "Support for a bunch of Languages
Plug 'psliwka/vim-smoothie' "Smooth scrolling
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' } "Latex
Plug 'vim-pandoc/vim-pandoc' "Markdown
Plug 'vim-pandoc/vim-pandoc-syntax' 
Plug 'KeitaNakamura/tex-conceal.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
"Plug 'sirver/ultisnips', { 'for': 'tex' } 

Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'} "Game for vim
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

" Fzf File Finding
nnoremap <C-p> :GFiles<CR> 

""" Autocomplete Remaps
"nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>
"nnoremap <silent> <Leader>gr :YcmCompleter GoToReferences<CR>

" GoTo code navigation
" Make sure to download clangd for c
" and jedi and pylint for python
nmap <silent><leader>gd <Plug>(coc-definition)
nmap <silent><leader>gy <Plug>(coc-type-definition)
nmap <silent><leader>gi <Plug>(coc-implementation)
nmap <silent><leader>gr <Plug>(coc-references)

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <tab>
            \ pumvisible() ? "\<c-n>" :
            \ <sid>check_back_space() ? "\<tab>" :
            \ coc#refresh()

" For terminal
" Make esc enter normal mode for terminal mode
tnoremap <Esc> <C-\><C-n>

if has('nvim')
    "When in terminal mode remove line numbers
    au TermOpen * setlocal listchars= nonumber norelativenumber
    au TermOpen * startinsert
endif

"Git fugitive
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>

"Latex stuff
let g:livepreview_previewer = 'sumatraPDF'
nmap <F12> :LLPStartPreview<CR>
set conceallevel=1
let g:tex_conceal='abdmg'
hi Conceal ctermbg=none
"From the following link:
"https://castel.dev/post/lecture-notes-1/
"Too slow rn for my laptop
" let g:UltisnipsExpandTrigger = '<tab>'
" let g:UltiSnipsJumpForwardTrigger = '<tab>'
" let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" Markdown Stuff
au BufWritePost *.md nmap <leader>p :!pandoc -o %:r.pdf -t beamer % <CR><CR>
nmap <C-s> <Plug>MarkdownPreview
let g:mkdp_markdown_css = '~/.local/lib/github-markdown-css/github-markdown.css'
autocmd FileType markdown set conceallevel=0
au VimEnter *.md normal zR
