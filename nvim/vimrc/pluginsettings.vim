" auto-pairs settings
let g:AutoPairsShortcutFastWrap='<C-e>'

" Ultisnips settings
let g:UltiSnipsExpandTrigger="<C-Space>"
let g:UltiSnipsJumpForwardTrigger="<C-Space>"
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" NERDTree settings
autocmd StdinReadPre * let s:std_in=1                                                                                                  " Open NERDTree if now file is spesified
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif                                                            " Open NERDTree if now file is spesified
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif " Start NERDtree if opening a directory"
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif                                  " Start NERDtree if opening a directory"
let NERDTreeShowHidden=1                                                                                                               " Show hidden files
map <Leader>t :NERDTreeToggle<CR>

" Neomake settings
let g:neomake_javascript_enabled_makers = ['eslint']
autocmd! BufWritePost * Neomake

" vim-easy-align mappings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Indentline settings
let g:indentLine_fileTypeExclude = ['help', 'markdown', 'abap', 'vim', 'json']
let g:indentLine_bufNameExclude=['NERD_tree.*']
let g:indentLine_char = '⎸▏'

" NERDTree settings
let NERDTreeShowHidden=1

" Airline settings
set noshowmode                 " Disable showing of mode in command line
