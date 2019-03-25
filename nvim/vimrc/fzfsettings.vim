" ESC to close fzf buffer
augroup fzf_esc_close
  autocmd!
  autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>
augroup END

map <Leader>f :GitLsFiles<cr>
map <Leader>F :Files
map <Leader>b :Buffers<cr>
map <Leader>l :Ag<cr>
map <Leader>H :Helptags<cr>
map <Leader>m :Marks<cr>
map <Leader>g :GFiles?<cr>

" Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Augmenting Ag command using fzf#vim#with_preview function
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview(), <bang>0)

" Created new GitLsFiles that does the same as GFiles with a preview
command! -bang -nargs=0 -complete=dir GitLsFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
