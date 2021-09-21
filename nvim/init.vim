" Source Plugins
scriptencoding utf-8

lua require('plugins')

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

augroup general_autocmd

  " Autosave on focus change or buffer change (terminus plugin takes care of reload)
  autocmd BufLeave,FocusLost * silent! wall

  " Open files with cursor at last known position
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

  " Start git commit editing in insert mode
  autocmd FileType gitcommit startinsert

augroup END

" Add current working directory in front of the current file in airline section c
let g:airline_section_c = "%{substitute(getcwd(), '^.*/', '', '')} %<%f%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#"

lua require("vimrc")

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
" Underline matching bracket and remove background color
hi MatchParen cterm=underline ctermbg=none

" THEME SETTINGS
" SingColumn color and LineNr cleared
highlight! link SignColumn LineNr
highlight clear LineNr
" set color for the terminal cursor in terminal mode
hi! TermCursorNC ctermfg=15 guifg=#fdf6e3 ctermbg=14 guibg=#93a1a1 cterm=NONE gui=NONE

" Runs current line as a command in zsh and outputs stdout to file
noremap Q !!zsh<CR>

"Map <C-w>N to exit terminal-mode:
tnoremap <C-W>N <C-\><C-n>

" Remap H L
nnoremap H 5H
nnoremap L 5L

" Todo file
command! Todo :vsplit ~/Desktop/Todo.md
" Daybook file
command! Day :vsplit ~/Desktop/Daybook.md

" H in commandlinemode now runs Helptags
command! H Helptags

" Projections alternate binding
map <Leader>a :A<cr>

" Toggle Quickfix Window
nmap <Leader>q <Plug>window:quickfix:toggle

" Close Preview window
nmap <silent><Leader>w :pclose<CR>

" Search for selected text using git grep in current project
vnoremap <Leader>s y:Ggrep "<c-r>""

" auto-pairs settings
let g:AutoPairsShortcutFastWrap='<C-e>'

" vim-easy-align mappings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Indentline settings
let g:indentLine_fileTypeExclude = ['help', 'markdown', 'abap', 'vim', 'json', 'snippets']
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
