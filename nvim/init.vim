" Source Plugins
scriptencoding utf-8

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

Plug 'jiangmiao/auto-pairs'                    " Insert or delete brackets, parens, quotes in pair.
Plug 'tpope/vim-vinegar'                       " Add functionality to netrw
Plug 'tomtom/tcomment_vim'                     " Comment objects
Plug 'tpope/vim-repeat'                        " Enable . repeating for more
Plug 'tpope/vim-surround'                      " Surround objects with anything
Plug 'yuttie/comfortable-motion.vim'           " Physics-based smooth scrolling
Plug 'christoomey/vim-tmux-navigator'          " Navigate seamlessly between vim and tmux
Plug 'sickill/vim-pasta'                       " Context aware pasting
Plug 'Yggdroot/indentLine'                     " Vertical indent guide lines
Plug 'wincent/loupe'                           " More resonable search settings
Plug 'wincent/terminus'                        " Cursor shape change in insert and replace mode
                                               " Improved mouse support
                                               " Focus reporting (Reload buffer on focus if it has been changed externally )
                                               " Bracketed Paste mode
Plug 'vim-scripts/vim-auto-save'               " Enables auto save
Plug 'ntpeters/vim-better-whitespace'          " Highlight trailing whitespace in red
Plug 'editorconfig/editorconfig-vim'           " Makes use of editorconfig files
Plug 'tpope/vim-projectionist'                 " Projection and alternate navigation
Plug 'machakann/vim-highlightedyank'           " Highlight yanked text
Plug 'vim-scripts/ReplaceWithRegister'         " Replace with registery content
Plug 'mbbill/undotree'                         " Undo history visualisation

                                               " TEXTOBJECTS
Plug 'kana/vim-textobj-indent'                 " Creates an object of the current indent level
Plug 'kana/vim-textobj-line'                   " Creates the line object to exclude whitespace before the line start
Plug 'kana/vim-textobj-user'                   " Enables the creation of new objects

                                               " HTML / JSX
Plug 'mattn/emmet-vim'                         " Autocompletion for html

                                               " HIGHLIGHTING
Plug 'pangloss/vim-javascript',                " JavaScript highlighting
            \ { 'for': ['javascript', 'jsx', 'javascript.jsx'] }
Plug 'mxw/vim-jsx'                             " JSX Highlighting
            \ { 'for': ['javascript', 'jsx', 'javascript.jsx'] }
Plug 'leafgarland/typescript-vim'              " Typescript syntax highlighting
Plug 'peitalin/vim-jsx-typescript'
Plug 'posva/vim-vue'                           " vue.js syntax highlighting
Plug 'ap/vim-css-color',                       " CSS syntax highlighting color colornames and codes
            \ { 'for': 'css' }
Plug 'hashivim/vim-terraform'                  " Terraform

Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

Plug 'airblade/vim-rooter'

call plug#end()

" Basic settings
syntax enable             " enable syntax highlighting
colorscheme solarized     " solarized colorscheme
set background=dark       " solarized dark
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
set noshowmode            " Disable showing of mode in command line

" Some coc servers have issues with backup files, see #649
set nobackup
set nowritebackup

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
highlight! link SignColumn LineNr
highlight clear LineNr
" set color for the terminal cursor in terminal mode
hi! TermCursorNC ctermfg=15 guifg=#fdf6e3 ctermbg=14 guibg=#93a1a1 cterm=NONE gui=NONE

" GitGutter colors
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" KEYMAPPINGS
"===========
" Leader
nnoremap <SPACE> <Nop>
let g:mapleader = ' '

" Runs current line as a command in zsh and outputs stdout to file
noremap Q !!zsh<CR>

"Map <C-w>N to exit terminal-mode:
tnoremap <C-W>N <C-\><C-n>

" Remap visual block
nnoremap <Leader>v <c-v>

" Remap H L
nnoremap H 5H
nnoremap L 5L

" Todo file
command! Todo :vsplit ~/Desktop/Todo.md
" Daybook file
command! Day :vsplit ~/Desktop/Daybook.md

" H in commandlinemode now runs Helptags
command! H Helptags

" GitGutter settings
nmap <Leader>ca <Plug>(GitGutterStageHunk) <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)
nmap ]c <Plug>(GitGutterNextHunk)
nmap <Leader>cu <Plug>(GitGutterUndoHunk)
nmap <Leader>cp <Plug>(GitGutterPreviewHunk)

" Projections alternate binding
map <Leader>a :A<cr>

" Toggle Quickfix Window
nmap <Leader>q <Plug>window:quickfix:toggle

" Close Preview window
nmap <silent><Leader>w :pclose<CR>

" Search for selected text using git grep in current project
vnoremap <Leader>s y:Ggrep "<c-r>""

" COC
" Use leader p to format current buffer
nmap <silent> <Leader>p <Plug>(coc-format)
" Use leader i to organize imports
nmap <Leader>i :call CocAction('runCommand', 'editor.action.organizeImport')<cr>

" Use <C-Space> for trigger snippet expand.
imap <C-Space> <Plug>(coc-snippets-expand)
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <C-Space> pumvisible() ? coc#_select_confirm() :
      \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" close the preview window when you're not using it
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gR <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>A :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>A :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Coc Go speciffic add tags to json
autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>

" Coc-jest Run jest for current project
command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')

" Coc-jest Run jest for current file
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])

" Coc-jest Run jest for current test
autocmd FileType typescript nmap <leader>t :call CocAction('runCommand', 'jest.fileTest', ['%'])<cr>

command! -nargs=1 NameTerm execute "keepalt file <args>"

" auto-pairs settings
let g:AutoPairsShortcutFastWrap='<C-e>'

" vim-easy-align mappings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Indentline settings
let g:indentLine_fileTypeExclude = ['help', 'markdown', 'abap', 'vim', 'json', 'snippets', 'fzf']
let g:indentLine_char = '⎸▏'

" Limelight settings
let g:limelight_conceal_ctermfg = 240  " Solarized Base1

" vim-auto-save settins
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
let g:auto_save_silent = 1  " do not display the auto-save notification

" fugitive-gitlab.vim settings
let g:fugitive_gitlab_domains = ['https://innersourcs', 'https://innersource.soprasteria.com']

" EditorConfig settings
" To ensure that this plugin works well with Tim Pope's fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Emmet
let g:user_emmet_settings={
            \'javascript.jsx': {
            \      'extends':'jsx',
            \  },
            \}

function! s:GetBufferList() 
  redir =>buflist 
  silent! ls 
  redir END 
  return buflist 
endfunction

function! ToggleLocationList()
  let curbufnr = winbufnr(0)
  for bufnum in map(filter(split(s:GetBufferList(), '\n'), 'v:val =~ "Location List"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if curbufnr == bufnum
      lclose
      return
    endif
  endfor

  let winnr = winnr()
  let prevwinnr = winnr("#")

  let nextbufnr = winbufnr(winnr + 1)
  try
    lopen
  catch /E776/
      echohl ErrorMsg 
      echo "Location List is Empty."
      echohl None
      return
  endtry
  if winbufnr(0) == nextbufnr
    lclose
    if prevwinnr > winnr
      let prevwinnr-=1
    endif
  else
    if prevwinnr > winnr
      let prevwinnr+=1
    endif
  endif
  " restore previous window
  exec prevwinnr."wincmd w"
  exec winnr."wincmd w"
endfunction

function! ToggleQuickfixList()
  for bufnum in map(filter(split(s:GetBufferList(), '\n'), 'v:val =~ "Quickfix List"'), 'str2nr(matchstr(v:val, "\\d\\+"))') 
    if bufwinnr(bufnum) != -1
      cclose
      return
    endif
  endfor
  let winnr = winnr()
  if exists("g:toggle_list_copen_command")
    exec(g:toggle_list_copen_command)
  else
    copen
  endif
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <script> <silent> <leader>e :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>

" ESC to close fzf buffer
augroup fzf_esc_close
  autocmd!
  autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>
augroup END

map <expr> <Leader>f system('git rev-parse --is-inside-work-tree') =~ 'true' ? ':GitLsFiles<cr>' : ':Files<cr>'
map <Leader>F :Files ~/Projects/
map <Leader>b :Buffers<cr>
map <Leader>l :Rg<cr>
map <Leader>H :Helptags<cr>
map <Leader>m :Marks<cr>
map <Leader>g :GFiles?<cr>

let g:fzf_layout = { 'up': '~40%' }

" Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Augmenting Ag command using fzf#vim#with_preview function
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview(), <bang>0)

" Created new GitLsFiles that does the same as GFiles with a preview
command! -bang -nargs=0 -complete=dir GitLsFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --smart-case --hidden --glob "!.git" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
      \ 'ctrl-s': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

" Overwrite <c-l> in netrw buffers to enable TmuxNavigateRight from
" vim-tmux-navigator
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
  nnoremap <silent> <buffer> <c-l> :TmuxNavigateRight<CR>
endfunction

" HIDDEN FILES CONFIG
if !isdirectory($HOME.'/.config/nvim/tmp')
    call mkdir($HOME.'/.config/nvim/tmp', '', 0700)
endif
if !isdirectory($HOME.'/.config/nvim/tmp/backup')
    call mkdir($HOME.'/.config/nvim/tmp/backup', '', 0700)
endif
if exists('$SUDO_USER')
  set nobackup                               " don't create root-owned files
  set nowritebackup                          " don't create root-owned files
else
  set backupdir+=~/.config/nvim/tmp/backup   " keep backup files out of the way
  set backupdir+=.
endif

if !isdirectory($HOME.'/.config/nvim/tmp/swap')
    call mkdir($HOME.'/.config/nvim/tmp/swap', '', 0700)
endif
if exists('$SUDO_USER')
  set noswapfile                             " don't create root-owned files
else
  set directory+=~/.config/nvim/tmp/swap//   " keep swap files out of the way
  set directory+=.
endif

if !isdirectory($HOME.'/.config/nvim/tmp/undo')
    call mkdir($HOME.'/.config/nvim/tmp/undo', '', 0700)
endif
if exists('$SUDO_USER')
  set noundofile                             " don't create root-owned files
else
  set undodir+=~/.config/nvim/tmp/undo       " keep undo files out of the way
  set undodir+=.
  set undofile                               " actually use undo files
endif

if !isdirectory($HOME.'/.config/nvim/tmp/viminfo')
    call mkdir($HOME.'/.config/nvim/tmp/viminfo', '', 0700)
endif
if has('viminfo')
  if exists('$SUDO_USER')
    set viminfo=                             " don't create root-owned files
  else
    set viminfo+=n~/.config/nvim/tmp/viminfo " override ~/.viminfo default
    if !empty(glob('~/.config/nvim/tmp/viminfo'))
      if !filereadable(expand('~/.config/nvim/tmp/viminfo'))
        echoerr 'warning: ~/.config/nvim/tmp/viminfo exists but is not readable'
      endif
    endif
  endif
endif
