" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off
set statusline+=%#warningmsg#
set statusline+=%*


" TODO: Load plugins here (pathogen or vundle)

call plug#begin('~/.vim/plugged')
" " let Vundle manage Vundle, required
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'preservim/nerdtree'
  Plug 'dense-analysis/ale'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'morhetz/gruvbox'
  Plug 'voldikss/vim-floaterm'
call plug#end()
syntax on


" For plugins to load correctly
filetype plugin indent on

" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

let g:ale_open_list = 1
let g:ale_cpp_cc_executable = 'g++-13 '
let g:cpp_opts = '-std=c++17 -Wall -Wextra -fopenmp'
let g:ale_linters = { 'cpp': ['gcc'] }
let g:ale_cpp_cc_options    = cpp_opts
let g:ale_cpp_gcc_options   = cpp_opts
let g:ale_cpp_clang_options = cpp_opts

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

autocmd filetype markdown syn region match start=/\\$\\$/ end=/\\$\\$/ 
autocmd filetype markdown syn match math '\\$[^$].\{-}\$'

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" escape
inoremap jj <esc>

nnoremap <F4> <C-\><C-n>:FloatermToggle <CR>
inoremap <F4> <C-\><C-n>:FloatermToggle <CR>
tnoremap <F4> <C-\><C-n>:FloatermToggle <CR>
" tab movement 
nnoremap <F7> :tabp<CR>
nnoremap <F8> :tabn<CR>

" folding
set foldmethod=syntax
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" nerdtree
nnoremap <C-o> :NERDTreeToggle<CR>

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
set t_Co=256
set background=dark
colorscheme gruvbox 

au BufRead,BufNewFile *.g set filetype=antlr3
au BufRead,BufNewFile *.g4 set filetype=antlr4
