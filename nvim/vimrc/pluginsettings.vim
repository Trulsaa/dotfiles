" auto-pairs settings
let g:AutoPairsShortcutFastWrap='<C-e>'

" Ultisnips settings
let g:UltiSnipsExpandTrigger="<C-Space>"
let g:UltiSnipsJumpForwardTrigger="<C-Space>"
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" NERDTree settings
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
