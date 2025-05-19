-- This file defines server-specific configuration options for gopls,
-- the official Language Server for the Go programming language.

return {
  -- LSP client flags specific to gopls.
  flags = {
    -- If true, the server will send incremental text updates instead of the full document content.
    -- This can improve performance for large files.
    allow_incremental_sync = true,
    -- Debounces text change notifications sent to the server to the specified milliseconds.
    -- This prevents overwhelming the server with updates during rapid typing.
    debounce_text_changes = 500,
  },

  -- Client capabilities sent to the gopls server, indicating features supported by Neovim's LSP client.
  capabilities = {
    -- Capabilities related to text document features.
    textDocument = {
      -- Capabilities related to autocompletion.
      completion = {
        -- Indicates that the client supports receiving completion context information.
        contextSupport = true,
        -- Indicates that the server can dynamically register and unregister completion capabilities.
        dynamicRegistration = true,
        -- Specific capabilities for completion items.
        completionItem = {
          -- Client supports commit characters for completion items.
          commitCharactersSupport = true,
          -- Client supports marking completion items as deprecated.
          deprecatedSupport = true,
          -- Client supports preselecting a completion item.
          preselectSupport = true,
          -- Client supports insert/replace edit behavior for completion items.
          insertReplaceSupport = true,
          -- Client supports additional label details for completion items.
          labelDetailsSupport = true,
          -- Client supports snippet format for completion items.
          snippetSupport = true,
          -- Supported formats for documentation in completion items.
          documentationFormat = { "markdown", "plaintext" },
          -- Client supports resolving additional information for completion items.
          resolveSupport = {
            -- Properties that the client can resolve for completion items.
            properties = {
              "documentation",
              "details",
              "additionalTextEdits",
            },
          },
        },
      },
    },
  },

  -- Custom 'on_init' function that is called when the gopls server initializes
  -- for a new project or workspace.
  on_init = function(client, _)
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
