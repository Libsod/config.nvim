local on_attach = require("configs.lsp.lspconfig").on_attach
local on_init = require("configs.lsp.lspconfig").on_init
local capabilities = require("configs.lsp.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- File-based lsp configs
require "configs.lsp.server_configs.clangd"
require "configs.lsp.server_configs.ruff_lsp"
require "configs.lsp.server_configs.zls"

local servers = {
  -- Shell
  "bashls",

  -- Low-level
  "asm_lsp",

  -- Web
  "html",
  "cssls",
  "tailwindcss",
  "eslint",
  "astro",

  -- Markdown
  "marksman",
  "textlsp",

  -- LaTeX
  "texlab",

  -- Markup langs
  "jsonls",
  "yamlls",
  "taplo",
  "lemminx",

  -- Docker
  "docker_compose_language_service",
  "dockerls",

  -- Sql
  "sqls",

  -- Odin
  "ols",

  -- Java
  "jdtls",

  -- GLSL
  "glsl_analyzer",

  -- Gleam
  "gleam",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.pyright.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
  },
}

lspconfig.gopls.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    on_attach(client, bufnr)
  end,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
      completeUnimported = true,
      usePlaceholders = true,
    },
  },
}

lspconfig.neocmake.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "neocmakelsp", "--stdio" },
  root_dir = function(fname)
    return lspconfig.util.find_git_ancestor(fname)
  end,
  single_file_support = true, -- suggested
  init_options = {
    format = {
      enable = true,
    },
    scan_cmake_in_package = true, -- default is true
  },
}
