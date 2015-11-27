setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal smarttab
setlocal expandtab

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_flake8_args='--ignore=F403,E713,E711'

nmap <leader>, :g/# DEBUG PRINT/d<CR>
nmap <leader>e :call Flake8()<CR>
