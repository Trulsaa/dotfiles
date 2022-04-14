local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
print(fn.glob(install_path))
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
  vim.cmd("packadd packer.nvim")
end

return require("packer").startup(
  function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    use("jiangmiao/auto-pairs") -- Insert or delete brackets, parens, quotes in pair.
    use({"andymass/vim-matchup", event = "VimEnter"}) -- operate on sets of matching text. It extends vim's % key to language-specific words
    use("tpope/vim-vinegar") -- Add functionality to netrw
    use("b3nj5m1n/kommentary") -- Comment objects
    use("tpope/vim-repeat") -- Enable . repeating for more
    use("tpope/vim-surround") -- Surround objects with anything
    use("tpope/vim-unimpaired") -- Tpope navigation mapppings
    use("yuttie/comfortable-motion.vim") -- Physics-based smooth scrolling
    use("christoomey/vim-tmux-navigator") -- Navigate seamlessly between vim and tmux
    use(
      {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
          require("indent_blankline").setup(
            {
              buftype_exclude = {"help", "markdown", "abap", "vim", "json", "snippets", "terminal"},
              show_current_context = true
            }
          )
        end
      }
    ) -- Vertical indent guide lines
    use("wincent/loupe") -- More resonable search settings
    use(
      {
        "Pocco81/AutoSave.nvim",
        config = function()
          require("autosave").setup(
            {
              execution_message = ""
            }
          )
        end
      }
    )
    use(
      {
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        opt = true,
        ft = {"markdown"},
        cmd = {"MarkdownPreview", "MarkdownPreviewToggle"}
      }
    )
    use("kosayoda/nvim-lightbulb") -- show a lightbulb in the sign column if there are actions

    -- Improved mouse support
    -- Focus reporting (Reload buffer on focus if it has been changed externally )
    -- Bracketed Paste mode
    use("vim-scripts/vim-auto-save") -- Enables auto save
    use("ntpeters/vim-better-whitespace") -- Highlight trailing whitespace in red
    use("editorconfig/editorconfig-vim") -- Makes use of editorconfig files
    use("tpope/vim-projectionist") -- Projection and alternate navigation
    use("tpope/vim-dispatch")
    use("machakann/vim-highlightedyank") -- Highlight yanked text
    use("vim-scripts/ReplaceWithRegister") -- Replace with registery content
    use(
      {
        "mbbill/undotree",
        opt = true,
        cmd = {"UndotreeFocus", "UndotreeHide", "UndotreeShow", "UndotreeToggle"}
      }
    ) -- Undo history visualisation

    -- TEXTOBJECTS
    use("kana/vim-textobj-indent") -- Creates an object of the current indent level
    use("kana/vim-textobj-line") -- Creates the line object to exclude whitespace before the line start
    use("kana/vim-textobj-user") -- Enables the creation of new objects

    use(
      {
        "neovim/nvim-lspconfig",
        run = [[ npm install -g \
    @angular/language-server \
    @angular/language-service \
    bash-language-server \
    dockerfile-language-server-nodejs \
    graphql \
    graphql-language-service-cli \
    tslib \
    typescript-language-server \
    vim-language-server \
    vls \
    vscode-langservers-extracted \
    vue-language-server \
    yaml-language-server

    brew install \
    terraform-ls \
    lua-language-server
    ]]
      }
    ) -- LSP
    use("mfussenegger/nvim-jdtls")
    use("b0o/schemastore.nvim")

    use("github/copilot.vim")

    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("ray-x/cmp-treesitter")
    use("hrsh7th/cmp-nvim-lua")
    use("andersevenrud/cmp-tmux")
    use("saadparwaiz1/cmp_luasnip")
    use("f3fora/cmp-spell")
    use("hrsh7th/cmp-calc")
    use("hrsh7th/cmp-emoji")
    use("dmitmel/cmp-cmdline-history")
    use(
      {
        "L3MON4D3/LuaSnip",
        after = "nvim-cmp",
        config = function()
          require("snippets")
        end
      }
    )

    use(
      {
        "mhartington/formatter.nvim",
        config = function()
          local function prettier()
            return {
              exe = "prettier",
              args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
              stdin = true
            }
          end

          require("formatter").setup(
            {
              filetype = {
                javascript = {prettier},
                typescript = {prettier},
                typescriptreact = {prettier},
                vue = {prettier},
                json = {prettier},
                markdown = {prettier},
                html = {prettier},
                yaml = {prettier},
                lua = {
                  function()
                    return {exe = "luafmt", args = {"--indent-count", 2, "--stdin"}, stdin = true}
                  end
                },
                terraform = {
                  function()
                    return {exe = "terraform", args = {"fmt", "-"}, stdin = true}
                  end
                },
                sh = {
                  function()
                    return {exe = "shfmt", args = {"-i", 2}, stdin = true}
                  end
                },
                go = {
                  function()
                    return {exe = "gofmt", stdin = true}
                  end
                },
                java = {
                  function()
                    return {exe = "google-java-format", args = {"-"}, stdin = true}
                  end
                }
              }
            }
          )

          vim.cmd("nnoremap <silent> <leader>f :Format<CR>")
        end,
        run = [[
        brew install shfmt google-java-format
        npm install -g prettier lua-fmt
      ]]
      }
    )

    -- HTML / JSX
    use("mattn/emmet-vim") -- Autocompletion for html

    -- HIGHLIGHTING
    use(
      {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
          require("nvim-treesitter.configs").setup(
            {
              ensure_installed = "all",
              highlight = {
                enable = true -- false will disable the whole extension
              },
              incremental_selection = {enable = true},
              textobjects = {enable = true},
              refactor = {
                highlight_definitions = {enable = true},
                highlight_current_scope = {enable = false}
              }
            }
          )

          require("nvim-ts-autotag").setup()
        end
      }
    ) -- Update the parsers
    use("windwp/nvim-ts-autotag") -- Autoclose and autorename html tag
    use("nvim-treesitter/nvim-treesitter-refactor")
    use("romgrk/nvim-treesitter-context")

    -- FUZZY SEARCH
    use("nvim-lua/popup.nvim")
    use(
      {
        "nvim-telescope/telescope.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        run = [[ brew install ripgrep ]]
      }
    )

    -- THEME AND STATUSLINE
    use(
      {
        "morhetz/gruvbox",
        config = function()
          vim.cmd("autocmd vimenter * ++nested colorscheme gruvbox")
        end
      }
    ) -- Gruvbox theme for vim
    use(
      {
        "nvim-lualine/lualine.nvim",
        extensions = {"quickfix", "fugitive"},
        config = function()
        end
      }
    )
    -- use("edkolev/tmuxline.vim") -- Makes tmux status line match vim status line

    -- GIT PLUGINS
    use(
      {
        "lewis6991/gitsigns.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        config = function()
          require("gitsigns").setup(
            {
              signs = {
                delete = {show_count = true},
                topdelete = {show_count = true},
                changedelete = {show_count = true}
              },
              on_attach = function(bufnr)
                local function map(mode, lhs, rhs, opts)
                  opts = vim.tbl_extend("force", {noremap = true, silent = true}, opts or {})
                  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
                end

                -- Navigation
                map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr = true})
                map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr = true})

                -- Actions
                map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
                map("v", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
                map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
                map("v", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
                map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")
                map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>")
                map("n", "<leader>hb", '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')

                -- Text object
                map("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
                map("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")
              end
            }
          )
        end
      }
    )
    use("tpope/vim-fugitive") -- Git wrapper

    use(
      {
        "airblade/vim-rooter",
        config = function()
          vim.g.rooter_patterns = {".git"}
        end
      }
    )
    use("kyazdani42/nvim-web-devicons")
  end
)
