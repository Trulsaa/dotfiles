local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
print(fn.glob(install_path))
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd("packadd packer.nvim")
end

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  use("jiangmiao/auto-pairs") -- Insert or delete brackets, parens, quotes in pair.
  use({ "andymass/vim-matchup", event = "VimEnter" }) -- operate on sets of matching text. It extends vim's % key to language-specific words
  use("tpope/vim-vinegar") -- Add functionality to netrw
  use("tomtom/tcomment_vim") -- Comment objects
  use("tpope/vim-repeat") -- Enable . repeating for more
  use("tpope/vim-surround") -- Surround objects with anything
  use("tpope/vim-unimpaired") -- Tpope navigation mapppings
  use("yuttie/comfortable-motion.vim") -- Physics-based smooth scrolling
  use("christoomey/vim-tmux-navigator") -- Navigate seamlessly between vim and tmux
  use("sickill/vim-pasta") -- Context aware pasting
  use("Yggdroot/indentLine") -- Vertical indent guide lines
  use("wincent/loupe") -- More resonable search settings
  use("wincent/terminus") -- Cursor shape change in insert and replace mode
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && yarn install",
  })

  -- Improved mouse support
  -- Focus reporting (Reload buffer on focus if it has been changed externally )
  -- Bracketed Paste mode
  use("vim-scripts/vim-auto-save") -- Enables auto save
  use("ntpeters/vim-better-whitespace") -- Highlight trailing whitespace in red
  use("editorconfig/editorconfig-vim") -- Makes use of editorconfig files
  use({
    "tpope/vim-projectionist",
    opt = true,
    cmd = { "A", "AS", "AV", "AT", "AD", "Pcd", "Plcd", "Ptcd", ProjectDo },
  }) -- Projection and alternate navigation
  use("machakann/vim-highlightedyank") -- Highlight yanked text
  use("vim-scripts/ReplaceWithRegister") -- Replace with registery content
  use({
    "mbbill/undotree",
    opt = true,
    cmd = { "UndotreeFocus", "UndotreeHide", "UndotreeShow", "UndotreeToggle" },
  }) -- Undo history visualisation

  -- TEXTOBJECTS
  use("kana/vim-textobj-indent") -- Creates an object of the current indent level
  use("kana/vim-textobj-line") -- Creates the line object to exclude whitespace before the line start
  use("kana/vim-textobj-user") -- Enables the creation of new objects

  use("neovim/nvim-lspconfig") -- LSP
  use("hrsh7th/nvim-compe")
  use("ray-x/lsp_signature.nvim") -- Show function signature when you type
  use("SirVer/ultisnips")

  -- HTML / JSX
  use("mattn/emmet-vim") -- Autocompletion for html

  -- HIGHLIGHTING
  use({ "nvim-treesitter/nvim-treesitter", cmd = ":TSUpdate" }) -- Update the parsers

  -- FUZZY FILESEARCH
  use("nvim-lua/popup.nvim")
  use({
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })

  -- THEME AND STATUSLINE
  use("altercation/vim-colors-solarized") -- Solarized theme for vim
  use("vim-airline/vim-airline") -- Status line configuration
  use("vim-airline/vim-airline-themes") -- Status line themes
  use("edkolev/tmuxline.vim") -- Makes tmux status line match vim status line

  -- GIT PLUGINS
  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup()
    end,
  })
  use("tpope/vim-fugitive") -- Git wrapper

  use("airblade/vim-rooter")
  use("kyazdani42/nvim-web-devicons")
end)
