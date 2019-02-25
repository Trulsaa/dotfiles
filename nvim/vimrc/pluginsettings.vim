" auto-pairs settings
scriptencoding utf-8
let g:AutoPairsShortcutFastWrap='<C-e>'

" Ultisnips settings
let g:UltiSnipsExpandTrigger='<C-Space>'
let g:UltiSnipsJumpForwardTrigger='<C-Space>'
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" vim-easy-align mappings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Indentline settings
let g:indentLine_fileTypeExclude = ['help', 'markdown', 'abap', 'vim', 'json', 'snippets']
let g:indentLine_bufNameExclude=['NERD_tree.*']
let g:indentLine_char = '⎸▏'

" Gist settins
let g:gist_post_private = 1 " Gists are secret by default

" Airline settings
set noshowmode " Disable showing of mode in command line

" Limelight settings
let g:limelight_conceal_ctermfg = 240  " Solarized Base1

" vim-auto-save settins
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
let g:auto_save_silent = 1  " do not display the auto-save notification

" fugitive-gitlab.vim settings
let g:fugitive_gitlab_domains = ['https://innersourcs', 'https://innersource.soprasteria.com']

" EditorConfig settings
" To ensure that this plugin works well with Tim Pope's fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Emmet
let g:user_emmet_settings={
            \'javascript.jsx': {
            \      'extends':'jsx',
            \  },
            \}

" Ale
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['json'] = ['prettier']
let g:ale_fixers['typescript'] = ['prettier']
let g:ale_fixers['markdown'] = ['prettier']
let g:ale_fixers['css'] = ['prettier']
let g:ale_javascript_prettier_use_local_config = 1
