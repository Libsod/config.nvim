-- This file defines configuration options for nvim-ts-autotag,
-- a plugin that automatically manages HTML/XML/JSX closing tags.

-- Defines a table of configuration options.
local options = {
  -- Specifies the list of filetypes for which nvim-ts-autotag should be active.
  -- While the plugin specification in lazy.nvim might also have an 'ft' field for lazy-loading,
  -- this 'filetypes' option within the plugin's own configuration directly tells
  -- nvim-ts-autotag which languages to process.
  filetypes = {
    "html",
    "astro",
    "svelte",
    "javascript", -- Typically for JSX in JS files
    "typescript", -- Typically for TSX in TS files
    "javascriptreact", -- Explicit JSX
    "typescriptreact", -- Explicit TSX
    "vue",
    "xml",
  },
}

return options
