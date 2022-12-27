" Using Lua functions
nnoremap <leader>pf <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <C-p> <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>ps <cmd>lua require('telescope.builtin').live_grep()<cr>

