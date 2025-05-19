-- This file defines server-specific configuration options for lua_ls (lua-language-server),
-- the Language Server for the Lua programming language.

return {
  -- The 'settings' field is where language server specific preferences are defined.
  -- For lua_ls, these settings are nested under a 'Lua' key.
  settings = {
    Lua = {
      -- Configuration for the Lua runtime environment that lua_ls should assume.
      runtime = {
        -- Specifies that the target runtime is LuaJIT.
        -- Other options could include "Lua 5.1", "Lua 5.2", "Lua 5.3", "Lua 5.4".
        version = "LuaJIT",
      },
      -- Configuration for diagnostic checks performed by lua_ls.
      diagnostics = {
        -- A list of global variable names that should not be reported as undefined.
        -- Useful for Neovim's built-in 'vim' global.
        globals = { "vim" },
        -- A list of diagnostic codes to disable.
        -- "different-requires": Warns if a module is required with different casing (e.g., require("Module") and require("module")).
        -- "undefined-field": Warns about accessing a field that is not explicitly defined in a table's known structure.
        disable = { "different-requires", "undefined-field" },
      },
      -- Configuration for how lua_ls handles the workspace.
      workspace = {
        -- The maximum number of files to preload for analysis.
        -- Increasing this can improve completion speed in large projects at the cost of initial startup time.
        maxPreload = 100000,
        -- The maximum size (in bytes) of a single file to preload.
        preloadFileSize = 10000,
      },
      -- Configuration for inlay hints and other visual hints.
      hint = {
        -- Enables inlay hints.
        enable = true,
        -- If true, shows inlay hints for variable types.
        setType = true,
      },
      -- Configuration for formatting.
      format = {
        -- Disables lua_ls's built-in formatter.
        -- This is common if using an external formatter like StyLua via conform.nvim.
        enable = false,
      },
      -- Configuration for telemetry (data collection).
      telemetry = {
        -- Disables telemetry, preventing lua_ls from sending usage data.
        enable = false,
      },
      -- Configuration for semantic highlighting provided by lua_ls.
      semantic = {
        -- Disables semantic highlighting from lua_ls.
        -- This is often preferred if relying solely on Tree-sitter for syntax highlighting
        -- to avoid potential conflicts or redundant highlighting.
        enable = false,
      },
    },
  },
}
