local on_attach = require("configs.lsp.lspconfig").on_attach
local on_init = require("configs.lsp.lspconfig").clangd_on_init
local capabilities = require("configs.lsp.lspconfig").capabilities

local lspconfig = require "lspconfig"

lspconfig.clangd.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "-j=10",
    "--enable-config",
    "--background-index",
    "--pch-storage=memory",
    "--query-driver=/usr/bin/clang++,/usr/bin/clang",
    "--clang-tidy",
    "--all-scopes-completion",
    "--completion-style=detailed",
    "--header-insertion-decorators",
    "--header-insertion=iwyu",
    "--limit-references=3000",
    "--limit-results=350",
  },
}
