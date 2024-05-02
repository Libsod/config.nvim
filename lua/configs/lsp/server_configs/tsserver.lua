local on_attach = require("configs.lsp.lspconfig").on_attach
local on_init = require("configs.lsp.lspconfig").tsserver_on_init
local capabilities = require("configs.lsp.lspconfig").capabilities

local lspconfig = require "lspconfig"

local TSOrganizeImports = function()
  vim.lsp.buf.code_action {
    apply = true,
    context = {
      only = { "source.organizeImports" },
      diagnostics = {},
    },
  }
end
local TSRemoveUnused = function()
  vim.lsp.buf.code_action {
    apply = true,
    context = {
      only = { "source.removeUnused" },
      diagnostics = {},
    },
  }
end
local TSRemoveUnusedImports = function()
  vim.lsp.buf.code_action {
    apply = true,
    context = {
      only = { "source.removeUnusedImports" },
      diagnostics = {},
    },
  }
end
local TSSortImports = function()
  vim.lsp.buf.code_action {
    apply = true,
    context = {
      only = { "source.organizeImports" },
      diagnostics = {},
    },
  }
end
local TSAddMissingImports = function()
  vim.lsp.buf.code_action {
    apply = true,
    context = {
      only = { "source.addMissingImports" },
      diagnostics = {},
    },
  }
end
local TSFixAll = function()
  vim.lsp.buf.code_action {
    apply = true,
    context = {
      only = { "source.fixAll" },
      diagnostics = {},
    },
  }
end

lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  commands = {
    TSOrganizeImports = {
      TSOrganizeImports,
      description = "Organize Imports",
    },
    TSRemoveUnused = {
      TSRemoveUnused,
      description = "Remove unused",
    },
    TSFixAll = {
      TSFixAll,
      description = "Fix all",
    },
    TSSortImports = {
      TSSortImports,
      description = "Organize imports",
    },
    TSRemoveUnusedImports = {
      TSRemoveUnusedImports,
      description = "Remove Unused Imports",
    },
    TSAddMissingImports = {
      TSAddMissingImports,
      description = "Add Missing Imports",
    },
  },
  completions = {
    completeFunctionCalls = true,
  },
  init_options = {
    preferences = {
      includeInlayEnumMemberValueHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayVariableTypeHints = true,
    },
  },
}
