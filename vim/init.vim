" Plugins
call plug#begin()

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'SirVer/ultisnips'
Plug 'mbbill/undotree'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'nvie/vim-flake8'
Plug 'nono/vim-handlebars'
Plug 'scrooloose/syntastic'
Plug 'ternjs/tern_for_vim'


call plug#end()

" General
syntax on
set number
set tabstop=2 " number of visual spaces per TAB
set softtabstop=2 " number of spaces in tab when editing
set expandtab " tabs are spaces
set showmatch " highlight matching [{()}]
set incsearch " search as characters are entered
set hlsearch " highlight matches
set ignorecase
set smartcase
set background=dark
set autoindent
set shiftwidth=2
set undofile
set undodir=~/.vimundo " make ~/.vimundo to store undo history
set nowritebackup

colorscheme solarized
filetype indent on
noremap <Esc> <c-\><c-n>

" Nerdtree
let NERDTreeQuitOnOpen=1 " Close NERDTree on opening file
let NERDTreeIgnore = ['\.pyc$', '\.swp$']
let NERDTreeshowlinenumbers=1

" Move on wrapped lines
vnoremap <silent> j gj
vnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> k gk


" Backspace
imap <BS> <C-W>
imap <C-BS> <C-W>


let mapleader = " "
nmap <leader>n :NERDTreeToggle<CR>
noremap <F12> :noh<CR>
nnoremap <F7> :Gstatus<CR>
nnoremap <F8> :Gdiff<CR>
nnoremap <F9> :Gpull<CR>
nnoremap <F10> :Gpush<CR>
nnoremap <F11> :Gissues<CR>


nmap <leader>sd :source $VIMRC<CR>
nmap <leader>i :vsplit<CR>:terminal<CR>

" Terminal
tnoremap <Esc> <C-\><C-n>

" Tab management
nnoremap <F5> :tabnew<CR>
nnoremap <F1> 1gt
nnoremap <F2> 2gt
nnoremap <F3> 3gt
nnoremap <F4> 4gt
nmap <Leader>u :UndotreeToggle<CR>:UndotreeFocus<CR>
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
map <M-h> :3wincmd<<CR>
map <M-l> :3wincmd><CR>
map <M-j> :3wincmd+<CR>
map <M-k> :3wincmd-<CR>
map <leader>h :wincmd H<CR>
map <leader>k :wincmd K<CR>
map <leader>l :wincmd L<CR>
map <leader>j :wincmd J<CR>

"Spelling
autocmd FileType gitcommit setlocal spell
autocmd FileType md setlocal spell
autocmd BufNewFile,BufReadPost *.tmp setlocal spell

"nmap <left> [s " Previous wrong word
"nmap <right> ]s " Next wrong word
"nmap <up> 1z= " Change to first correction
"nmap <down> z= " Show corrections


" Omnifunc
autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType java set omnifunc=javacomplete#Complete

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-j>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsListSnippets = "<c-tab>"

nmap <leader>v :UltiSnipsEdit<CR>GG

" Typing
au BufRead,BufNewFile *.txt,*.tex set wrap linebreak nolist textwidth=0 wrapmargin=0

" Open links in vim
nmap <leader>o :call HandleURL()<CR>
function! HandleURL()
let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
echo s:uri
if s:uri != ""
  silent exec "!firefox '".s:uri."'"
else
  echo "No URI found in line."
endif
endfunction
map <leader>o :call HandleURL()<cr>
