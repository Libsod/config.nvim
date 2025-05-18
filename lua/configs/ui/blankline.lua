-- This file defines configuration options for indent-blankline.nvim,
-- a plugin that adds indentation guides (lines) to code, making it easier
-- to visually track nesting levels and scopes.

-- Main configuration table for indent-blankline.nvim.
local options = {
  -- Configuration for excluding certain filetypes or buffers from showing indent lines.
  exclude = {
    -- A list of filetypes for which indent lines will be disabled.
    filetypes = {
      "mason", -- Mason plugin UI
      "dashboard", -- Dashboard plugins like alpha-nvim or dashboard-nvim
      "terminal", -- Terminal emulator buffers
      "lspinfo", -- LSP information windows
      "TelescopePrompt", -- Telescope prompt window
      "TelescopeResults", -- Telescope results window
      "big_file_disabled_ft", -- Placeholder for filetypes disabled due to large file size
      "fugitive", -- Fugitive git wrapper UI
      "git", -- Generic git-related buffers (e.g., commit messages if not markdown)
      "json", -- JSON files (often preferred without indent lines by some)
      "log", -- Log files
      "markdown", -- Markdown files (indent lines might be distracting)
      "peekaboo", -- Peekaboo undo visualizer
      "startify", -- Startify startup screen
      "todoist", -- Todoist integration plugins
      "txt", -- Plain text files
      "help", -- Neovim help documents
      "undotree", -- Undotree visualization
      "vimwiki", -- Vimwiki files
      "vista", -- Vista symbol outline
      "Trouble", -- Trouble diagnostics list
      "lazy", -- Lazy.nvim UI
      "nvcheatsheet", -- NvChad cheatsheet
      -- An empty string might be present due to an oversight or specific plugin behavior.
      -- It typically won't match any filetype unless a buffer truly has an empty filetype.
      "",
    },
    buftypes = { "terminal", "nofile" }, -- Example: Could also exclude by buffer type.
  },

  -- Configuration for the appearance of the indent lines.
  indent = {
    -- The character used to draw the indent line. '│' is a box-drawing character.
    char = "│",
    -- The highlight group applied to the indent line character.
    -- "IblChar" is a common default, but can be customized in your colorscheme.
    -- NvChad's base46 system might already provide a suitable "IblChar" highlight.
    highlight = "IblChar",
    -- priority = 100, -- Drawing priority, can help with overlapping highlights.
  },

  -- Configuration for scope highlighting (highlighting the current indent scope).
  scope = {
    -- Disables the scope highlighting feature. If true, the current code block's
    -- indent lines might be highlighted differently.
    enabled = false,
  },
}

return options
