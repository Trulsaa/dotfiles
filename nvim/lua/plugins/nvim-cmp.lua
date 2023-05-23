local function config()
  vim.opt.completeopt = {"menu", "menuone", "noselect"}

  local cmp = require("cmp")

  cmp.setup(
    {
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end
      },
      mapping = {
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), {"i", "c"}),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), {"i", "c"}),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
        ["<C-e>"] = cmp.mapping(
          {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
          }
        ),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({select = false})
      },
      sources = cmp.config.sources(
        {
          {name = "calc"},
          {name = "luasnip"},
          {name = "copilot"},
          {name = "nvim_lua"},
          {name = "nvim_lsp"}
        },
        {
          {name = "treesitter"},
          {name = "tmux"},
          {name = "buffer", keyword_length = 5}
        }
      )
    }
  )

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(
    ":",
    {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        {name = "path", max_item_count = 5},
        {name = "cmdline_history", max_item_count = 5},
        {name = "cmdline", max_item_count = 5}
      }
    }
  )

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(
    "/",
    {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        {name = "buffer", max_item_count = 5},
        {name = "cmdline_history", max_item_count = 5}
      }
    }
  )

  cmp.setup.cmdline(
    "?",
    {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        {name = "buffer", max_item_count = 5},
        {name = "cmdline_history", max_item_count = 5}
      }
    }
  )
end

return {
  {
    "hrsh7th/nvim-cmp",
    config = config
  },
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "ray-x/cmp-treesitter",
  "hrsh7th/cmp-nvim-lua",
  "andersevenrud/cmp-tmux",
  "saadparwaiz1/cmp_luasnip",
  "f3fora/cmp-spell",
  "hrsh7th/cmp-calc",
  "hrsh7th/cmp-emoji",
  "dmitmel/cmp-cmdline-history"
}
