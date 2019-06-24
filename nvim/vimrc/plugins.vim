" Install Vim Plug if not installed
call plug#begin()

Plug 'christoomey/vim-sort-motion'             " Sort object
Plug 'jiangmiao/auto-pairs'                    " Insert or delete brackets, parens, quotes in pair.
Plug 'w0rp/ale'
Plug 'tpope/vim-vinegar'                       " Add functionality to netrw
Plug 'tmhedberg/SimpylFold'                    " Fold functions
Plug 'tpope/vim-commentary'                    " Comment objects
Plug 'tpope/vim-repeat'                        " Enable . repeating for more
Plug 'tpope/vim-surround'                      " Surround objects with anything
Plug 'yuttie/comfortable-motion.vim'           " Physics-based smooth scrolling
Plug 'christoomey/vim-tmux-navigator'          " Navigate seamlessly between vim and tmux
Plug 'sickill/vim-pasta'                       " Context aware pasting
Plug 'Yggdroot/indentLine'                     " Vertical indent guide lines
Plug 'wincent/loupe'                           " More resonable search settings
Plug 'mattn/webapi-vim'                        " Interface to WEB APIs
Plug 'wincent/terminus'                        " Cursor shape change in insert and replace mode
                                               " Improved mouse support
                                               " Focus reporting (Reload buffer on focus if it has been changed externally )
                                               " Bracketed Paste mode
Plug 'vim-scripts/vim-auto-save'               " Enables auto save
Plug 'ntpeters/vim-better-whitespace'          " Highlight trailing whitespace in red
Plug 'editorconfig/editorconfig-vim'           " Makes use of editorconfig files
Plug 'tpope/vim-eunuch'                        " UNIX shell commands for vim
Plug 'tpope/vim-projectionist'                 " Projection and alternate navigation
Plug 'machakann/vim-highlightedyank'           " Highlight yanked text
Plug 'drmingdrmer/vim-toggle-quickfix'         " Toggle Quickfix Window
Plug 'janko-m/vim-test'

                                               " TEXTOBJECTS
Plug 'kana/vim-textobj-indent'                 " Creates an object of the current indent level
Plug 'kana/vim-textobj-line'                   " Creates the line object to exclude whitespace before the line start
Plug 'kana/vim-textobj-user'                   " Enables the creation of new objects

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

call plug#end()
