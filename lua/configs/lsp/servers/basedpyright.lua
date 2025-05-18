-- This file defines server-specific configuration options for basedpyright,
-- a language server for Python, often used as a community-maintained fork of Pyright.

return {
  -- The 'settings' field is where language server specific preferences are defined.
  settings = {
    basedpyright = {
      -- Disables basedpyright's built-in import organization functionality.
      -- This is done because of using a separate, dedicated tool for organizing imports,
      -- such as Ruff in this case.
      disableOrganizeImports = true,
    },
  },
}
