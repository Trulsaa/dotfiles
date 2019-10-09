" Source Plugins
scriptencoding utf-8
source ~/.config/nvim/vimrc/plugins.vim

" Basic settings
syntax enable             " enable syntax highlighting
colorscheme solarized     " solarized colorscheme
set background=dark       " solarized dark
set termguicolors
set expandtab             " to insert space characters whenever the tab key is pressed
set shiftwidth=2          " number of spaces used when indenting
set softtabstop=4         " number of spaces used when indenting using tab
set tabstop=4             " Number of spaces that a <Tab> in the file counts for
set fileencodings=utf-8   " set output encoding of the file that is written
set clipboard=unnamedplus " everything you yank in vim will go to the unnamed register, and vice versa.
set number relativenumber " each line in your file is numbered relative to the line you’re currently on
set breakindent           " brake lines to the indent level
set linebreak             " brake lines at words
set hidden                " bufferswitching without having to save first.
set splitbelow            " Creates new splits below
set splitright            " Creates new splits to the right
set updatetime=250        " Time in milliseconds between saving of the swap-file, also uppdates gitgutter
filetype plugin on        " Enable use of filespesiffic settings files
set foldmethod=indent     " Fold on indentations
set foldlevel=99          " The level that is folded when opening files
set diffopt=vertical      " Diff opens side by side
set lazyredraw            " Don't bother updating screen during macro playback
set scrolloff=3           " Start scrolling 3 lines before edge of window
set cursorline            " Highlights the line the cursor is on
set shortmess+=A          " don't give the ATTENTION message when an existing swap file is found.
set inccommand=split      " enables live preview of substitutions

augroup general_autocmd

  " Autosave on focus change or buffer change (terminus plugin takes care of reload)
  autocmd BufLeave,FocusLost * silent! wall

  " Open files with cursor at last known position
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

  " Start git commit editing in insert mode
  autocmd FileType gitcommit startinsert

augroup END

" Underline matching bracket and remove background color
hi MatchParen cterm=underline ctermbg=none

" THEME SETTINGS
" SingColumn color and LineNr cleared
highlight clear LineNr
" set color for the terminal cursor in terminal mode
hi! TermCursorNC ctermfg=15 guifg=#fdf6e3 ctermbg=14 guibg=#93a1a1 cterm=NONE gui=NONE

" SOURCES
source ~/.config/nvim/vimrc/hiddenfiles.vim
source ~/.config/nvim/vimrc/keymappings.vim
source ~/.config/nvim/vimrc/deopletesettings.vim
source ~/.config/nvim/vimrc/pluginsettings.vim
source ~/.config/nvim/vimrc/qlnetrw.vim
source ~/.config/nvim/vimrc/fzfsettings.vim
