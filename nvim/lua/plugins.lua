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

          vim.keymap.set("n", "<leader>f", ":Format<CR>", {silent = true})
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
    use(
      {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
          require("telescope").setup {
            extensions = {
              ["ui-select"] = {
                require("telescope.themes").get_cursor {}
              }
            }
          }
          require("telescope").load_extension("ui-select")
        end
      }
    )

    use(
      {
        "mfussenegger/nvim-lint",
        config = function()
          local nvim_lint = require("lint")
          nvim_lint.linters_by_ft = {
            sh = {"shellcheck"},
            typescript = {"eslint_d"},
            lua = {"luacheck"}
          }
          local pattern = [[%s*(%d+):(%d+)%s+(%w+)%s+(.+%S)%s+(%S+)]]
          local groups = {"lnum", "col", "severity", "message", "code"}
          local severity_map = {
            ["error"] = vim.diagnostic.severity.ERROR,
            ["warn"] = vim.diagnostic.severity.WARN,
            ["warning"] = vim.diagnostic.severity.WARN
          }

          nvim_lint.linters.eslint_d = {
            cmd = "eslint_d",
            args = {},
            stdin = false,
            stream = "stdout",
            ignore_exitcode = true,
            parser = require("lint.parser").from_pattern(pattern, groups, severity_map, {["source"] = "eslint_d"})
          }

          vim.api.nvim_create_autocmd(
            "BufWritePost",
            {
              pattern = "*",
              desc = "Lint on save",
              callback = nvim_lint.try_lint
            }
          )
        end,
        run = [[
          luarocks install luacheck

          npm install -g \
          eslint \
          eslint_d

          brew install shellcheck
        ]]
      }
    )

    -- THEME AND STATUSLINE
    use(
      {
        "luisiacc/gruvbox-baby",
        branch = "main",
        config = function()
          vim.cmd([[colorscheme gruvbox-baby]])
        end
      }
    ) -- Gruvbox theme for vim
    use(
      {
        "nvim-lualine/lualine.nvim",
        extensions = {"quickfix", "fugitive"},
        config = function()
          require("lualine").setup {
            options = {
              theme = "gruvbox-baby"
            }
          }
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
                local function map(mode, l, r, opts)
                  opts = opts or {}
                  opts.buffer = bufnr
                  vim.keymap.set(mode, l, r, opts)
                end

                local gs = package.loaded.gitsigns

                -- Navigation
                map(
                  "n",
                  "]c",
                  function()
                    if vim.wo.diff then
                      return "]c"
                    end
                    vim.schedule(
                      function()
                        gs.next_hunk()
                      end
                    )
                    return "<Ignore>"
                  end,
                  {expr = true}
                )

                map(
                  "n",
                  "[c",
                  function()
                    if vim.wo.diff then
                      return "[c"
                    end
                    vim.schedule(
                      function()
                        gs.prev_hunk()
                      end
                    )
                    return "<Ignore>"
                  end,
                  {expr = true}
                )

                -- Actions
                map({"n", "v"}, "<leader>hs", gs.stage_hunk)
                map({"n", "v"}, "<leader>hr", gs.reset_hunk)
                map("n", "<leader>hu", gs.undo_stage_hunk)
                map("n", "<leader>hp", gs.preview_hunk)
                map(
                  "n",
                  "<leader>hb",
                  function()
                    gs.blame_line({full = true})
                  end
                )

                -- Text object
                map({"o", "x"}, "ih", gs.select_hunk)
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
