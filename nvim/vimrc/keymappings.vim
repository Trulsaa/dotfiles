" KEYMAPPINGS
"===========
" Leader
nnoremap <SPACE> <Nop>
let mapleader = " "

" Runs current line as a command in zsh and outputs stdout to file
noremap Q !!zsh<CR>

" Source init.vim
map <Leader>s :source ~/.config/nvim/init.vim<CR>

" Open in google chrome
map <silent> <C-p> :!oigc "%"<CR><CR>

"To map <Esc> to exit terminal-mode:
tnoremap <Esc> <C-\><C-n>

" Copy filepath to clipboard
nmap ,cs :let @*=expand("%")<CR>

" Remap visual block
nnoremap <Leader>v <c-v>

" Remap H L
noremap H 5H
nnoremap L 5L

" H in commandlinemode now runs Helptags
command! H Helptags
