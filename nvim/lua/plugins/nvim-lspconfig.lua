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

local references = function(opts)
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

  for _, location in pairs(locations) do
    local newFileName = require("path").removeCwdFromPath(location.filename)
    location.filename = newFileName
  end

  local conf = require("telescope.config").values

  require("telescope.pickers")
    .new(opts, {
      prompt_title = "LSP References",
      finder = require("telescope.finders").new_table({
        results = locations,
        entry_maker = opts.entry_maker or require("telescope.make_entry").gen_from_quickfix(opts),
      }),
      previewer = conf.qflist_previewer(opts),
      sorter = conf.generic_sorter(opts),
    })
    :find()
end

local function config()
  local nvim_lsp = require("lspconfig")
  local nvim_cmp_capabilities =
    require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
  local select_layout = require("select_layout").select_layout

  -- Set color for error message
  vim.cmd("hi LspDiagnosticsDefaultError ctermfg=Red")

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(_, bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    map("n", "gD", vim.lsp.buf.declaration)
    map("n", "gd", select_layout(require("telescope.builtin").lsp_definitions))
    map("n", "K", vim.lsp.buf.hover)
    map("n", "gi", select_layout(require("telescope.builtin").lsp_implementations))
    map("n", "gR", select_layout(references))
    -- map("n", "<Leader>D", vim.lsp.buf.type_definition)
    map("n", "<Leader>rn", vim.lsp.buf.rename)
    map("n", "<Leader>A", vim.lsp.buf.code_action)
    map("v", "<Leader>A", vim.lsp.buf.code_action)
    map("n", "<Leader>s", select_layout(require("telescope.builtin").lsp_workspace_symbols))
    map("n", "<Leader>D", select_layout(require("telescope.builtin").diagnostics))
    map("n", "<Leader>d", vim.diagnostic.open_float)
    map("n", "[d", vim.diagnostic.goto_prev)
    map("n", "]d", vim.diagnostic.goto_next)
    map("n", "<Leader>q", vim.diagnostic.setloclist)
  end

  nvim_lsp.jsonls.setup({
    settings = {
      json = {
        validate = { enable = true },
        schemas = require("schemastore").json.schemas(),
      },
    },
    capabilities = nvim_cmp_capabilities,
    on_attach = function(client, bufnr)
      -- Disable document_formatting from lsplsp
      client.server_capabilities.document_formatting = false
      on_attach(client, bufnr)
    end,
    flags = {
      debounce_text_changes = 150,
    },
  })

  local lsp_organize_imports = function()
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
      client.server_capabilities.document_formatting = false
      vim.keymap.set("n", "<space>i", lsp_organize_imports, {
        silent = true,
        buffer = bufnr,
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
      client.server_capabilities.document_formatting = false
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
  require("lspconfig").lua_ls.setup({
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
          checkThirdParty = false,
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
    "docker_compose_language_service",
    "gopls",
    "html",
    "terraformls",
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
end

return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "b0o/schemastore.nvim",
    },
    config = config,
  },
} -- LSP
