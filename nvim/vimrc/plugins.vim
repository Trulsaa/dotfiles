" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup install_plug
    autocmd!
    autocmd VimEnter * PlugInstall
  augroup END
endif

call plug#begin()

Plug 'christoomey/vim-sort-motion'             " Sort object
Plug 'jiangmiao/auto-pairs'                    " Insert or delete brackets, parens, quotes in pair.
Plug 'neomake/neomake'                         " Used to run code linters
Plug 'scrooloose/nerdtree',                    " Filetree
      \ { 'on': 'NERDTreeToggle' }
Plug 'tmhedberg/SimpylFold'                    " Fold functions
Plug 'tpope/vim-commentary'                    " Comment objects
Plug 'tpope/vim-repeat'                        " Enable . repeating for more
Plug 'tpope/vim-surround'                      " Surround objects with anything
Plug 'yuttie/comfortable-motion.vim'           " Physics-based smooth scrolling
Plug 'christoomey/vim-tmux-navigator'          " Navigate seamlessly between vim and tmux
Plug 'junegunn/goyo.vim'                       " Destraction free writing
Plug 'craigemery/vim-autotag'                  " Autoupdate ctags
Plug 'junegunn/vim-easy-align'                 " Alignment on any character
Plug 'sickill/vim-pasta'                       " Context aware pasting
Plug 'Yggdroot/indentLine'                     " Indent guides
Plug 'wincent/loupe'                           " More resonable search settings
Plug 'mattn/gist-vim'                          " Create gist
Plug 'mattn/webapi-vim'                        " Interface to WEB APIs
Plug 'wincent/terminus'                        " Cursor shape change in insert and replace mode
                                               " Improved mouse support
                                               " Focus reporting (Reload buffer on focus if it has been changed externally )
                                               " Bracketed Paste mode
Plug 'junegunn/vim-peekaboo'                   " See the contents of the registers
Plug 'junegunn/limelight.vim'                  " Syntax highlighting only for focused paragraph
Plug 'vim-scripts/vim-auto-save'               " Enables auto save
Plug 'ntpeters/vim-better-whitespace'          " Highlight trailing whitespace in red
Plug 'mklabs/grunt.vim'                        " Grunt wrapper
Plug 'editorconfig/editorconfig-vim'           " Makes use of editorconfig files
Plug 'tpope/vim-eunuch'                        " UNIX shell commands for vim
Plug 'tpope/vim-projectionist'                 " Projection and alternate navigation
Plug 'tpope/vim-obsession'                     " Auto restore vim sessions

                                               " ABAP
Plug 'vim-scripts/ABAP.vim',                   " ABAP highlighting
      \ { 'for': 'abap' }

                                               " JAVASCRIPT
Plug 'metakirby5/codi.vim',                    " Inline evaluation of javascript
      \ { 'for': ['javascript', 'javascript.jsx'] }
Plug 'jelera/vim-javascript-syntax',           " Enhanced JavaScript Syntax for Vim
      \ { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/javascript-libraries-syntax.vim', " JavaScript highlighting
      \ { 'for': ['javascript', 'javascript.jsx'] }
Plug 'pangloss/vim-javascript',                " JavaScript highlighting
      \ { 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs',               " The autocomplete dropdown
      \ { 'do': 'npm install -g tern',
      \ 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim',                        " JavaScript Parameter Complete
      \ { 'for': ['javascript', 'javascript.jsx'] }
Plug 'heavenshell/vim-jsdoc'                   " JsDoc helper
      \ { 'for': ['javascript', 'javascript.jsx'] }

                                               " CSS
Plug 'ap/vim-css-color',                       " color colornames and codes
      \ { 'for': 'css' }

                                               " MARKDOWN
Plug 'plasticboy/vim-markdown',                " Markdown extras
      \ { 'for': 'markdown' }

                                               " VIM
Plug 'Shougo/neco-vim',                        " Completions for Vim commands
      \ { 'for': 'vim' }

                                               " TEXTOBJECTS
Plug 'kana/vim-textobj-entire'                 " Creates an object of the entire buffer
Plug 'kana/vim-textobj-indent'                 " Creates an object of the current indent level
Plug 'kana/vim-textobj-line'                   " Creates the line object to exclude whitespace before the line start
Plug 'kana/vim-textobj-user'                   " Enables the creation of new objects

                                               " AUTOCOMPLETE
Plug 'ternjs/tern_for_vim',                    " Tern server
      \ { 'do': 'npm install',
      \ 'for': ['javascript', 'javascript.jsx'] }
Plug 'SirVer/ultisnips'                        " Snippet engine
Plug 'honza/vim-snippets'                      " Snippet library
Plug 'fszymanski/deoplete-emoji'               " Completion of emoji codes
Plug 'wellle/tmux-complete.vim'                " Completion of words in adjacent tmux panes
" Plug 'thalesmello/webcomplete.vim'             " Completes words from the currently open web page
Plug 'Shougo/deoplete.nvim',                   " Autocomplete engine
      \ { 'do': ':UpdateRemotePlugins' }       " Load last because of :UpdateReomotePlugins

                                               " FUZZY FILESEARCH
Plug 'junegunn/fzf',
      \ { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

                                               " THEME AND STATUSLINE
Plug 'altercation/vim-colors-solarized'        " Solarized theme for vim
Plug 'vim-airline/vim-airline'                 " Status line configuration
Plug 'vim-airline/vim-airline-themes'          " Status line themes
Plug 'edkolev/tmuxline.vim'                    " Makes tmux status line match vim status line

                                               " GIT PLUGINS
Plug 'airblade/vim-gitgutter'                  " Shows changed lines compared to last git commit
Plug 'tpope/vim-fugitive'                      " Git wrapper
Plug 'shumphrey/fugitive-gitlab.vim'           " GitLab fugitive handler
Plug 'tpope/vim-rhubarb'                       " Github fugitive handler

                                               " MY PLUGGINS
Plug 'https://innersource.soprasteria.com/NO-Applications-SAP/deoplete-sap-icon.git'

call plug#end()
