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
