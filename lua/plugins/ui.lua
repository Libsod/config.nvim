return {

  --  SECTION: Visual Editor Enhancements

  {
    -- Adds indentation guides (lines) to code, making it easier to visually track nesting levels.
    "lukas-reineke/indent-blankline.nvim",
    opts = function()
      return require "configs.ui.blankline"
    end,
  },

  {
    -- Displays Git status (added, modified, removed lines) directly in the sign column
    -- and provides related Git hunks actions.
    "lewis6991/gitsigns.nvim",
    cond = function()
      return vim.fn.finddir(".git", ".;") ~= ""
    end,
    opts = require "configs.ui.gitsigns",
  },

  --  SECTION: Informational UI Elements

  {
    -- Displays a pop-up menu of available keybindings after a prefix key (like <leader>)
    -- is pressed, helping users discover and remember mappings.
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", "g", "c", "v" },
    cmd = "WhichKey",
  },

  {
    -- Highlights and provides navigation for special comment keywords like TODO, FIXME, NOTE, etc.,
    -- making them easier to spot and manage.
    "folke/todo-comments.nvim",
    event = { "BufReadPost" },
    opts = {
      highlight = {
        comments_only = false,
      },
      keywords = {
        SECTION = {
          icon = "\u{f03a}", -- icon used for the sign, and in search results
          color = "info", -- can be a hex color, or a named color (see below)
        },
      },
    },
  },

  {
    -- Provides a structured and elegant way to display diagnostics (errors, warnings),
    -- LSP references, TODOs, and other items in a dedicated list.
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = function()
      return require "configs.ui.trouble"
    end,
    config = function(_, opts)
      require("trouble").setup(opts)
    end,
  },

  {
    -- Provides a UI for LSP code navigation features like definitions, references,
    -- implementations, and type definitions, often presenting them in a quickfix-like window.
    "dnlhc/glance.nvim",
    cmd = { "Glance" },
    opts = function()
      return require "configs.ui.glance"
    end,
    config = function(_, opts)
      require("glance").setup(opts)
    end,
  },

  --  SECTION: Custom Highlighting

  {
    -- A plugin that allows "painting" text with specific colors based on Tree-sitter queries,
    -- enabling more granular and context-aware syntax highlighting beyond standard themes.
    "folke/paint.nvim",
    ft = { "lua" },
    opts = function()
      return require "configs.ui.paint"
    end,
    config = function(_, opts)
      require("paint").setup(opts)
    end,
  },
}
