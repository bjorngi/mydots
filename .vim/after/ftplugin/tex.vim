" Latex
setlocal spell
" Soft text-wrapping
set wrap linebreak nolist textwidth=0 wrapmargin=0

" Build pdf
nnoremap <buffer><leader>r :w<CR>:silent !pdflatex -synctex=2 --shell-escape  -interaction=nonstopmode % > /dev/null &<CR>
