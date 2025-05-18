-- This file defines server-specific configuration options for zls,
-- the Language Server for the Zig programming language.

-- Imports NvChad's default 'on_init' function for LSP servers.
local nvlsp = require "nvchad.configs.lspconfig"

-- Returns a table containing the configuration settings for the zls LSP server.
-- This table is typically merged with common LSP settings and nvim-lspconfig defaults.
return {
  -- Custom 'on_init' function that is called when the zls server initializes
  -- for a new project or workspace.
  on_init = function(client, bufnr)
    -- Calls NvChad's default 'on_init' behavior first.
    nvlsp.on_init(client, bufnr)

    -- Sets a global variable related to Zig's formatting.
    -- `zig_fmt_parse_errors` being set to 0 indicate a preference to not show parse errors from the formatter
    vim.g.zig_fmt_parse_errors = 0
  end,
}
