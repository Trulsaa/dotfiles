local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")

local date_header = function()
  return os.date("## %A %Y-%m-%d")
end

ls.snippets = {
  markdown = {
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
}

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
