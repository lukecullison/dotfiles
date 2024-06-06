" Basic settings
syntax enable
set background=dark

" Tab settings
set expandtab        " Use spaces instead of tabs
set shiftwidth=4     " Size of an indent
set tabstop=4        " Number of spaces tabs count for
set softtabstop=4    " Number of spaces tabs count for while editing

" Search settings
set ignorecase       " Case insensitive searching
set smartcase        " Case sensitive if search contains uppercase

" Enable line numbers
set number

" Use jj instead of Esc
inoremap jj <Esc>

" Clipboard to copy out of Vim
set clipboard=unnamedplus

" Enable reStructuredText formatting settings
let g:rst_style = 1

" Enable dynamic 'formatexpr' for R and reStructuredText
let g:rrst_dynamic_comments = 1

" Optionally, you can add specific settings for reStructuredText files
augroup rst
  autocmd!
  autocmd FileType rst setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
augroup END

" Highlight the current line number
augroup LineNumberHighlight
  autocmd!
  autocmd WinEnter,BufEnter * setlocal cursorline
  autocmd WinLeave,BufLeave * setlocal nocursorline
  highlight CursorLineNr ctermfg=Yellow guifg=Yellow
augroup END

" Navigate Vim panes better
nnoremap <c-k> :wincmd k<CR>
nnoremap <c-j> :wincmd j<CR>
nnoremap <c-h> :wincmd h<CR>
nnoremap <c-l> :wincmd l<CR>

" Set space as the leader key
let mapleader = ' '

" Enable persistent undo
set undofile
set undodir=~/.vim/undo

" Keybinding to toggle the undo tree
nnoremap <leader>u :UndotreeToggle<CR>

" Install plugins using vim-plug
call plug#begin('~/.vim/plugged')

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'dracula/vim'
Plug 'arcticicestudio/nord-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'mhartington/oceanic-next'
Plug 'sainnhe/everforest'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'sickill/vim-monokai'
Plug 'kaicataldo/material.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'haishanh/night-owl.vim'
Plug 'folke/tokyonight.nvim'

" Popular dark colorschemes for Vim
Plug 'joshdick/onedark.vim'
Plug 'NLKNguyen/papercolor-theme'

" Other useful plugins
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" Set up fzf.vim keybindings
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fh :History<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fl :Lines<CR>

" Colorscheme setup
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'medium'
let g:gruvbox_invert_selection = '0'
colorscheme gruvbox " Set your default colorscheme here
