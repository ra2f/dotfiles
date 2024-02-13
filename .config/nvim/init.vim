" We want the latest vim settings/options, it must be first because it changes other options as a side effect
set nocompatible

" moving to vim-plug
" Vim plug settings ------------------- {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" --------------------------------------------------------------
"              - Basic parameters -
" --------------------------------------------------------------

:set number            " Show line number

:set autoindent        " New lines inherit the indentation of previous lines.

:set tabstop=4         " Visual tab with 4 space width
:set softtabstop=4     " Show tab with 4 space width when added
:set expandtab         " User spaces, not tabs
:set shiftwidth=4      " When shifting, indent using four spaces
:set smarttab          " Insert “tabstop” number of spaces when the “tab” key is pressed

:set mouse=a           " Enable mouse for scrolling and resizing
:set guicursor=        " I prefer big caret in `Insert mode`
:set noerrorbells      " I don't like this sound...
:set scrolloff=8       " Offset buffer scroll

:set encoding=utf-8

:set hidden            " Buffer is not unloaded when you close current buffer

:set noswapfile               " Don't store swap file
:set nobackup                 " Don't store backup file
:set undodir=~/.vim/undo_dir  " Store undo history in this directory
:set undofile                 " Use undo file
:set cursorline               " Highlight line the curson is on
:set copyindent               " Copy original indentation on autoindeting


" --------------------------------------------------------------
"              - Plugins -
" --------------------------------------------------------------

call plug#begin('~/.config/nvim/')

" Gui enchancements
Plug 'itchyny/lightline.vim'                   " Status bar
Plug 'preservim/nerdtree'                      " Nerd tree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Nerd syntax highlight

" Telescope
Plug 'nvim-lua/plenary.nvim'          " Required lib
Plug 'nvim-telescope/telescope.nvim'  " Project finder

" Undo tree
Plug 'mbbill/undotree'

" Commentary
"Plug 'tpope/vim-commentary'

" Shortcuts
Plug 'terryma/vim-multiple-cursors'   " Multiple cursors selection

" TMUX
Plug 'aserowy/tmux.nvim'
Plug 'christoomey/vim-tmux-navigator'

" Code completion
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"let g:coc_global_extensions = [
"  \'coc-git',
"  \'coc-json',
"  \'coc-prettier',
"  \'coc-yank',
"  \'coc-pyright',
"  \'coc-yaml',
"  \'coc-styled-components',
"  \'coc-sh'
"  \]

" Icons
Plug 'ryanoasis/vim-devicons'         " Icons

" Bar
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

call plug#end()                       " *required

" --------------------------------------------------------------
"              - Plugins | NERDTree -
" --------------------------------------------------------------

" Start NERDTree and leave the cursor in it.
autocmd VimEnter * NERDTree | wincmd p

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" --------------------------------------------------------------
"              - Plugins | Telescope -
" --------------------------------------------------------------

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" --------------------------------------------------------------
"              - Plugins | UndoTree -
" --------------------------------------------------------------

nnoremap <F5> :UndotreeToggle<CR>

" --------------------------------------------------------------
"              - Plugins | Tmux -
" --------------------------------------------------------------

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> {Left-Mapping} :TmuxNavigateLeft<cr>
nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" --------------------------------------------------------------
"              - Plugins | vim-multiple-cursors -
" --------------------------------------------------------------
"let g:multi_cursor_use_default_mapping=0

" Default mapping
"let g:multi_cursor_start_word_key      = '<C-n>'
"let g:multi_cursor_select_all_word_key = '<A-n>'
"let g:multi_cursor_start_key           = 'g<C-n>'
"let g:multi_cursor_select_all_key      = 'g<A-n>'
"let g:multi_cursor_next_key            = '<C-n>'
"let g:multi_cursor_prev_key            = '<C-p>'
"let g:multi_cursor_skip_key            = '<C-x>'
"let g:multi_cursor_quit_key            = '<Esc>'

" --------------------------------------------------------------
"              - Plugins | barbar -
" --------------------------------------------------------------
" Move to previous/next
nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A->> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> :BufferGoto 1<CR>
nnoremap <silent>    <A-2> :BufferGoto 2<CR>
nnoremap <silent>    <A-3> :BufferGoto 3<CR>
nnoremap <silent>    <A-4> :BufferGoto 4<CR>
nnoremap <silent>    <A-5> :BufferGoto 5<CR>
nnoremap <silent>    <A-6> :BufferGoto 6<CR>
nnoremap <silent>    <A-7> :BufferGoto 7<CR>
nnoremap <silent>    <A-8> :BufferGoto 8<CR>
nnoremap <silent>    <A-9> :BufferLast<CR>
" Pin/unpin buffer
nnoremap <silent>    <A-p> :BufferPin<CR>
" Close buffer
nnoremap <silent>    <A-c> :BufferClose<CR>
" Wipeout buffer
"                          :BufferWipeout<CR>
" Close commands
"                          :BufferCloseAllButCurrent<CR>
"                          :BufferCloseAllButPinned<CR>
"                          :BufferCloseAllButCurrentOrPinned<CR>
"                          :BufferCloseBuffersLeft<CR>
"                          :BufferCloseBuffersRight<CR>
" Magic buffer-picking mode
nnoremap <silent> <C-s>    :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Space>bb :BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw :BufferOrderByWindowNumber<CR>

" Other:
" :BarbarEnable - enables barbar (enabled by default)
" :BarbarDisable - very bad command, should never be used

" --------------------------------------------------------------
"              - Colors -
" --------------------------------------------------------------
" save: ctrl+s
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" quit without save: ctrl+q
noremap <silent> <C-q>          :q!<CR>
vnoremap <silent> <C-q>         <C-C>:q!<CR>
inoremap <silent> <C-q>         <C-O>:q!<CR>

" save and quit: ctrl+x
noremap <silent> <C-x>          :x<CR>
vnoremap <silent> <C-x>         <C-C>:x<CR>
inoremap <silent> <C-x>         <C-O>:x<CR>

" select all: ctrl+a
noremap <silent> <C-a>          ggVG
vnoremap <silent> <C-a>         <C-[>ggVG<CR>
inoremap <silent> <C-a>         <-C-[>ggVG<CR>

" copy: alt+c
nnoremap <M-c>                  yy
inoremap <M-c>                  <Esc>yygi
vnoremap <M-c>                  ygv

" paste: alt+v
nnoremap <M-v>                  p
inoremap <M-v>                  <Esc>pgi
vnoremap <M-v>                  p

" cut: alt+x
nnoremap <M-x>                  dd
inoremap <M-x>                  <Esc>ddgi
vnoremap <M-x>                  d

noremap <silent> <C-c>          "+p
vnoremap <silent> <C-c>         <C-[>"+p<CR>
inoremap <silent> <C-c>         <C-[>"+p<CR>