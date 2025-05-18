-- This file defines configuration options for gitsigns.nvim, a plugin that
-- displays Git status (added, modified, removed lines) in the sign column
-- and provides actions related to Git hunks.

-- Main configuration table for gitsigns.nvim.
local options = {
  -- Defines the characters (signs) used in the sign column to indicate Git changes.
  signs = {
    add = { text = "│" }, -- Sign for added lines.
    change = { text = "│" }, -- Sign for modified lines.
    delete = { text = "󰍵" }, -- Sign for deleted lines (a "trash can" or similar icon).
    topdelete = { text = "‾" }, -- Sign for deleted lines when the deletion is at the top of a hunk.
    changedelete = { text = "~" }, -- Sign for lines that were part of a change but then deleted.
    untracked = { text = "│" }, -- Sign for untracked files (though gitsigns primarily focuses on changes in tracked files).
  },

  -- A function that is executed when gitsigns attaches to a buffer (typically a file tracked by Git).
  -- This is commonly used to set up buffer-local keymappings for gitsigns actions.
  on_attach = function(bufnr)
    -- Gets the loaded gitsigns module instance, providing access to its functions.
    local gs = package.loaded.gitsigns

    -- Helper function to create options table for keymappings, ensuring they are buffer-local
    -- and have a description.
    local function keymap_opts(desc)
      return { buffer = bufnr, noremap = true, silent = true, desc = desc }
    end

    -- Local shortcut for vim.keymap.set.
    local map = vim.keymap.set

    -- Keymapping to reset the current hunk (revert changes in that hunk to HEAD).
    map("n", "<leader>gr", function()
      gs.reset_hunk()
    end, keymap_opts "gitsigns: Reset Hunk")
    -- Keymapping to preview the changes in the current hunk in a floating window or popup.
    map("n", "<leader>gp", function()
      gs.preview_hunk()
    end, keymap_opts "gitsigns: Preview Hunk")
    -- Keymapping to show Git blame information for the current line in a floating window.
    map("n", "<leader>gb", function()
      gs.blame_line()
    end, keymap_opts "gitsigns: Blame Line")
    -- map("n", "]h", function() gs.next_hunk() end, keymap_opts "gitsigns: Next Hunk")
    -- map("n", "[h", function() gs.prev_hunk() end, keymap_opts "gitsigns: Previous Hunk")
    -- map("n", "<leader>gs", function() gs.stage_hunk() end, keymap_opts "gitsigns: Stage Hunk")
    -- map("n", "<leader>gu", function() gs.undo_stage_hunk() end, keymap_opts "gitsigns: Undo Stage Hunk")
    -- map("n", "<leader>gd", function() gs.diffthis("~") end, keymap_opts "gitsigns: Diff HEAD")
  end,
  current_line_blame = true, -- If true, shows blame info for the current line automatically.
  -- current_line_blame_opts = { ... }, -- Options for current line blame.
  -- watch_gitdir = { interval = 1000 }, -- How often to check for git directory changes.
  -- update_debounce = 100, -- Debounce time for updates.
}

return options
