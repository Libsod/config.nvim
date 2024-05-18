local on_attach = require("configs.lsp.lspconfig").on_attach
local on_init = require("configs.lsp.lspconfig").zls_on_init
local capabilities = require("configs.lsp.lspconfig").capabilities

local lspconfig = require "lspconfig"

lspconfig.zls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
