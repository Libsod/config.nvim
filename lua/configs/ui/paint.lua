-- This file defines configuration options for paint.nvim, a plugin that allows
-- "painting" text with specific highlight groups based on Tree-sitter queries or Lua patterns.
-- This enables more granular and context-aware syntax highlighting beyond standard themes.

-- Main configuration table for paint.nvim.
local options = {
  -- A list of highlight definitions. Each definition specifies a pattern or query,
  -- filters (like filetype), and the highlight group to apply.
  highlights = {
    {
      -- Filter to apply this highlight rule only to Lua files.
      filter = { filetype = "lua" },
      -- A Lua pattern to match.
      -- This pattern aims to highlight text like "--- @paramName" or "--- @return"
      -- often found in Lua documentation comments (e.g., EmmyLua annotations).
      -- Breakdown:
      --   %s*        - zero or more whitespace characters
      --   %-%-%-%s*  - matches "---" followed by zero or more whitespace
      --   (@%w+)     - captures a group starting with '@' followed by one or more word characters (alphanumeric + underscore)
      pattern = "%s*%-%-%-%s*(@%w+)",
      -- The highlight group to apply to the captured group (the part like "@paramName").
      -- "Constant" is a standard Vim highlight group, often used for constants or special keywords.
      hl = "Constant",
    },
    {
      -- Filter to apply this highlight rule only to Python files.
      filter = { filetype = "python" },
      -- A Lua pattern to match.
      -- This pattern aims to highlight keys in dictionary literals or keyword arguments
      -- when they are followed by a colon, e.g., "my_key:", "argument_name:".
      -- Breakdown:
      --   %s*       - zero or more whitespace characters
      --   ([_%w]+:) - captures a group consisting of:
      --               [_%w]+ - one or more word characters or underscores
      --               :      - followed by a colon
      pattern = "%s*([_%w]+:)",
      -- The highlight group to apply to the captured group (the key/argument name with the colon).
      hl = "Constant",
    },
  },
}

return options
