-- This file defines configuration options for glance.nvim, a plugin that provides
-- a UI for viewing LSP results like definitions, references, and implementations.

-- Imports the glance plugin module itself and its actions submodule for use in mappings.
local glance = require "glance"
local actions = glance.actions

-- Main configuration table for glance.nvim.
local options = {
  -- Sets the default height of the glance window (list view) in lines.
  height = 20,
  -- Sets the z-index (stacking order) for glance UI elements, helping to ensure
  -- they appear above other floating windows if necessary.
  zindex = 50,
  -- If true, the glance window would be "detached" and not automatically close
  -- when switching buffers or windows. Currently set to false.
  detached = false,
  -- Configuration options for the preview window within glance.
  preview_win_opts = {
    -- Enables highlighting of the current line in the preview window.
    cursorline = true,
    -- Enables display of line numbers in the preview window.
    number = true,
    -- Enables line wrapping in the preview window.
    wrap = true,
  },
  -- Configuration for the border of the glance window.
  border = {
    -- Disables the display of a border around the glance window.
    enable = false,
    -- Characters to use for the top and bottom border lines, if enabled.
    top_char = "―",
    bottom_char = "―",
  },
  -- Configuration for the list view (where results are displayed).
  list = {
    -- Positions the list view to the right of the current window.
    position = "right",
    -- Sets the width of the list view as a fraction of the active window's width (33%).
    width = 0.33,
  },
  -- Configuration for glance's theming, allowing it to adapt to your colorscheme.
  theme = {
    -- Enables automatic theme generation based on the current Neovim colorscheme.
    enable = true,
    -- Determines how colors are adjusted. 'darken' will make glance UI elements darker
    -- relative to the base colorscheme. 'auto' tries to intelligently choose based on brightness.
    mode = "darken",
  },
  -- Configuration for code folding within the results list.
  folds = {
    -- If true, folds in the list will be automatically closed when glance starts.
    folded = true,
    -- Character used to indicate a closed fold.
    fold_closed = "",
    -- Character used to indicate an open fold.
    fold_open = "",
  },
  -- Configuration for indent lines within the results list.
  indent_lines = {
    -- Enables the display of indent guides in the list view.
    enable = true,
  },
  -- Configuration for the winbar (a small bar at the top of the glance window).
  winbar = {
    -- Enables the display of a winbar in the glance window.
    enable = true,
  },
  -- Defines keymappings for interacting with the glance UI.
  mappings = {
    -- Mappings active when the results list window is focused.
    list = {
      ["k"] = actions.previous, -- Move to the previous item.
      ["j"] = actions.next, -- Move to the next item.
      ["<Up>"] = actions.previous, -- Alternative for previous item.
      ["<Down>"] = actions.next, -- Alternative for next item.
      ["<S-Tab>"] = actions.previous_location, -- Go to the previous distinct location (skips items in the same file/group).
      ["<Tab>"] = actions.next_location, -- Go to the next distinct location.
      ["<C-u>"] = actions.preview_scroll_win(8), -- Scroll preview window up.
      ["<C-d>"] = actions.preview_scroll_win(-8), -- Scroll preview window down.
      ["<CR>"] = actions.jump, -- Jump to the selected item in the current window.
      ["v"] = actions.jump_vsplit, -- Jump to the selected item in a new vertical split.
      ["s"] = actions.jump_split, -- Jump to the selected item in a new horizontal split.
      ["t"] = actions.jump_tab, -- Jump to the selected item in a new tab.
      ["c"] = actions.close_fold, -- Close the current fold.
      ["o"] = actions.open_fold, -- Open the current fold.
      ["[]"] = actions.enter_win "preview", -- Switch focus to the preview window. (Note: `[]` is an unusual mapping choice)
      ["q"] = actions.close, -- Close the glance window.
      ["Q"] = actions.close, -- Alternative to close.
      ["<Esc>"] = actions.close, -- Alternative to close.
      ["gq"] = actions.quickfix, -- Send all results to the quickfix list.
    },
    -- Mappings active when the preview window is focused.
    preview = {
      ["Q"] = actions.close, -- Close glance from the preview window.
      ["<C-c>q"] = actions.close, -- Alternative to close.
      ["<C-c>o"] = actions.jump, -- Jump to the item in the current window.
      ["<C-c>v"] = actions.jump_vsplit, -- Jump in a vertical split.
      ["<C-c>s"] = actions.jump_split, -- Jump in a horizontal split.
      ["<C-c>t"] = actions.jump_tab, -- Jump in a new tab.
      ["<C-p>"] = actions.previous_location, -- Go to the previous distinct location.
      ["<C-n>"] = actions.next_location, -- Go to the next distinct location.
      ["[]"] = actions.enter_win "list", -- Switch focus back to the list window.
    },
  },
  -- Hooks allow custom functions to be executed at different stages of glance's operation.
  hooks = {
    -- Function executed before the glance window is opened with results.
    before_open = function(results, open_fn, _, method)
      -- `results`: table of LSP results.
      -- `open_fn`: function to call to actually open the glance window with results.
      -- `_`: (unused) options table.
      -- `method`: string indicating the LSP method used (e.g., "references", "definition").
      if #results == 0 then
        -- If no results are found, show a warning notification.
        vim.notify(
          "This method is not supported by any of the servers registered for the current buffer",
          vim.log.levels.WARN,
          { title = "Glance" }
        )
      elseif #results == 1 and method == "references" then
        -- If only one reference is found, notify the user.
        vim.notify("The identifier under cursor is the only one found", vim.log.levels.INFO, { title = "Glance" })
      else
        -- Otherwise, proceed to open the glance window with the results.
        open_fn(results)
      end
    end,
  },
}

return options
