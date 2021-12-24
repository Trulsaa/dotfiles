local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options

cmd("syntax enable") -- enable syntax highlighting
cmd("filetype plugin on") -- Enable use of filespesiffic settings files

-- cmd("colorscheme solarized") -- solarized colorscheme
-- opt.background = "dark" -- solarized dark
opt.expandtab = true -- to insert space characters whenever the tab key is pressed
opt.shiftwidth = 2 -- number of spaces used when indenting
opt.softtabstop = 4 -- number of spaces used when indenting using tab
opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
opt.fileencodings = "utf-8" -- set output encoding of the file that is written
opt.clipboard = "unnamedplus" -- everything you yank in vim will go to the unnamed register, and vice versa.
opt.relativenumber = true -- each line in your file is numbered relative to the line you’re currently on
opt.number = true -- show line number for current line
opt.breakindent = true -- brake lines to the indent level
opt.linebreak = true -- brake lines at words
opt.splitbelow = true -- Creates new splits below
opt.splitright = true -- Creates new splits to the right
opt.foldmethod = "indent" -- Fold on indentations
opt.foldlevel = 99 -- The level that is folded when opening files
opt.diffopt = "vertical" -- Diff opens side by side
opt.lazyredraw = true -- Don't bother updating screen during macro playback
opt.scrolloff = 3 -- Start scrolling 3 lines before edge of window
opt.cursorline = true -- Highlights the line the cursor is on
opt.shortmess:append({A = true}) -- don't give the ATTENTION message when an existing swap file is found.
opt.inccommand = "split" -- enables live preview of substitutions
opt.showmode = false -- Disable showing of mode in command line
opt.mouse = "a" -- scroll with mouse

cmd(
  [[
augroup general_autocmd

  " Open files with cursor at last known position
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

  " Start git commit editing in insert mode
  autocmd FileType gitcommit startinsert

augroup END
]]
)

-- Truncate branch name in airline to max 20 chars
g["airline#extensions#branch#displayed_head_limit"] = 20

-- Add current working directory in front of the current file in airline section c
-- g.airline_section_c =
-- "%{substitute(getcwd(), '^.*/', '', '')} %<%f%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#"

-- EditorConfig settings
-- To ensure that this plugin works well with Tim Pope's fugitive
g.EditorConfig_exclude_patterns = {"fugitive://.*"}

-- Emmet
g.user_emmet_settings = {["javascript.jsx"] = {["extends"] = "jsx"}}

-- Underline matching bracket and remove background color
cmd("hi MatchParen cterm=underline ctermbg=none")

-- SingColumn color and LineNr cleared
-- cmd([[
--   highlight! link SignColumn LineNr
--   highlight clear LineNr
-- ]])
cmd("highlight clear SignColumn")

-- Overwrite <c-l> in netrw buffers to enable TmuxNavigateRight from
-- vim-tmux-navigator
cmd(
  [[
  augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
  augroup END

  function! NetrwMapping()
    nnoremap <silent> <buffer> <c-l> :TmuxNavigateRight<CR>
  endfunction
]]
)

-- Todo file and Daybook file
cmd([[
  command! Todo :vsplit ~/Desktop/Todo.md
  command! Day :vsplit ~/Desktop/Daybook.md
]])

-- Global mappings
-- ===============
local map = vim.api.nvim_set_keymap

-- map the leader key
map("n", "<Space>", "", {})
g.mapleader = " "

-- Runs current line as a command in zsh and outputs stdout to file
map("n", "Q", "!!zsh<CR>", {noremap = true})

-- Map <C-w>N to exit terminal-mode:
map("t", "<C-W>N", "<C-\\><C-n>", {noremap = true})

-- Remap H L
map("n", "H", "5H", {noremap = true})
map("n", "L", "5L", {noremap = true})

-- Projections alternate binding
map("n", "<Leader>a", ":A<cr>", {noremap = true})

require("plugins")
require("telescopesetup")
require("hiddenfilessetup")
require("lspsetup")
require("lualineconfig")
require("completion")
