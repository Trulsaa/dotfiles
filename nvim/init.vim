" Source Plugins
source ~/.config/nvim/vimrc/plugins.vim

" Basic settings
language en_us                 " sets the language of the messages / ui (vim)
syntax enable                  " enable syntax highlighting
colorscheme solarized          " solarized colorscheme
set background=dark            " solarized dark
set expandtab                  " to insert space characters whenever the tab key is pressed
set shiftwidth=2               " number of spaces used when indenting
set softtabstop=2              " number of spaces used when indenting usin tab
set fileencodings=utf-8        " set output encoding of the file that is written
set clipboard=unnamedplus      " everything you yank in vim will go to the unnamed register, and vice versa.
set number relativenumber      " each line in your file is numbered relative to the line you’re currently on
set breakindent                " break lines to the indent level
set linebreak                  " brak lines at words
let &showbreak='↳ '                 " DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
set hidden                     " bufferswitching without having to save first.
set splitbelow                 " Creates new splits below
set splitright                 " Creates new splits to the right
set updatetime=250             " Time in milliseconds between saving of the swap-file, also uppdates gitgutter
filetype plugin on             " Enable use of filespesiffic settings files
set foldmethod=indent          " Fold on indentations
set foldlevel=99               " The level that is folded when opening files
set diffopt=vertical           " Diff opens side by side
set lazyredraw                        " Don't bother updating screen during macro playback

" Automatically removing all trailing whitespace on save for javascript, html, css and markdown
autocmd FileType javascript,html,css,markdown autocmd BufWritePre <buffer> %s/\s\+$//e

" Autosave on focus change or buffer change (terminus plugin takes care of reload)
autocmd BufLeave,FocusLost * silent! wall
set shortmess+=A " don't give the ATTENTION message when an existing swap file is found.

" Open files with cursor at last known position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif 

" Matching parentheses settings
hi MatchParen cterm=underline ctermbg=none " Underline matching bracket and remove background color

" Start git commit editing in insert mode
au FileType gitcommit startinsert

" THEME SETTINGS
" SingColumn color and LineNr cleared
highlight clear LineNr

" SOURCES
source ~/.config/nvim/vimrc/hiddenfiles.vim
source ~/.config/nvim/vimrc/keymappings.vim
source ~/.config/nvim/vimrc/deopletesettings.vim
source ~/.config/nvim/vimrc/pluginsettings.vim
source ~/.config/nvim/vimrc/goyosettings.vim
source ~/.config/nvim/vimrc/fzfsettings.vim
