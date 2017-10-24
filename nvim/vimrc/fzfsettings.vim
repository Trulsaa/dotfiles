" ESC to close fzf buffer
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>
map <Leader>f :GFiles<cr>
map <Leader>F :Files
map <Leader>b :Buffers<cr>
map <Leader>l :Ag<cr>
map <Leader>H :Helptags<cr>
map <Leader>m :Marks<cr>
map <Leader>g :GFiles?<cr>
map <Leader>s :Snippets<cr>
" Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

