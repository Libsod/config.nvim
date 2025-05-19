local M = {}

-- Imports NvChad's default LSP configuration, likely for base capabilities and on_init.
local nvlsp = require "nvchad.configs.lspconfig"
-- Imports custom utility functions, possibly including hover options.
local utils = require "core.utils"
-- Shorthands for Neovim API functions.
local map = vim.keymap.set
local del = vim.keymap.del

-- The primary on_attach function called when an LSP client attaches to a buffer.
-- It sets up buffer-local keymappings for LSP functionalities.
-- @param client (object) The LSP client object.
-- @param bufnr (integer) The buffer number the client attached to.
M.on_attach = function(client, bufnr)
  -- Calls NvChad's default on_attach first to set up its standard LSP features and mappings.
  nvlsp.on_attach(client, bufnr)

  -- Helper function to create options for buffer-local keymappings.
  -- @param desc (string) Description for the keymapping.
  -- @return (table) Options table for vim.keymap.set.
  local function opts(desc)
    return { buffer = bufnr, desc = desc, noremap = true, silent = true }
  end

  -- Custom keymapping for LSP hover, using custom hover options from 'core.utils'.
  map("n", "K", function()
    vim.lsp.buf.hover(utils.hover_opts())
  end, opts "LSP hover documentation")

  -- Deletes NvChad's default rename mapping to replace it with a custom one or different plugin.
  del("n", "<leader>ra", { buffer = bufnr })
  -- Custom mapping for renaming symbols using NvChad's renamer UI.
  map("n", "<leader>lr", function()
    require "nvchad.lsp.renamer"() -- Assumes this is NvChad's renamer function
  end, opts "LSP rename symbol (NvChad Renamer)")

  -- Mapping for LSP code actions in normal and visual modes.
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "LSP code action")

  -- Defines mappings for 'glance.nvim' plugin for LSP navigation.
  local glance_actions = {
    definitions = "gd", -- Go to definition.
    references = "gr", -- Find references.
    type_definitions = "gy", -- Go to type definition.
    implementations = "gi", -- Go to implementation.
  }
  -- Creates keymappings for each glance action.
  for cmd_name, key in pairs(glance_actions) do
    map(
      "n",
      key,
      "<cmd>Glance " .. cmd_name .. "<cr>",
      { buffer = bufnr, silent = true, desc = "LSP glance " .. cmd_name }
    )
  end

  -- Conditionally attaches 'lsp_signature.nvim' if not running in a VSCode embedded Neovim instance.
  if not vim.g.vscode then
    local signature_ok, signature = pcall(require, "lsp_signature")
    if signature_ok then
      -- Assumes 'configs.lsp.plugins.lsp-signature' returns a module with a 'cfg' table.
      local sig_cfg_ok, sig_cfg_module = pcall(require, "configs.lsp.plugins.lsp-signature")
      if sig_cfg_ok and sig_cfg_module and sig_cfg_module.cfg then
        signature.on_attach(sig_cfg_module.cfg, bufnr)
      else
        -- Fallback or default config if custom one not found
        signature.on_attach({ bind = true, handler_opts = { border = "single" } }, bufnr)
      end
    end
  end
end

-- Sets up default global configurations for Neovim's diagnostics system.
M.defaults = function()
  -- Calls NvChad's default LSP setup, which might include diagnostic configurations.
  nvlsp.defaults()

  -- Customizes the appearance and behavior of diagnostics.
  vim.diagnostic.config {
    virtual_text = false, -- Disables displaying diagnostics as virtual text inline with code.
    update_in_insert = false, -- Prevents diagnostics from updating while in insert mode.
    underline = true, -- Underlines text with diagnostics.
    severity_sort = true, -- Sorts diagnostics by severity in lists like Trouble.
    float = { -- Configuration for the floating window that shows diagnostic details.
      border = "single", -- Uses a single border.
      style = "minimal", -- Uses a minimal style (less chrome).
      focusable = true, -- Allows the floating window to be focused.
      -- Events that will close the diagnostic floating window.
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      source = true, -- Shows the source of the diagnostic (e.g., "eslint", "rust_analyzer").
      header = "", -- No custom header for the float.
      prefix = "", -- No custom prefix for diagnostic messages in the float.
      scope = "cursor", -- Shows diagnostics in float only for the one under the cursor.
    },
  }
end

return M
