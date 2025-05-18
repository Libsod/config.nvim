-- This file defines server-specific configuration options for clangd,
-- the Language Server for C, C++, and Objective-C.

-- Imports NvChad's default 'on_init' function for LSP servers.
local nvlsp = require "nvchad.configs.lspconfig"

-- Returns a table containing the configuration settings for clangd.
-- This table is typically merged with common LSP settings and nvim-lspconfig defaults
-- when setting up the clangd LSP server.
return {
  -- Custom 'on_init' function that is called when the clangd server initializes
  -- for a new project or workspace.
  on_init = function(client, bufnr)
    -- Calls NvChad's default 'on_init' behavior first.
    nvlsp.on_init(client, bufnr)
    -- Explicitly disables clangd's document formatting capabilities.
    -- This is useful if you prefer to use a different, dedicated formatter (e.g., conform.nvim with clang-format)
    -- and want to prevent clangd from offering or performing formatting.
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,

  -- Defines the command and arguments used to start the clangd language server.
  cmd = {
    "clangd", -- The clangd executable.
    "-j=10", -- Number of worker threads for clangd (e.g., for indexing).
    "--enable-config", -- Enables reading of project-specific .clangd configuration files.
    "--background-index", -- Enables clangd to build or update its index in the background.
    "--pch-storage=memory", -- Stores precompiled headers (PCH) in memory for faster access.
    "--query-driver=clang++,clang", -- Helps clangd find compiler flags by querying drivers like clang++ and clang.
    "--clang-tidy", -- Enables integration with clang-tidy for static analysis and linting.
    "--all-scopes-completion", -- Provides completion suggestions from all available scopes.
    "--completion-style=detailed", -- Offers more detailed information in completion suggestions.
    "--header-insertion-decorators", -- Shows decorators or hints for header insertion actions.
    "--header-insertion=iwyu", -- Uses "Include What You Use" (IWYU) logic for header insertion suggestions.
    "--limit-references=3000", -- Limits the number of references returned by "find references" to improve performance.
    "--limit-results=350", -- Limits the number of results for some queries to improve performance.
  },
}
