"""""""""""""""""
" MARKDOWN STUFF
"""""""""""""""""

" Markdown Preview Stuff
" For regular markdown files
map <C-s> <Plug>MarkdownPreview
let g:mkdp_preview_options = {
            \ 'katex': {
                \ 	'macros': {
                    \ 		"\\vb": "\\overrightarrow",
                    \ 		"\\ev": "\\mathbf",
                    \ 		"\\cross": "\\times"
                    \ 	}
                    \ },
                    \ }

