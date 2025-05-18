-- This file defines server-specific configuration options for gopls,
-- the official Language Server for the Go programming language.

-- Imports NvChad's default 'on_init' function for LSP servers.
local nvlsp = require "nvchad.configs.lspconfig"

return {
  -- Custom 'on_init' function that is called when the gopls server initializes
  -- for a new project or workspace.
  on_init = function(client, bufnr)
    -- Calls NvChad's default 'on_init' behavior first.
    nvlsp.on_init(client, bufnr)
    -- Explicitly disables gopls' document formatting capabilities.
    -- This is useful if you prefer to use a different, dedicated Go formatter
    -- (e.g., conform.nvim with gofumpt/goimports-reviser) and want to prevent
    -- gopls from offering or performing formatting.
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,

  -- The 'settings' field is where language server specific preferences are defined.
  -- For gopls, these settings are nested under a 'gopls' key.
  settings = {
    gopls = {
      -- Enables specific static analyses.
      analyses = {
        -- If true, gopls will report unused function parameters.
        unusedparams = true,
      },

      -- Configuration for CodeLens, which provides actionable contextual information interspersed with code.
      codelenses = {
        generate = true, -- Enables 'go generate' CodeLens.
        gc_details = true, -- Enables CodeLens for displaying garbage collection details.
        test = true, -- Enables CodeLens for running tests.
        tidy = true, -- Enables 'go mod tidy' CodeLens.
        vendor = true, -- Enables 'go mod vendor' CodeLens.
        regenerate_cgo = true, -- Enables CodeLens for regenerating Cgo.
        upgrade_dependency = true, -- Enables CodeLens for upgrading dependencies.
      },

      -- Enables semantic token highlighting, providing more granular syntax highlighting based on LSP information.
      semanticTokens = true,
      -- Specifies the matching strategy for symbols (e.g., for workspace symbols, go to definition).
      -- "Fuzzy" allows for approximate matching.
      symbolMatcher = "Fuzzy",
      -- Specifies build flags to be used by gopls for operations like 'go build'.
      -- Example: enabling "integration" build tags.
      buildFlags = { "-tags", "integration" },
      -- Allows disabling specific semantic token types if they conflict or are not desired.
      -- Here, it seems to intend to disable a specific string-related semantic token, though the exact type might vary.
      semanticTokenTypes = { string = false }, -- This might need adjustment based on actual token type names.
      -- If true, enables integration with staticcheck, a comprehensive static analysis tool for Go.
      staticcheck = true,
      -- If true, gopls will use gofumpt (a stricter variant of gofmt) for formatting if it provides formatting.
      -- Note: This is relevant if documentFormattingProvider was true. Since it's false,
      -- this setting might influence other gopls behaviors or code actions that involve formatting snippets.
      gofumpt = true,
      -- If true, enables completion for unimported packages. When an unimported package is completed,
      -- gopls will automatically add the necessary import statement.
      completeUnimported = true,
      -- If true, uses placeholders for function parameters when completing a function call,
      -- which can then be navigated and filled using snippets.
      usePlaceholders = true,
    },
  },
}
