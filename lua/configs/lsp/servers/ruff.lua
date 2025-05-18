-- This file defines server-specific configuration options for ruff_lsp (or ruff when acting as an LSP),
-- a very fast Python linter and formatter.

-- Imports NvChad's default 'on_init' function for LSP servers.
local nvlsp = require "nvchad.configs.lspconfig"

-- Returns a table containing the configuration settings for the ruff LSP server.
-- This table is typically merged with common LSP settings and nvim-lspconfig defaults.
return {
  -- Custom 'on_init' function called when the ruff LSP server initializes.
  on_init = function(client, bufnr)
    -- Calls NvChad's default 'on_init' behavior first.
    nvlsp.on_init(client, bufnr)
    -- Explicitly disables ruff's hover provider capability.
    -- This is useful if you prefer hover information to come from another Python LSP (like basedpyright)
    -- and want to avoid potentially conflicting or redundant hover details from ruff.
    -- Ruff primarily focuses on linting and formatting, so its hover information might be less comprehensive.
    client.server_capabilities.hoverProvider = false
  end,

  -- Options passed to the language server during its initialization.
  init_options = {
    settings = {
      -- Arguments passed to the ruff executable when it's run by the LSP.
      -- These control which linting rules are enabled, how ruff interacts with version control,
      -- and the target Python version.
      args = {
        "--select=E,F,UP,N,I,ASYNC,S,PTH", -- Selects specific sets of linting rules:
        -- E: Pycodestyle errors
        -- F: Pyflakes errors
        -- UP: Pyupgrade suggestions
        -- N: Naming conventions (pep8-naming)
        -- I: Isort (import sorting)
        -- ASYNC: Async-related lints (flake8-async)
        -- S: Security lints (flake8-bandit)
        -- PTH: Pathlib-related lints (flake8-pathlib)
        "--respect-gitignore", -- Makes ruff respect rules defined in .gitignore files.
        "--target-version=py313", -- Tells ruff to assume Python 3.13 syntax and features for its checks.
        "--fix", -- Could be added to enable auto-fixing of lint issues if desired.
      },
    },
  },
}
