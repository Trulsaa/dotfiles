return {
  "huggingface/llm.nvim",
  opts = {
    backend = "ollama",
    model = "codellama:7b",
    url = "http://localhost:11434/api/generate",
    request_body = {
      -- Modelfile options for the model you use
      options = {
        temperature = 0.2,
        top_p = 0.95,
      },
    }, -- cf Setup
    tokens_to_clear = { "<EOT>" },
    fim = {
      enabled = true,
      prefix = "<PRE> ",
      middle = " <MID>",
      suffix = " <SUF>",
    },

    --[[
    backend = "ollama",
    tokens_to_clear = { "<EOT>" },
    fim = {
      enabled = true,
      prefix = "<PRE> ",
      middle = " <MID>",
      suffix = " <SUF>",
    },
    model = "codellama/CodeLlama:7b",
    context_window = 4096,
    tokenizer = {
      repository = "codellama/CodeLlama-13b-hf",
    },
    ]]

    --[[ backend = "tgi",
    tokens_to_clear = { "<|endoftext|>" },
    fim = {
      enabled = true,
      prefix = "<fim_prefix>",
      middle = "<fim_middle>",
      suffix = "<fim_suffix>",
    },
    model = "bigcode/starcoder",
    context_window = 8192,
    tokenizer = {
      repository = "bigcode/starcoder",
    }, ]]

    enable_suggestions_on_startup = false,
    enable_suggestions_on_files = {
      "*.ts",
      "*.js",
      "*.go",
      "*.kt",
      "*.java",
    },
  },
}
