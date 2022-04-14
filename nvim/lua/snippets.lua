local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

local date_header = function()
  return os.date("# %A %Y-%m-%d")
end

ls.add_snippets(
  "markdown",
  {
    s(
      {
        trig = "date",
        namr = "Date",
        dscr = "Header date in the form of ## Weekday YYYY-MM-DD"
      },
      {
        f(date_header, {}),
        t({"", "", ""})
      }
    )
  }
)

require("luasnip.loaders.from_snipmate").lazy_load()

vim.cmd(
  [[
  imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : ''
  inoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
  imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'
  snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(1)<CR>
  snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
]]
)
