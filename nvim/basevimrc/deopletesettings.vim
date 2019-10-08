" Deoplete settings
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#max_list = 20
" close the preview window when you're not using it
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Deoplete sources
set completeopt=longest,menuone,preview
