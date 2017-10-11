" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()

Plug 'christoomey/vim-sort-motion'                     " Sort object
Plug 'jiangmiao/auto-pairs'                            " Insert or delete brackets, parens, quotes in pair.
Plug 'neomake/neomake'                                 " Used to run code linters
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " Filetree
Plug 'tmhedberg/SimpylFold'                            " Fold functions
Plug 'tpope/vim-commentary'                            " Comment objects
Plug 'tpope/vim-repeat'                                " Enable . repeating for more
Plug 'tpope/vim-surround'                              " Surround objects with anything
Plug 'yuttie/comfortable-motion.vim'                   " Physics-based smooth scrolling
Plug 'christoomey/vim-tmux-navigator'                  " Navigate seamlessly between vim and tmux
Plug 'junegunn/goyo.vim'                               " Destraction free writing
Plug 'craigemery/vim-autotag'                          " Autoupdate ctags
Plug 'junegunn/vim-easy-align'                         " Alignment on any character
Plug 'sickill/vim-pasta'                               " Context aware pasting
Plug 'Yggdroot/indentLine'                             " Indent guides
Plug 'wincent/loupe'                                   " More resonable search settings

" ABAP 
Plug 'vim-scripts/ABAP.vim', { 'for': 'abap' }

" JavaScript
Plug 'jelera/vim-javascript-syntax', { 'for': ['javascript', 'javascript.jsx'] }                          " Enhanced JavaScript Syntax for Vim
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }                " JavaScript highlighting
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }                               " JavaScript highlighting
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern', 'for': ['javascript', 'javascript.jsx'] } " The autocomplete dropdown
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }                                       " JavaScript Parameter Complete

" CSS
Plug 'ap/vim-css-color', { 'for': 'css' } "color colornames and codes

" Markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' } " Markdown extras

" textobjects
Plug 'kana/vim-textobj-entire' " Creates an object of the entire buffer
Plug 'kana/vim-textobj-indent' " Creates an object of the current indent level
Plug 'kana/vim-textobj-line'   " Craetes the line object to exclude whitespace before the line start
Plug 'kana/vim-textobj-user'   " Enables the creation of new objects

" Autocomplete plugins
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern', 'for': ['javascript', 'javascript.jsx'] } " The autocomplete dropdown
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }                                                       " Tern server
Plug 'SirVer/ultisnips'                                                                                   " Snippet engine
Plug 'honza/vim-snippets'                                                                                 " Snippet library
Plug 'wokalski/autocomplete-flow'                                                                         " More autocomplete options
Plug 'fszymanski/deoplete-emoji'                                                                          " Completion of emoji codes
Plug 'wellle/tmux-complete.vim'                                                                           " Completion of words in adjacent tmux panes
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }                                             " Load last because of :UpdateReomotePlugins

" Fuzzy filesearch
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" theme and statusline
Plug 'altercation/vim-colors-solarized' " Solarized theme for vim
Plug 'vim-airline/vim-airline'          " Status line configuration
Plug 'vim-airline/vim-airline-themes'   " Status line themes
Plug 'edkolev/tmuxline.vim'             " Makes tmux status line match vim status line

" Git plugins
Plug 'airblade/vim-gitgutter' " Shows changed lines compared to last git commit
Plug 'tpope/vim-fugitive'     " Git wrapper

call plug#end()
