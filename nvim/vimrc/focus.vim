" Highlight up to 255 columns (this is the current Vim max) beyond 'textwidth'
set textwidth=90
let &l:colorcolumn='+' . join(range(0, 254), ',+')

" Blacklist buffer types when focusing
let g:ColorColumnBlacklist = ['diff', 'fugitiveblame', 'undotree', 'nerdtree', 'qf']
let g:CursorlineBlacklist = ['command-t']

function! Should_colorcolumn() abort
  return index(g:ColorColumnBlacklist, &filetype) == -1
endfunction

function! Should_cursorline() abort
  return index(g:CursorlineBlacklist, &filetype) == -1
endfunction

" Make current window more obvious by turning off/adjusting 
" some features in non-current windows.
if exists('+winhighlight')
  autocmd BufEnter,FocusGained,VimEnter,WinEnter * if 
        \ Should_colorcolumn() | 
        \ set winhighlight= | 
        \ endif
  autocmd FocusLost,WinLeave * if Should_colorcolumn() | 
        \ set winhighlight=CursorLineNr:LineNr,
        \ IncSearch:ColorColumn,
        \ Normal:ColorColumn,
        \ NormalNC:ColorColumn,
        \ SignColumn:ColorColumn | 
        \ endif
elseif exists('+colorcolumn')
  autocmd BufEnter,FocusGained,VimEnter,WinEnter * if 
        \ Should_colorcolumn() | 
        \ let &l:colorcolumn='+' . join(range(0, 254), ',+') | 
        \ execute 'highlight link EndOfBuffer ColorColumn' |
        \ endif
  autocmd FocusLost,WinLeave * if 
        \ Should_colorcolumn() | 
        \ let &l:colorcolumn=join(range(1, 255), ',') |
        \ endif
endif
autocmd InsertLeave,VimEnter,WinEnter * if 
      \ Should_cursorline() | 
      \ setlocal cursorline | 
      \ endif
autocmd InsertEnter,WinLeave * if 
      \ Should_cursorline() | 
      \ setlocal nocursorline | 
      \ endif
