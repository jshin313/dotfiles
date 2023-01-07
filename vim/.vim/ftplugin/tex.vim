"""""""""""""""""
" LATEX
"""""""""""""""""
set wrap

let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

let g:fasttex = 1

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
	let g:vimtex_view_method = 'mupdf'
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

