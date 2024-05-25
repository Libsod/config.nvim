local on_attach = require("configs.lsp.lspconfig").on_attach
local on_init = require("configs.lsp.lspconfig").ruff_lsp_on_init
local capabilities = require("configs.lsp.lspconfig").capabilities

local lspconfig = require "lspconfig"

lspconfig.ruff_lsp.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  init_options = {
    settings = {
      args = {
        "--select=E,F,UP,N,I,ASYNC,S,PTH",
        "--respect-gitignore",
        "--target-version=py312",
      },
    },
  },
}
