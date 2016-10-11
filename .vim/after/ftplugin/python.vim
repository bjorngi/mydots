setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal smarttab
setlocal expandtab

set colorcolumn=80
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
nmap <leader>, :g/# DEBUG PRINT/d<CR>
