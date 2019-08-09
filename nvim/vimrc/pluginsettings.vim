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
let g:ale_linters_explicit = 1
let g:ale_linters = {}
let g:ale_linters['go'] = ['gofmt']
" let g:ale_linters['javascript'] = ['eslint']
" let g:ale_linters['python'] = ['pylint']
" let g:ale_linters['typescript'] = ['eslint']
"
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['json'] = ['prettier']
let g:ale_fixers['typescript'] = ['prettier']
let g:ale_fixers['markdown'] = ['prettier']
let g:ale_fixers['css'] = ['prettier']
let g:ale_fixers['html'] = ['prettier']
let g:ale_fixers['go'] = ['gofmt']

let g:ale_javascript_prettier_use_local_config = 1
let g:ale_echo_msg_format = '%linter% - %severity% - %code: %%s'

" vim-go
let g:go_fmt_autosave = 0
let g:deoplete#sources#go#gocode_binary = '~/Projects/go/bin/gocode'
let g:deoplete#sources#go#builtin_objects = 1
let g:deoplete#sources#go#unimported_packages = 1
let g:go_def_mapping_enabled = 0

" vim-test
let test#strategy = "neovim"
let test#neovim#term_position = "vsplit"

let g:LanguageClient_diagnosticsDisplay = {
      \  1: {
      \      "signText": "",
      \      "virtualTexthl": "Todo",
      \      "signTexthl": 'LineNr',
      \  },
      \  2: {
      \      "name": "Warning",
      \      "texthl": "ALEWarning",
      \      "signText": "⚠",
      \      "signTexthl": "ALEInfoSign",
      \      "virtualTexthl": "Todo",
      \  },
      \  3: {
      \      "name": "Information",
      \      "texthl": "ALEInfo",
      \      "signText": "ℹ",
      \      "signTexthl": "ALEInfoSign",
      \      "virtualTexthl": "Todo",
      \  },
      \  4: {
      \      "name": "Hint",
      \      "texthl": "ALEInfo",
      \      "signText": "➤",
      \      "signTexthl": "ALEInfoSign",
      \      "virtualTexthl": "Todo",
      \  },
      \ }

let g:LanguageClient_rootMarkers = {
      \ 'javascript': ['tsconfig.json', 'package.json'],
      \ 'typescript': ['tsconfig.json', 'package.json'],
      \ 'go': ['main.go']
      \ }

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'typescript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'typescript.jsx': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'go': ['gopls'],
    \ 'sh': ['bash-language-server', 'start']
    \ }

let g:LanguageClient_diagnosticsList='Location'

nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <silent> gi :call LanguageClient#textDocument_implementation()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>

command Rename execute "call LanguageClient#textDocument_rename()"

function! s:GetBufferList() 
  redir =>buflist 
  silent! ls 
  redir END 
  return buflist 
endfunction

function! ToggleLocationList()
  let curbufnr = winbufnr(0)
  for bufnum in map(filter(split(s:GetBufferList(), '\n'), 'v:val =~ "Location List"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if curbufnr == bufnum
      lclose
      return
    endif
  endfor

  let winnr = winnr()
  let prevwinnr = winnr("#")

  let nextbufnr = winbufnr(winnr + 1)
  try
    lopen
  catch /E776/
      echohl ErrorMsg 
      echo "Location List is Empty."
      echohl None
      return
  endtry
  if winbufnr(0) == nextbufnr
    lclose
    if prevwinnr > winnr
      let prevwinnr-=1
    endif
  else
    if prevwinnr > winnr
      let prevwinnr+=1
    endif
  endif
  " restore previous window
  exec prevwinnr."wincmd w"
  exec winnr."wincmd w"
endfunction

function! ToggleQuickfixList()
  for bufnum in map(filter(split(s:GetBufferList(), '\n'), 'v:val =~ "Quickfix List"'), 'str2nr(matchstr(v:val, "\\d\\+"))') 
    if bufwinnr(bufnum) != -1
      cclose
      return
    endif
  endfor
  let winnr = winnr()
  if exists("g:toggle_list_copen_command")
    exec(g:toggle_list_copen_command)
  else
    copen
  endif
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <script> <silent> <leader>e :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>
