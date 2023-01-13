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
opt.laststatus = 3 -- show only one statusbar

vim.api.nvim_create_autocmd(
  "BufReadPost",
  {
    desc = "Open files with cursor at last known position",
    pattern = "*",
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]
  }
)

vim.api.nvim_create_autocmd(
  "FileType",
  {
    desc = "Start git commit editing in insert mode",
    pattern = "gitcommit",
    command = "startinsert"
  }
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

local netrw_mapping_id = vim.api.nvim_create_augroup("netrw_mapping", {clear = true})
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = "netrw",
    desc = "vim-tmux-navigator: Overwrite <c-l> in netrw buffers to enable TmuxNavigateRight from",
    group = netrw_mapping_id,
    command = "nnoremap <silent> <buffer> <c-l> :TmuxNavigateRight<CR>"
  }
)

-- Todo file and Daybook file
vim.api.nvim_create_user_command("Todo", "vsplit /Users/t/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notater/Todo.md", {})

-- Global mappings
-- ===============
local map = vim.keymap.set

-- map the leader key
map("n", "<Space>", "")
g.mapleader = " "

-- Runs current line as a command in zsh and outputs stdout to file
map("n", "Q", "!!zsh<CR>")

-- Map <C-w>N to exit terminal-mode:
map("t", "<C-W>N", "<C-\\><C-n>")

-- Remap H L
map("n", "H", "5H")
map("n", "L", "5L")

-- Projections alternate binding
map("n", "<Leader>a", ":A<cr>")

require("plugins")
require("telescopesetup")
require("hiddenfilessetup")
require("lspsetup")
require("lualineconfig")
require("completion")
