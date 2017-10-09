" Goyo settings
" Quit nvim if no other buffers are open
" Toggle tmux statusline
" Fix colors in for GitGutter
" Auto load goyo when opening markdown
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  highlight clear LineNr
  highlight clear GitGutterAddDefault
  highlight clear GitGutterChangeDefault
  highlight clear GitGutterDeleteDefault
  highlight clear GitGutterChangeDeleteDefaults
  highlight GitGutterAddDefault ctermfg=2
  highlight GitGutterChangeDefault ctermfg=3
  highlight GitGutterDeleteDefault ctermfg=1
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

function! s:auto_goyo()
  if &ft == 'markdown'
    Goyo 80
  elseif exists('#goyo')
    let bufnr = bufnr('%')
    Goyo!
    execute 'b '.bufnr
  endif
endfunction

augroup goyo_markdown
  autocmd!
  autocmd BufNewFile,BufRead * call s:auto_goyo()
augroup END

" TODO: Fikse slik at det fungerer når man hopper mellom goyo winduer <25-09-17, Truls> "
autocmd FocusLost *.md call s:goyo_leave()
autocmd FocusGained *.md call s:goyo_focus_gained()

function! s:goyo_focus_gained()
  if &ft == 'markdown' && exists('#goyo')
    call <SID>goyo_enter()
  endif
endfunction
