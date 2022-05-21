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

set rtp+=~/school

"Plug, the plugin manager
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox' "Color scheme
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive' "Diffs, logs, git blame
Plug 'vim-airline/vim-airline' "Tells you what branch you're on and which file; recommended by primeagen in https://youtu.be/PO6DxfGPQvw?
"Plug 'ycm-core/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Another autocomplete
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' "File finding
Plug 'mbbill/undotree'
Plug 'tpope/vim-commentary', "Comments!
Plug 'terryma/vim-multiple-cursors' "Multiple Cursors
Plug 'sheerun/vim-polyglot' "Support for a bunch of Languages
Plug 'psliwka/vim-smoothie' "Smooth scrolling
Plug 'lervag/vimtex', {'tag': 'v1.6'} "1.6 to maintain compatbility with tex-conceal since they vimtex decided to break compatbility by adding their own conceal support (largely inferior)
Plug 'vim-pandoc/vim-pandoc' "doesn't work for some reason with markdown
" preview
Plug 'vim-pandoc/vim-pandoc-syntax' 
" Plug 'KeitaNakamura/tex-conceal.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['pandoc', 'markdown', 'vim-plug']}
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

" Magic. Mainly for faster latex typing
Plug 'SirVer/ultisnips', { 'for': ['tex', 'markdown', 'pandoc'] } 
" Plug 'honza/vim-snippets'

" Live preview for latex
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

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

""" Autocomplete Remaps
"nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>
"nnoremap <silent> <Leader>gr :YcmCompleter GoToReferences<CR>

" GoTo code navigation
" Make sure to download clangd for c
" and coc-pyright for python
nmap <silent><leader>gd <Plug>(coc-definition)
nmap <silent><leader>gy <Plug>(coc-type-definition)
nmap <silent><leader>gi <Plug>(coc-implementation)
nmap <silent><leader>gr <Plug>(coc-references)

"
" COC STUFF

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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

" " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

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

" auto install these plugins for coc
let g:coc_global_extensions = [
	\ 'coc-java',
	\ 'coc-java-debug',
    \ 'coc-pyright',
	\]

" For terminal
" Make esc enter normal mode for terminal mode
tnoremap <Esc> <C-\><C-n>

if has('nvim')
    "When in terminal mode remove line numbers
    au TermOpen * setlocal listchars= nonumber norelativenumber
    au TermOpen * startinsert
endif

"""""""""""""""
" GIT FUGITIVE
"""""""""""""""
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>

"""""""""
" LATEX
"""""""""
filetype plugin on
" autocmd Filetype tex setl updatetime=1

"https://medium.com/@Pirmin/a-minimal-latex-setup-on-windows-using-wsl2-and-neovim-51259ff94734
" let g:vimtex_latexmk_options = '-pdf -shell-escape -verbose -file-line-error -synctex=1 -interaction=nonstopmode'
" let g:vimtex_compiler_latexmk = {
" 			\ 'options' : [
" 			\   '-pdf',
" 			\   '-shell-escape',
" 			\   '-verbose',
" 			\   '-file-line-error',
" 			\   '-synctex=1',
" 			\   '-interaction=nonstopmode',
" 			\ ],
" 			\}

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
    " let g:livepreview_previewer = 'zathura'
endif

nnoremap \lc :VimtexStop<cr>:VimtexClean<cr>

" Magic latex https://castel.dev/post/lecture-notes-1/
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0

" Conceal
set conceallevel=1
let g:tex_conceal_frac=1 "TODO: get this actually working
let g:tex_conceal='abdmg'
hi Conceal ctermbg=none
let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
let g:tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" autocorrect
setlocal spell
set spelllang=en_us
" Jump to last spelling error and correct and then jump back to original
" position
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" https://ericchapdelaine.com/articles/how-i-take-notes
nnoremap <C-f> :exec '.!~/.vim/scripts/ink.py %:r "'.getline(".").'"'

" https://github.com/gillescastel/inkscape-figures
autocmd Filetype tex,latex inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
autocmd Filetype tex,latex nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

"""""""""""""""""
" MARKDOWN STUFF
"""""""""""""""""

" Markdown Preview Stuff
" For regular markdown files
let g:mkdp_command_for_global = 1
let g:mkdp_echo_preview_url = 1
let g:mkdp_open_to_the_world = 1
let g:mkdp_preview_options = {
            \ 'katex': {
            \ 	'macros': {
            \ 		"\\vb": "\\overrightarrow",
            \ 		"\\ev": "\\mathbf",
            \ 		"\\cross": "\\times"
            \ 	}
            \ },
            \ }

map <C-s> <Plug>MarkdownPreview


" For beamer presentations
au BufWritePost *.md nmap <leader>b :!pandoc -o %:r.pdf -t beamer % <CR><CR>

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

" For cobol files
autocmd FileType cobol set sw=4 sts=4 et sta tw=72

" Enable auto reload of files
set autoread
au FocusGained,BufEnter * :checktime

" DEBUGGER REMAPS FOR VIMSPECTOR
" Note to self: Make sure to install coc-java and coc-java-debug when debugging java
" Copied from https://github.com/awesome-streamers/awesome-streamerrc/blob/master/ThePrimeagen/init.vim
nnoremap <leader>m :MaximizerToggle!<CR>
autocmd FileType java nnoremap <leader>dd :CocCommand java.debug.vimspector.start<CR>
autocmd FileType c,javascript nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>

nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<CR>

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint

"
" CUSTOM REMAPS
"
" https://vi.stackexchange.com/a/3877
" "_ selects the 'blackhole' buffer and D deletes as expected
nnoremap <Leader>o o<Esc>0"_D
nnoremap <Leader>O O<Esc>0"_D
