" Add powerline font: https://github.com/powerline/fonts
set nocompatible
filetype off

" Vudle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" Plugins
Plugin 'gmarik/Vundle.vim' 		    " maintains plugins
Plugin 'sCRooloose/nerdtree'		" file browser
Plugin 'Lokaltog/vim-easymotion'	" fuzzy motion (<Leader><Leader>w)
Plugin 'kien/ctrlp.vim'			    " fuzzy file opener
Plugin 'fatih/vim-go'
Plugin 'sjl/gundo.vim'
Plugin 'Shougo/neocomplcache'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'sCRooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'bling/vim-airline'
Plugin 'Shougo/vimshell.vim'
Plugin 'codeape2/vim-multiple-monitors'
Plugin 'pangloss/vim-javascript'
Plugin 'lervag/vim-latex'
Plugin 'tpope/vim-markdown'
Plugin 'jaxbot/github-issues.vim'
" https://github.com/greyblake/vim-preview
Plugin 'klen/python-mode'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'mxw/vim-jsx'

let g:PreviewBrowsers='google-chrome-beta'

call vundle#end()
" General
syntax on
set number
set tabstop=2       	" number of visual spaces per TAB
set softtabstop=2   	" number of spaces in tab when editing
set expandtab       	" tabs are spaces
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase
set smartcase
set background=dark
set autoindent
set shiftwidth=4
set undofile
set undodir=~/.vimundo " make ~/.vimundo to store undo history
set nowritebackup
colorscheme solarized
filetype indent on

" javascript



" move vertically by visual line
nnoremap j gj
nnoremap k gk

" Keymappings ( http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_%28Part_1%29 )
let mapleader = " "			" set <Leader> to space
nmap <Leader>n :NERDTreeToggle<CR>	" NERDTree <space>n in normal mode.
let g:ctrlp_map = '<Leader>p'
nmap <Leader>b  :TagbarToggle<CR>
map <F12> :noh<CR>
map <F7> :Gstatus<CR>
map <F8> :Gdiff<CR>
map <F9> :Gpull<CR>
map <F10> :Gpush<CR>
map <F11> :Gissues<CR>

" Tab management
nnoremap <F6> :tabnew<CR>
nnoremap <F1> 1gt
nnoremap <F2> 2gt
nnoremap <F3> 3gt
nnoremap <F4> 4gt
nnoremap <F5> 5gt

nnoremap <leader>u :GundoToggle<CR>

" Easier movement between windows
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

set splitbelow
set splitright
" Window close and rotate
map <leader>wc :wincmd q<CR>
map <leader>wr <C-W>r

" Resize windows
nmap <C-Left>  :3wincmd <<CR>
nmap <C-Right> :3wincmd ><CR>
nmap <C-Up>    :3wincmd +<CR>
nmap <C-Down>  :3wincmd -<CR>

map <leader>h :wincmd H<CR>
map <leader>k :wincmd K<CR>
map <leader>l :wincmd L<CR>
map <leader>j :wincmd J<CR>

" NERDTree
" - Open NERDTree automaticly when no file specified.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeQuitOnOpen=1

" VIM-GO
au FileType go source ~/.vim/bundle/vim-go/ftplugin/go/commands.vim
au FileType go source ~/.vim/bundle/vim-go/ftplugin/go/tagbar.vim

au FileType go nmap <Leader>I <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>d <Plug>(go-doc)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>B <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
let g:play_browser_command = 'google-chrome-beta'

" Neocomplete
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javasCRipt setlocal omnifunc=javasCRiptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" TAB to go down, and S-TAB to go up neocomplete
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" Add golang snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-go/gosnippets/snippets'

" Airline status-line
let g:airline_powerline_fonts=0
let g:airline_detect_paste=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='base16'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#enabled = 0

" Typing
au BufRead,BufNewFile *.txt,*.tex set wrap linebreak nolist textwidth=100 wrapmargin=10

" Latex
let g:latex_indent_enabled = 1
au FileType tex nmap <Leader>r :w <CR> :!pdflatex -synctex=1 --shell-escape  -interaction=nonstopmode % <CR>

"Spelling
autocmd FileType gitcommit setlocal spell
autocmd FileType tex setlocal spell
autocmd FileType md setlocal spell
autocmd BufNewFile,BufReadPost *.tmp setlocal spell

" Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

nmap <left>  [s
nmap <right> ]s
nmap <up>    1z=
nmap <down>  z=


" EasyMotion
nnoremap <Leader>i <Plug>(easymotion-w)

" Python
let g:pymode_folding = 0
let g:pep8_ignore="F403,E713,E266"
au FileType python nnoremap <leader>t :!nosetests %:p<CR>


" gVIM stuff
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
