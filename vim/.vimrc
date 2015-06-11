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
Plug 'kien/ctrlp.vim'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'farseer90718/vim-taskwarrior'
Plug 'nvie/vim-flake8'
Plug 'nono/vim-handlebars'


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

" Move on wrapped lines
vnoremap <silent> j gj
vnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> k gk


" Backspace
imap <BS> <C-W>
imap <C-BS> <C-W>


let mapleader = " "	" set <Leader> to space
nmap <Leader>n ;NERDTreeToggle<CR>	" NERDTree <space>n in normal mode.
nmap <Leader>b ;TagbarToggle<CR>
nmap <Leader>p ;CtrlP<CR>
map <F12> ;noh<CR>
map <F7> ;Gstatus<CR>
map <F8> ;Gdiff<CR>
map <F9> ;Gpull<CR>
map <F10> ;Gpush<CR>
map <F11> ;Gissues<CR>


nmap <leader>sd ;source $VIMRC<CR>
nmap <leader>i ;vsplit <CR> ;term <CR>

" Tab management
nmap <F4> ;tabnew<CR>
nmap <F1> 1gt
nmap <F2> 2gt
nmap <F3> 3gt
nmap <Leader>u ;UndotreeToggle<CR>;UndotreeFocus<CR>
" Easier movement between windows
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

set splitbelow
set splitright
" Window close and rotate
map <leader>wc ;wincmd q<CR>
map <leader>wr <C-W>r

" Resize windows
nmap <C-Left> ;3wincmd <<CR>
nmap <C-Right> ;3wincmd ><CR>
nmap <C-Up> ;3wincmd +<CR>
nmap <C-Down> ;3wincmd -<CR>
map <leader>h ;wincmd H<CR>
map <leader>k ;wincmd K<CR>
map <leader>l ;wincmd L<CR>
map <leader>j ;wincmd J<CR>


"Spelling
autocmd FileType gitcommit setlocal spell
autocmd FileType md setlocal spell
autocmd BufNewFile,BufReadPost *.tmp setlocal spell

nmap <left> [s " Previous wrong word
nmap <right> ]s " Next wrong word
nmap <up> 1z= " Change to first correction
nmap <down> z= " Show corrections

" Taskwarrior
"noremap <leader>z ;TW<CR>

" Omnifunc
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
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

nmap <leader>v ;UltiSnipsEdit<CR>GG

" Typing
au BufRead,BufNewFile *.txt,*.tex set wrap linebreak nolist textwidth=0 wrapmargin=0

" Open links in vim
nmap <leader>o ;call HandleURL()<CR>
function! HandleURL()
let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
echo s:uri
if s:uri != ""
  silent exec "!firefox '".s:uri."'"
else
  echo "No URI found in line."
endif
endfunction
map <leader>o ;call HandleURL()<cr>


""" Keymappings ( http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_%28Part_1%29 )
nnoremap : ; " Onepress for :
nnoremap ; :

vnoremap : ; " Onepress for :
vnoremap ; :
