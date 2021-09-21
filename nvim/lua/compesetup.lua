require("compe").setup({
  enabled = true,
  source = {
    path = true,
    buffer = true,
    nvim_lsp = true,
    nvim_lua = true,
    ultisnips = true,
  },
})
vim.o.completeopt = "menuone,noselect"
