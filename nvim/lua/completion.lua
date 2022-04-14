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
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
      ["<C-e>"] = cmp.mapping(
        {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close()
        }
      ),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm({select = true})
    },
    sources = cmp.config.sources(
      {
        {name = "calc"},
        {name = "luasnip"},
        {name = "nvim_lua"},
        {name = "nvim_lsp"},
        {name = "cmp_tabnine"}
      },
      {
        {name = "treesitter"},
        {name = "tmux"},
        {name = "buffer", keyword_length = 5}
      }
    ),
    experimental = {
      ghost_text = true
    }
  }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  ":",
  {
    sources = cmp.config.sources(
      {
        {name = "path"},
        {name = "cmdline_history", max_item_count = 20}
      },
      {
        {name = "cmdline"}
      }
    )
  }
)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  "/",
  {
    sources = {
      {name = "buffer"},
      {name = "cmdline_history", max_item_count = 20}
    }
  }
)

cmp.setup.cmdline(
  "?",
  {
    sources = {
      {name = "buffer"},
      {name = "cmdline_history", max_item_count = 20}
    }
  }
)
