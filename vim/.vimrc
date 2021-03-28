" Based on the Primeagen's vimrc 
" https://www.youtube.com/watch?v=n9k9scbTuvQ
" Will probably change a bit as I become more pro at vim

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
Plug 'lervag/vimtex'
Plug 'vim-pandoc/vim-pandoc' "Markdown
Plug 'vim-pandoc/vim-pandoc-syntax' 
Plug 'KeitaNakamura/tex-conceal.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

"Plug 'sirver/ultisnips', { 'for': 'tex' } 

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

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

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"More coc stuff:
" Use K to show documentation in preview window.
nnoremap <silent><leader>K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

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

"For latex
filetype plugin on
autocmd Filetype tex setl updatetime=1

"Latex stuff
"https://medium.com/@Pirmin/a-minimal-latex-setup-on-windows-using-wsl2-and-neovim-51259ff94734

let g:vimtex_latexmk_options = '-pdf -shell-escape -verbose -file-line-error -synctex=1 -interaction=nonstopmode'
let g:vimtex_compiler_latexmk = {
			\ 'options' : [
			\   '-pdf',
			\   '-shell-escape',
			\   '-verbose',
			\   '-file-line-error',
			\   '-synctex=1',
			\   '-interaction=nonstopmode',
			\ ],
			\}

" Detect if in WSL based on https://stackoverflow.com/a/57015339
let uname = substitute(system('uname'),'\n','','')
if uname == 'Linux'
    let lines = readfile("/proc/version")
    if lines[0] =~ "Microsoft"
        let g:vimtex_view_general_viewer = 'sumatraPDF'
        let g:vimtex_view_general_options = '-reuse-instance @pdf'
        let g:vimtex_view_general_options_latexmk = '-reuse-instance'
    endif
else
    let g:vimtex_view_general_viewer = 'zathura'
    let g:vimtex_view_general_options = ''
    let g:vimtex_view_general_options_latexmk = ''
endif

let g:tex_flavor = 'latex'
let g:vimtex_quickfix_enabled = 0

set conceallevel=1
let g:tex_conceal='abdmg'
hi Conceal ctermbg=none
nnoremap \lc :VimtexStop<cr>:VimtexClean<cr>

" Markdown Stuff
au BufWritePost *.md nmap <leader>p :!pandoc -o %:r.pdf -t beamer % <CR><CR>
nmap <C-s> <Plug>MarkdownPreview

" Get rid of arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" For vim debugging
let g:termdebug_wide=1
packadd termdebug
" Add mappings for :Step and :Over
noremap <silent> <leader>s :Step<cr>
noremap <silent> <leader>o :Over<cr>

" For cobol files
autocmd FileType cobol set sw=4 sts=4 et sta tw=72

" Enable auto reload of files
set autoread
au FocusGained,BufEnter * :checktime

" Firenvim stuff
let g:firenvim_config = { 
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'always',
        \ },
    \ }
\ }

" Blacklist for firenvim
let fc = g:firenvim_config['localSettings']
let fc['https?://twitch.tv'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://google.com'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://discovercard.com'] = { 'takeover': 'never', 'priority': 1 }

" Debugger remaps 
" Copied from https://github.com/awesome-streamers/awesome-streamerrc/blob/master/ThePrimeagen/init.vim
nnoremap <leader>m :MaximizerToggle!<CR>
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>

nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<CR>

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint
