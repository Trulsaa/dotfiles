" set spell spelllang=en_gb
set spell spelllang=en_gb
let g:vim_markdown_folding_disabled = 1
set conceallevel=2

" Indentation in markdown set to 4 spaces
augroup markdwon_indentation
  autocmd!
  autocmd FileType markdown setl sw=4 sts=4 et
augroup END

