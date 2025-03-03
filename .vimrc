scriptencoding utf-8
" ^^ Please leave the above line at the start of the file.

" This file is mostly based on Gentoo's /etc/vim/vimrc and ArchLinux's
" /usr/share/vim/vimfiles/archlinux.vim files, with other slight customizations.
" https://github.com/tpope/vim-sensible contains some commons vim configuration.
" http://vimawesome.com/ provides a list of vim plugins but none is used here.
" http://www.tuppervim.org/ (French) lists some tips and Github projects.
" http://dougblack.io/words/a-good-vimrc.html an explained vimrc configuration.

" General settings
set nocompatible " Use Vim defaults instead of 100% vi compatibility
set backspace=2 " Allow backspacing over everything in insert mode (same as indent,eol,start)
set autoindent " Always set auto-indenting on
set copyindent " Copy the structure of existing lines when indenting a new line
set autoread " Reload file when modified outside of vim
set history=500 " keep 500 lines of command history
set ruler " Show the cursor position all the time
set rulerformat=%=%h%m%r%w\ %(%c%V%),%l/%L\ %P
let mapleader="," " Use comma as the leader key
filetype plugin indent on

set viminfo='20,\"500 " Keep a .viminfo file.
set incsearch " To move the search while typing
set laststatus=1 " Show a status line on the last window when there are at least 2 windows
set cmdheight=2
set showfulltag " View full tag when doing a tag search
set nrformats-=octal " Don't use octal number when incrementing/decrementing with ^A/^X
set scrolloff=1 " Always show at least one line above and below the cursor
set sidescrolloff=5 " Always show at least 5 columns at cursor sides in nowrap mode
set display+=lastline " Display part of the lastline in the window instead of @ lines
set ffs=unix,dos,mac " Use <NL>-terminated lines by default, then <CR><NL> and finally <CR>

" Theme
colorscheme default
set background=dark

" UI configuration
if has('mouse')
  set mouse=a " Enable mouse
endif
set nonumber " Don't show line numbers
set showmode " Show the current mode on the last line
set showcmd " Show the number of characters or lines in Visual mode

" Indentation configuration
set expandtab " Always use space, no tabs

" Force noexpandtab on specific file types
autocmd FileType make,makefile setlocal noexpandtab
set shiftwidth=4
set softtabstop=4
" Disable folding by default
set nofoldenable
" Enable folding based on indentation
set foldmethod=indent
set nofoldenable

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=~,.aux,.bak,.bbl,.brf,.blg,.cb,.dvi,.idx,.ilg,.info,.log,.lo,.o,.out,.swp,.out,.toc
set suffixes=~,.aux,.bak,.bbl,.brf,.blg,.cb,.dvi,.idx,.ilg,.info,.log,.lo,.o,.out,.swp,.toc
" Configure completion
set wildmenu
set wildmode=longest:full,full
set wildignore+=*~,*.bak,*.o,*.pyc,*.pyo,*.swo,*.swp
set wildignore+=*.dll,*.exe,*.so,*.swf,*.zip,*.tar
set wildignore+=*/.git/*,*/.hq/*,*/.svn/*
set wildignorecase

if has('gui_running')
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

" Don't eval modelines by default. See Gentoo bugs #14088 and #73715.
set modelines=0
set nomodeline

" When displaying line numbers, don't use an annoyingly wide number column. This
" doesn't enable line numbers -- :set number will do that. The value given is a
" When displaying line numbers, don't use an annoyingly wide number column. This
" doesn't enable line numbers -- :set number will do that. The value given is a
" minimum width to use for the number column, not a fixed size.
set numberwidth=3
if &fileencodings !~? "utf-8"
  " If we have to add this, the default encoding is not Unicode.
  " We use this fact later to revert to the default encoding in plaintext/empty
  " files.
  let g:added_fenc_utf8 = 1
  set fileencodings+=utf-8
endif

" Make sure we have a sane fallback for encoding detection
if &fileencodings !~? "default"
  set fileencodings+=default
endif

" Enable :Man command and remap K (already used to run "man")
source $VIMRUNTIME/ftplugin/man.vim
nmap K :Man <cword><CR>

" Autocommand group from Gentoo's /etc/vim/vimrc
if has("autocmd")
augroup usercommands
  " Clean up all previously loaded commands
  autocmd!

  " If we previously detected that the default encoding is not UTF-8
  " (g:added_fenc_utf8), assume that a file with only ASCII characters (or no
  " characters at all) isn't a Unicode file, but is in the default encoding.
  " Except of course if a byte-order mark is in effect.
  autocmd BufReadPost *
        \ if exists("g:added_fenc_utf8") && &fileencoding == "utf-8" &&
        \    ! &bomb && search('[\x80-\xFF]','nw') == 0 && &modifiable |
        \       set fileencoding= |
        \ endif

  " Force noet on some files
  autocmd BufRead */Makefile* set noexpandtab
  autocmd BufRead *.mk set noexpandtab
  autocmd BufRead *.fc set noexpandtab shiftwidth=8 softtabstop=8 tabstop=8
  autocmd BufRead *.if set noexpandtab shiftwidth=8 softtabstop=8 tabstop=8
  autocmd BufRead *.te set noexpandtab shiftwidth=8 softtabstop=8 tabstop=8

  " Wrap long git commit messages
  autocmd FileType gitcommit set textwidth=72
augroup END

" Transparent editing of gpg encrypted files.
" http://vim.wikia.com/wiki/Edit_gpg_encrypted_files
augroup encrypted
  autocmd!
  " Make sure nothing is written to ~/.viminfo while editing an encrypted file
  autocmd BufReadPre,FileReadPre *.gpg set viminfo=
  " Disable swap files, and set binary file format before reading the file
  autocmd BufReadPre,FileReadPre *.gpg setlocal noswapfile bin
  " Decrypt the contents after reading the file, reset binary file format
  " and run any BufReadPost autocmds matching the file name without the .gpg
  " extension
  autocmd BufReadPost,FileReadPost *.gpg
    \ execute "'[,']!gpg --decrypt --default-recipient-self 2> /dev/null" |
    \ setlocal nobin |
    \ execute "doautocmd BufReadPost " . expand("%:r")

  " Set binary file format and encrypt the contents before writing the file
  autocmd BufWritePre,FileWritePre *.gpg
    \ setlocal bin |
    \ '[,']!gpg --encrypt --default-recipient-self 2> /dev/null
  " After writing the file, do an :undo to revert the encryption in the
  " buffer, and reset binary file format
  autocmd BufWritePost,FileWritePost *.gpg
    \ silent undo |
    \ setlocal nobin
augroup END
endif

" Don't save backups of *.gpg files
set backupskip+=*.gpg

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  filetype on

  " Show matching brackets
  set showmatch

  " Toggle show column 80 in color with Leader+c, 120 with Leader+C
  nnoremap <LEADER>c :let &colorcolumn=(&colorcolumn == 80 ? 0 : 80)<CR>
  nnoremap <LEADER>C :let &colorcolumn=(&colorcolumn == 120 ? 0 : 120)<CR>

  " Highlight extra whitespaces
  highlight ExtraWhitespace ctermbg=red guibg=red
  let g:m_extra_whitespace = matchadd('ExtraWhitespace', '\s\+$')
endif

" Spell correction with vim7 (http://www.cs.swarthmore.edu/help/vim/vim7.html)
if has("spell")
  " toggle spelling with F4 key
  map <F4> :set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>
  " they were using white on white
  highlight PmenuSel ctermfg=black ctermbg=lightgray
  " limit it to just the top 10 items
  set sps=best,10
endif

" Remove screen prefix from $TERM as this breaks Ctrl-Left/Right
let &term=substitute(&term, "^screen\.", "", "")

" Terminal fixes
if &term ==? "xterm"
  set t_Sb=^[4%dm
  set t_Sf=^[3%dm
  set ttymouse=xterm2
endif

if &term =~ "alacritty"
  set t_Sb=^[4%dm
  set t_Sf=^[3%dm
  set ttymouse=sgr
endif

if &term ==? "gnome" && has("eval")
  " Set useful keys that vim doesn't discover via termcap but are in the
  " builtin xterm termcap. See Gentoo bug #122562. We use exec to avoid having
  " to include raw escapes in the file.
  exec "set <C-Left>=\eO5D"
  exec "set <C-Right>=\eO5C"
endif

" Fix &shell, see Gentoo bug #101665.
if "" == &shell
  if executable("/bin/bash")
    set shell=/bin/bash
  elseif executable("/bin/sh")
    set shell=/bin/sh
  endif
endif

" Default /bin/sh is bash, not ksh, so syntax highlighting for .sh files should
" default to bash. See :help sh-syntax and Gentoo bug #101819.
if has("eval")
  let is_bash=1
endif

" Don't beep
"set visualbell
"set noerrorbells

" map keys to tabs
nmap <C-t> :tabnew<CR>
imap <C-t> <ESC>:tabnew<CR>i
map <C-t> :tabnew<CR>:E<CR>
nnoremap <LEADER>nt :tabnew<CR>
nnoremap <LEADER>h :tabprevious<CR>
nnoremap <LEADER>l :tabnext<CR>

" Speed up wheel scrolling
map <ScrollWheelUp>   10<C-u>
map <ScrollWheelDown> 10<C-d>

" Clear search with comma + space
nnoremap <LEADER><SPACE> :nohlsearch<CR>

" Fold/unfold code with space
" nnoremap <SPACE> za
" vnoremap <SPACE> zf

" Escape when inserting "jk"
inoremap jk <ESC>

" Save with sudo
command! -nargs=1 Wroot :w !sudo tee <args> > /dev/null

" vim: set fenc=utf-8 tw=80 sw=2 sts=2 et foldmethod=marker :