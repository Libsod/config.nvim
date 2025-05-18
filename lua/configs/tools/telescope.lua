-- This file defines configuration options for Telescope.nvim, a highly extensible
-- fuzzy finder for Neovim, used for searching files, buffers, Telescope, and more.

-- Applies NvChad's base46 themed highlights specifically for Telescope UI elements.
-- This ensures Telescope's appearance integrates visually with the active NvChad theme.
dofile(vim.g.base46_cache .. "telescope")

-- Main configuration table for Telescope.nvim.
local options = {
  -- Default settings applied to all Telescope pickers unless overridden by a specific picker.
  defaults = {
    -- Command-line arguments for the 'rg' (ripgrep) command when used by Telescope's live_grep.
    vimgrep_arguments = {
      "rg", -- The ripgrep executable.
      "-L", -- Follow symbolic links.
      "--color=never", -- Disable colors from rg output, as Telescope handles highlighting.
      "--no-heading", -- Suppress an extra heading line from rg.
      "--with-filename", -- Print the filename for each match.
      "--line-number", -- Print the line number for each match.
      "--column", -- Print the column number for each match.
      "--smart-case", -- Perform case-insensitive search unless an uppercase letter is in the query.
    },
    prompt_prefix = "   ", -- Prefix string displayed before the input prompt.
    selection_caret = "  ", -- String used to indicate the currently selected item.
    entry_prefix = "  ", -- Prefix string for each item in the results list.
    initial_mode = "insert", -- Telescope starts in insert mode in the prompt.
    selection_strategy = "reset", -- Resets selection when the prompt changes.
    sorting_strategy = "ascending", -- Default sorting order for results.
    layout_strategy = "horizontal", -- Default layout for results and preview (horizontal split).
    -- Configuration for different layout strategies.
    layout_config = {
      horizontal = {
        prompt_position = "top", -- Position of the prompt input area.
        preview_width = 0.55, -- Preview window takes 55% of the available width.
        results_width = 0.8, -- Results window takes 80% of the available width.
      },
      vertical = {
        mirror = false, -- If true, preview is on top, results below.
      },
      width = 0.87, -- Default width of the Telescope window (as a fraction of screen width).
      height = 0.80, -- Default height of the Telescope window (as a fraction of screen height).
      preview_cutoff = 120, -- Max lines for preview before it's truncated or scrollable.
    },
    -- Default sorter for file-based pickers, using Telescope's fuzzy file sorter.
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    -- List of file/directory patterns to ignore when searching for files.
    file_ignore_patterns = {
      ".git/",
      "node_modules",
      "__pycache__",
      "zig-cache/",
      ".obsidian/",
      ".idea/",
      "build/",
      "out/",
      ".cache/",
      "obj/",
      "bin/",
      "vcpkg_installed/",
    },
    -- Default sorter for generic pickers.
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    -- How file paths are displayed in the results list. "truncate" shortens long paths.
    path_display = { "truncate" },
    -- Transparency level of the Telescope window (0 is opaque).
    winblend = 0,
    -- Border configuration (empty table means default border or no border depending on other settings).
    border = {},
    -- Characters used for drawing the border of the Telescope window.
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    -- Enables the display of devicons (filetype icons) next to results.
    color_devicons = true,
    -- Sets environment variables for processes spawned by Telescope (e.g., previewers).
    -- COLORTERM=truecolor helps ensure correct color rendering in previews.
    set_env = { ["COLORTERM"] = "truecolor" },
    -- Default previewer for files (shows file content).
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    -- Default previewer for grep results (highlights matches in context).
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    -- Default previewer for quickfix list items.
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- A function that creates a previewer for general buffers.
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    -- Default keymappings for Telescope pickers (normal mode within the picker).
    mappings = {
      -- Pressing 'q' in normal mode within a Telescope picker closes it.
      n = { ["q"] = require("telescope.actions").close },
    },
  },

  -- A list of Telescope extensions to load automatically.
  -- These names correspond to subdirectories in Telescope's extensions folder or separate plugins.
  extensions_list = { "themes", "terms", "ui-select", "fzf" },
  -- Configuration specific to loaded Telescope extensions.
  extensions = {
    -- Configuration for the 'fzf' extension, which uses fzf-native for sorting.
    fzf = {
      fuzzy = true, -- Enables fuzzy searching.
      override_generic_sorter = true, -- Uses fzf's sorter for generic pickers.
      override_file_sorter = true, -- Uses fzf's sorter for file pickers.
      case_mode = "smart_case", -- fzf respects smart case for searching.
    },
  },
}

return options
