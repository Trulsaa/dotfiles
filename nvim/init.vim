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

" Source Plugins
source ./vimrc/plugins.vim

" Basic settings
set mouse=a                    " mouse support in all modes
language en_us                 " sets the language of the messages / ui (vim)
syntax enable                  " enable syntax highlighting
colorscheme solarized          " solarized colorscheme
set background=dark            " solarized dark
set backupdir=~/.vim/.backup// " store all vim backup files in ~/.vim/.backup//
set directory=~/.vim/.backup// " store all vim backup files in ~/.vim/.backup//
set expandtab                  " to insert space characters whenever the tab key is pressed
set shiftwidth=2               " number of spaces used when indenting
set softtabstop=2              " number of spaces used when indenting usin tab
set fileencodings=utf-8        " set output encoding of the file that is written
set clipboard=unnamedplus      " everything you yank in vim will go to the unnamed register, and vice versa.
set number relativenumber      " each line in your file is numbered relative to the line you’re currently on
set breakindent                " break lines to the indent level
set linebreak                  " brak lines at words
set hidden                     " bufferswitching without having to save first.
set splitbelow                 " Creates new splits below
set splitright                 " Creates new splits to the right
set updatetime=250             " Time in milliseconds between saving of the swap-file, also uppdates gitgutter
filetype plugin on

" Open files with cursor at last known position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif 

" Matching parentheses settings
hi MatchParen cterm=underline ctermbg=none " Underline matching bracket and remove background color

" Let's save undo info!
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

" KEYMAPPINGS
"===========
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
" Remap visual block
nnoremap <Leader>v <c-v>
" Remap H L
noremap H 5H
nnoremap L 5L

" Automatically removing all trailing whitespace on save for javascript, html, css and markdown
autocmd FileType javascript,html,css,markdown autocmd BufWritePre <buffer> %s/\s\+$//e

" auto-pairs settings
let g:AutoPairsShortcutFastWrap='<C-e>'

" Deoplete settings
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
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
let g:deoplete#sources#ternjs#docs = 1

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

" Deoplete emoji settings
call deoplete#custom#set('emoji', 'filetypes', ['gitcommit', 'markdown', 'javascript', 'html'])

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
autocmd StdinReadPre * let s:std_in=1                                                                                                  " Open NERDTree if now file is spesified
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif                                                            " Open NERDTree if now file is spesified
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif " Start NERDtree if opening a directory"
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif                                  " Start NERDtree if opening a directory"
map <Leader>t :NERDTreeToggle<CR> 

" SingColumn color and LineNr cleared
highlight clear LineNr

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

" Indentline plugin settings
let g:indentLine_fileTypeExclude = ['help', 'markdown', 'abap', 'vim', 'json']
let g:indentLine_bufNameExclude=['NERD_tree.*']
let g:indentLine_char = '⎸▏'

" NERDTree settings
let NERDTreeShowHidden=1

" Airline settings
set noshowmode                 " Disable showing of mode in command line

source ./vimrc/goyosettings.vim
