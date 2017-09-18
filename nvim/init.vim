" # Instalation
"
" Install neovim
" brew install neovim
"
" Install pip3
" brew install python3
"
" Implement support for python plugins in Nvim
" pip3 install neovim
"
"
" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()

Plug 'christoomey/vim-sort-motion'    " Sort object
Plug 'jiangmiao/auto-pairs'           " Insert or delete brackets, parens, quotes in pair.
Plug 'neomake/neomake'                " Used to run code linters
Plug 'scrooloose/nerdtree'            " Filetree
Plug 'tmhedberg/SimpylFold'           " Fold functions
Plug 'tpope/vim-commentary'           " Comment objects
Plug 'tpope/vim-repeat'               " Enable . repeating for more
Plug 'tpope/vim-surround'             " Surround objects with anything
Plug 'yuttie/comfortable-motion.vim'  " Physics-based smooth scrolling
Plug 'christoomey/vim-tmux-navigator' " Navigate seamlessly between vim and tmux
Plug 'junegunn/goyo.vim'              " Destraction free writing
Plug 'craigemery/vim-autotag'         " Autoupdate ctags
Plug 'junegunn/vim-easy-align'        " Alignment on any character

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
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }                                             " Load last because of :UpdateReomotePlugins

" Fuzzy filesearch
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" theme and statusline
Plug 'altercation/vim-colors-solarized' " Solarized theme for vim
Plug 'vim-airline/vim-airline'          " Status line configuration
Plug 'vim-airline/vim-airline-themes'   " Status line themes

" Git plugins
Plug 'mhinz/vim-signify'  " Shows changed lines compared to last git commit
Plug 'tpope/vim-fugitive' " Git wrapper

call plug#end()

" Basic settings
set mouse=a
language en_US
syntax enable
set background=dark
colorscheme solarized
set backupdir=~/.vim/.backup//
set directory=~/.vim/.backup//
set undodir=~/.vim/.undo
set expandtab
set shiftwidth=2
set softtabstop=2
set fileencodings=utf-8
" set clipboard=unnamed
set clipboard+=unnamedplus
set conceallevel=2
set relativenumber
set number
let g:vim_markdown_folding_disabled = 1
set breakindent
set linebreak

" Automatically removing all trailing whitespace on save for javascript, html and css
autocmd FileType javascript,html,css,markdown autocmd BufWritePre <buffer> %s/\s\+$//e

" KEYMAPPINGS
let mapleader = ","
" Runs current line as a command in zsh and outputs stdout to file
noremap Q !!zsh<CR>
" CTRL S to save
noremap <c-s> :w<CR>
map <Leader>s :source ~/.config/nvim/init.vim<CR>
" Enable folding with the spacebar
nnoremap <space> za
" Open i google chrome
map <silent> <C-p> :!oigc %<CR><CR>
"To map <Esc> to exit terminal-mode:
tnoremap <Esc> <C-\><C-n>
" Copy filepath to clipboard
nmap ,cs :let @*=expand("%")<CR>

" auto-pairs settings
let g:AutoPairsShortcutFastWrap='<C-e>'

" Deoplete settings
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
" close the preview window when you're not using it
" let g:SuperTabClosePreviewOnPopupClose = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Deoplet-ternjs settings
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#omit_object_prototype = 0
let g:deoplete#sources#ternjs#include_keywords = 1
let g:deoplete#sources#ternjs#filetypes = ['jsx', 'javascript.jsx']

" Deoplete omni settings
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
      \ 'tern#Complete',
      \ 'jspc#omni'
      \]

" Deoplete sources
set completeopt=longest,menuone,preview
" let g:deoplete#sources = {}
" let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
" let g:tern#command = ['tern']
" let g:tern#arguments = ['--persistent']

" Ultisnips settings
let g:UltiSnipsExpandTrigger="<C-Space>"
let g:UltiSnipsJumpForwardTrigger="<C-Space>"
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" vim-markdown-preview settings
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=1

" cabbrev
ca tn tabnew

" Enable folding
set foldmethod=indent
set foldlevel=99

" Flag extraneous whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" NERDTree settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <Leader>t :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" SingColumn color
highlight clear SignColumn

" Neomake settings
let g:neomake_javascript_enabled_makers = ['eslint']
nmap <Leader><Space>o :lopen<CR>      " open location window
nmap <Leader><Space>c :lclose<CR>     " close location window
nmap <Leader><Space>, :ll<CR>         " go to current error/warning
nmap <Leader><Space>n :lnext<CR>      " next error/warning
nmap <Leader><Space>p :lprev<CR>      " previous error/warning
autocmd! BufWritePost * Neomake


" fzf settings
map <Leader>p :Files 
map <Leader>b :Buffers<cr>
" Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

" Diff options
set diffopt=vertical

" vim-easy-align mappings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
