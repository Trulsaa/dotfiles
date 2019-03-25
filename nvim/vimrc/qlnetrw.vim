augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call s:NetrwMapping()
augroup END

function! s:slash() abort
  return !exists("+shellslash") || &shellslash ? '/' : '\'
endfunction

function! s:fnameescape(file) abort
  if exists('*fnameescape')
    return fnameescape(a:file)
  else
    return escape(a:file," \t\n*?[{`$\\%#'\"|!<")
  endif
endfunction

function! s:absolutes(first, ...) abort
  let files = getline(a:first, a:0 ? a:1 : a:first)
  call filter(files, 'v:val !~# "^\" "')
  call map(files, 'b:netrw_curdir . s:slash() . substitute(v:val, "[/*|@=]\\=\\%(\\t.*\\)\\=$", "", "")')
  return files
endfunction

function! s:relatives(first, ...) abort
  let files = s:absolutes(a:first, a:0 ? a:1 : a:first)
  call filter(files, 'v:val !~# "^\" "')
  for i in range(len(files))
    let relative = fnamemodify(files[i], ':.')
    if relative !=# files[i]
      let files[i] = '.' . s:slash() . relative
    endif
  endfor
  return files
endfunction

function! s:escaped(first, last) abort
  let files = s:relatives(a:first, a:last)
  return join(map(files, 's:fnameescape(v:val)'), ' ')
endfunction

function! s:NetrwMapping() abort
  nnoremap <buffer> <Leader>w :<C-U> <C-R>=<SID>escaped(line('.'), line('.') - 1 + v:count1)<CR><Home>silent !qlmanage -p<CR>
endfunction
