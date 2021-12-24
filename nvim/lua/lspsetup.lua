local nvim_lsp = require("lspconfig")
local nvim_cmp_capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Set color for error message
vim.cmd("hi LspDiagnosticsDefaultError ctermfg=Red")

local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")

local function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

local function table_to_string(tbl)
  local result = "{"
  for k, v in pairs(tbl) do
    -- Check the key type (ignore any numerical keys - assume its an array)
    if type(k) == "string" then
      result = result .. '["' .. k .. '"]' .. "="
    end

    -- Check the value type
    if type(v) == "table" then
      result = result .. table_to_string(v)
    elseif type(v) == "boolean" then
      result = result .. tostring(v)
    else
      result = result .. '"' .. v .. '"'
    end
    result = result .. ","
  end
  -- Remove leading commas from the result
  if result ~= "" then
    result = result:sub(1, result:len() - 1)
  end
  return result .. "}"
end

_G.references = function(opts)
  local params = vim.lsp.util.make_position_params()
  params.context = { includeDeclaration = true }

  local results_lsp, err = vim.lsp.buf_request_sync(0, "textDocument/references", params, opts.timeout or 10000)
  if err then
    vim.api.nvim_err_writeln("Error when finding references: " .. err)
    return
  end

  local concatinated_results = {}
  for _, server_results in pairs(results_lsp) do
    if server_results.result then
      vim.list_extend(concatinated_results, server_results.result or {})
    end
  end

  local unique_results = {}
  for _, result in pairs(concatinated_results) do
    unique_results[table_to_string(result)] = result
  end

  local indexed_results = {}
  local index = 1
  for _, result in pairs(unique_results) do
    indexed_results[index] = result
    index = index + 1
  end

  local locations = vim.lsp.util.locations_to_items(indexed_results)

  if vim.tbl_isempty(locations) then
    return
  end

  pickers.new(opts, {
    prompt_title = "LSP References",
    finder = finders.new_table({
      results = locations,
      entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts),
    }),
    previewer = conf.qflist_previewer(opts),
    sorter = conf.generic_sorter(opts),
  }):find()
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = {
    noremap = true,
    silent = true,
  }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua select_layout(require('telescope.builtin').lsp_definitions)<cr>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua select_layout(require('telescope.builtin').lsp_implementations)<cr>", opts)
  buf_set_keymap("n", "gR", "<cmd>lua select_layout(references)<cr>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  -- buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap(
    "n",
    "<space>A",
    "<cmd>lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor())<cr>",
    opts
  )
  buf_set_keymap(
    "v",
    "<space>A",
    "<cmd>lua require('telescope.builtin').lsp_range_code_actions(require('telescope.themes').get_cursor())<cr>",
    opts
  )
  buf_set_keymap(
    "n",
    "<space>s",
    "<cmd>lua select_layout(require('telescope.builtin').lsp_workspace_symbols)<cr>",
    opts
  )
  buf_set_keymap("n", "<space>E", "<cmd>lua select_layout(require('telescope.builtin').diagnostics)<cr>", opts)
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
end

local project_library_path = "/usr/local/lib/node_modules"
local cmd = {
  "ngserver",
  "--stdio",
  "--tsProbeLocations",
  project_library_path,
  "--ngProbeLocations",
  project_library_path,
}
nvim_lsp.angularls.setup({
  on_attach = on_attach,
  capabilities = nvim_cmp_capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  cmd = cmd,
  on_new_config = function(new_config)
    new_config.cmd = cmd
  end,
  filetypes = { "typescript", "html" },
})
nvim_lsp.jsonls.setup({
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
  capabilities = nvim_cmp_capabilities,
  on_attach = function(client, bufnr)
    -- Disable document_formatting from lsp
    client.resolved_capabilities.document_formatting = false
    on_attach(client, bufnr)
  end,
  flags = {
    debounce_text_changes = 150,
  },
})

_G.lsp_organize_imports = function()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

nvim_lsp.tsserver.setup({
  capabilities = nvim_cmp_capabilities,
  on_attach = function(client, bufnr)
    -- Disable document_formatting from lsp
    client.resolved_capabilities.document_formatting = false
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>i", "<cmd>lua lsp_organize_imports()<CR>", {
      noremap = true,
      silent = true,
    })
    on_attach(client, bufnr)
  end,
  flags = {
    debounce_text_changes = 150,
  },
})
nvim_lsp.vuels.setup({
  capabilities = nvim_cmp_capabilities,
  on_attach = function(client, bufnr)
    -- Disable document_formatting from lsp
    client.resolved_capabilities.document_formatting = false
    on_attach(client, bufnr)
  end,
  flags = {
    debounce_text_changes = 150,
  },
})
nvim_lsp.omnisharp.setup({
  capabilities = nvim_cmp_capabilities,
  on_attach = on_attach,
  cmd = {
    "/Users/t/bin/omnisharp-osx/run",
    "--languageserver",
    "--hostPID",
    tostring(vim.fn.getpid()),
  },
})

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require("lspconfig").sumneko_lua.setup({
  capabilities = nvim_cmp_capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

-- /Users/t/.cache/nvim/lspconfig/sumneko_lua/lua-language-server/bin/macOS/lua-language-server -E /Users/t/.cache/nvim/lspconfig/sumneko_lua/lua-language-server/main.lua
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  "vimls",
  "bashls",
  "dockerls",
  "gopls",
  "graphql",
  "html",
  "terraformls",
  "tflint",
  "jdtls",
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    capabilities = nvim_cmp_capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  })
end
