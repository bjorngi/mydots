" BibTex
setlocal spell
nnoremap <buffer><leader>r :w<CR>:silent !bibtex %:r > /dev/null &<CR>
