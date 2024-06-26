return {
  { "andymass/vim-matchup", event = "VimEnter" }, -- operate on sets of matching text. It extends vim's % key to language-specific words
  "tpope/vim-repeat", -- Enable . repeating for more
  "tpope/vim-surround", -- Surround objects with anything
  "tpope/vim-unimpaired", -- Tpope navigation mapppings
  "yuttie/comfortable-motion.vim", -- Physics-based smooth scrolling
  "christoomey/vim-tmux-navigator", -- Navigate seamlessly between vim and tmux
  "wincent/loupe", -- More resonable search settings
  "ntpeters/vim-better-whitespace", -- Highlight trailing whitespace in red
  "tpope/vim-projectionist", -- Projection and alternate navigation
  "tpope/vim-dispatch",
  "machakann/vim-highlightedyank", -- Highlight yanked text
  "vim-scripts/ReplaceWithRegister", -- Replace with registery content
  {
    "mbbill/undotree",
    lazy = true,
    cmd = { "UndotreeFocus", "UndotreeHide", "UndotreeShow", "UndotreeToggle" },
  }, -- Undo history visualisation
  "nvim-lua/popup.nvim",
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      vim.o.background = "dark" -- or "light" for light mode
      vim.cmd([[colorscheme gruvbox]])
    end,
  }, -- Gruvbox theme for vim
  -- GIT PLUGINS
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
      require("neogit").setup({
        kind = "split",
      })
    end,
  },
  "tpope/vim-fugitive", -- Git wrapper
  {
    "notjedi/nvim-rooter.lua",
    config = function()
      require("nvim-rooter").setup()
    end,
  },
  "kyazdani42/nvim-web-devicons",
  {
    "echasnovski/mini.indentscope",
    version = false,
    config = function()
      require("mini.indentscope").setup({
        draw = {
          delay = 0,
          animation = require("mini.indentscope").gen_animation.none(),
        },
        symbol = "│",
      })
    end,
  },
  { "kevinhwang91/nvim-bqf", dependencies = {
    "junegunn/fzf",
  } },
  "LunarVim/bigfile.nvim",
}
