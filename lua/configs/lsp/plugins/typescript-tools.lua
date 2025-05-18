-- This file defines configuration options for typescript-tools.nvim,
-- a plugin that enhances the TypeScript/JavaScript development experience in Neovim,
-- often working in conjunction with the tsserver LSP.

-- Imports the common 'on_attach' function from 'core.lsp' for LSP-related setups.
local lspcore = require "core.lsp"
-- Imports NvChad's default LSP configurations, likely for 'on_init' and 'capabilities'.
local nvlsp = require "nvchad.configs.lspconfig"

-- Main configuration table for typescript-tools.nvim.
local options = {
  -- Uses NvChad's 'on_init' function, which may perform actions when the LSP server initializes.
  on_init = nvlsp.on_init,
  -- Uses the common 'on_attach' function to set up keymappings and buffer-local settings
  -- when tsserver (or a related LSP) attaches to a buffer.
  on_attach = lspcore.on_attach,
  -- Uses NvChad's default LSP capabilities, informing the server about client features.
  capabilities = nvlsp.capabilities,

  -- Specific settings passed to the TypeScript language server (tsserver).
  settings = {
    -- Configures which TSTools actions are exposed as code actions.
    -- "all" means all available actions will be offered.
    expose_as_code_action = "all",
    -- Enables automatic completion of parentheses for function calls.
    complete_function_calls = true,
    -- Preferences for tsserver regarding file operations and editor features.
    tsserver_file_preferences = {
      -- Configures inlay hints for parameter names to be shown for "all" parameters.
      -- Other options might include "literals" or "none".
      includeInlayParameterNameHints = "all",
    },
    -- Specifies tsserver plugins to be loaded.
    -- These plugins can extend tsserver's functionality, for example, to understand
    -- specific libraries or frameworks.
    tsserver_plugins = {
      -- Example: Enables a plugin for better TypeScript support with styled-components.
      "@styled/typescript-styled-plugin",
    },
  },
}

return options
