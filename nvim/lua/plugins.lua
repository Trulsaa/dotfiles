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
        "Pocco81/auto-save.nvim",
        config = function()
          require("auto-save").setup(
            {
              enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
              execution_message = {
                message = function()
                  -- message to print on save
                  return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
                end,
                dim = 0.18, -- dim the color of `message`
                cleaning_interval = 1250 -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
              },
              trigger_events = {"InsertLeave", "TextChanged"}, -- vim events that trigger auto-save. See :h events
              -- function that determines whether to save the current buffer or not
              -- return true: if buffer is ok to be saved
              -- return false: if it's not ok to be saved
              condition = function(buf)
                local utils = require("auto-save.utils.data")

                if
                  vim.fn.getbufvar(buf, "&modifiable") == 1 and
                    utils.not_in(vim.fn.getbufvar(buf, "&filetype"), {"TelescopePrompt"})
                 then
                  return true -- met condition(s), can save
                end
                return false -- can't save
              end,
              write_all_buffers = false, -- write all buffers when the current one meets `condition`
              debounce_delay = 135, -- saves the file at most every `debounce_delay` milliseconds
              callbacks = {
                -- functions to be executed at different intervals
                enabling = nil, -- ran when enabling auto-save
                disabling = nil, -- ran when disabling auto-save
                before_asserting_save = nil, -- ran before checking `condition`
                before_saving = nil, -- ran before doing the actual save
                after_saving = nil -- ran after doing the actual save
              }
            }
          )
        end
      }
    )
    use("ntpeters/vim-better-whitespace") -- Highlight trailing whitespace in red
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
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "VimEnter",
        config = function()
          vim.defer_fn(
            function()
              require("copilot").setup(
                {
                  suggestion = {enabled = false},
                  panel = {enabled = false}
                }
              )
            end,
            100
          )
        end
      }
    )
    use {
      "zbirenbaum/copilot-cmp",
      after = {"copilot.lua"},
      config = function()
        require("copilot_cmp").setup()
      end
    }

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
                javascriptreact = {prettier},
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
          -- make highlight_definitions react after 500 ms not 4000 ms (default)
          vim.o.updatetime = 500

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
        branch = "0.1.x",
        requires = {"nvim-lua/plenary.nvim"},
        run = [[ brew install ripgrep ]]
      }
    )
    use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
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
              buffer = 0, -- current buffer has buffer number 0
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
        "ellisonleao/gruvbox.nvim",
        config = function()
          vim.o.background = "dark" -- or "light" for light mode
          vim.cmd([[colorscheme gruvbox]])
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
              theme = "gruvbox"
            }
          }
        end
      }
    )
    use("edkolev/tmuxline.vim") -- Makes tmux status line match vim status line

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
                map({"n", "v"}, "<leader>hs", ":Gitsigns stage_hunk<CR>")
                map({"n", "v"}, "<leader>hr", ":Gitsigns reset_hunk<CR>")
                map("n", "<leader>hS", gs.stage_buffer)
                map("n", "<leader>hu", gs.undo_stage_hunk)
                map("n", "<leader>hR", gs.reset_buffer)
                map("n", "<leader>hp", gs.preview_hunk)
                map(
                  "n",
                  "<leader>hb",
                  function()
                    gs.blame_line {full = true}
                  end
                )

                -- Text object
                map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
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

    use(
      {
        "epwalsh/obsidian.nvim",
        config = function()
          require("obsidian").setup(
            {
              dir = "/Users/t/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notater",
              daily_notes = {
                folder = "Daily"
              },
              completion = {
                nvim_cmp = true -- if using nvim-cmp, otherwise set to false
              }
            }
          )
        end
      }
    )

    use(
      {
        "dpayne/CodeGPT.nvim",
        requires = {"nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim"}
      }
    )

    use(
      {
        "jackMort/ChatGPT.nvim",
        config = function()
          require("chatgpt").setup()
        end,
        requires = {
          "MunifTanjim/nui.nvim",
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope.nvim"
        }
      }
    )
  end
)
