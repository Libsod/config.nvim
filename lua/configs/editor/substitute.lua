-- This file defines configuration options for substitute.nvim,
-- a plugin that provides enhanced operators and motions for search and replace operations.

-- Main configuration table for substitute.nvim.
local options = {
  -- Configures the highlighting of text that has just been substituted.
  highlight_substituted_text = {
    -- The duration in milliseconds for which the substituted text will remain highlighted.
    -- After this timer expires, the highlight is cleared.
    timer = 300,
  },
}

return options
