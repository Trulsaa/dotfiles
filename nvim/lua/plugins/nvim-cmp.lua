local function config()
  vim.opt.completeopt = { "menu", "menuone", "noselect" }

  local cmp = require("cmp")

  cmp.setup({
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
    }),
    performance = { max_view_entries = 10 },
    sources = cmp.config.sources({
      { name = "calc" },
      { name = "luasnip" },
      { name = "copilot" },
      { name = "nvim_lua" },
      { name = "nvim_lsp" },
    }, {
      { name = "treesitter" },
      { name = "tmux" },
      { name = "buffer", keyword_length = 5 },
    }),
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    performance = { max_view_entries = 10 },
    sources = {
      { name = "path" },
      { name = "cmdline_history" },
      { name = "cmdline" },
    },
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    performance = { max_view_entries = 10 },
    sources = {
      { name = "buffer" },
      { name = "cmdline_history" },
    },
  })

  cmp.setup.cmdline("?", {
    mapping = cmp.mapping.preset.cmdline(),
    performance = { max_view_entries = 10 },
    sources = {
      { name = "buffer" },
      { name = "cmdline_history" },
    },
  })
end

return {
  {
    "hrsh7th/nvim-cmp",
    config = config,
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
  "dmitmel/cmp-cmdline-history",
}
