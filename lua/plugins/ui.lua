return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = function()
      return require "configs.ui.blankline"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)

      dofile(vim.g.base46_cache .. "blankline")
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "configs.ui.gitsigns"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "git")
      require("gitsigns").setup(opts)
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return { override = require "nvchad.icons.devicons" }
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "devicons")
      require("nvim-web-devicons").setup(opts)
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.ui.noice"
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        config = function()
          require "configs.ui.notify"
        end,
      },
    },
  },

  {
    "folke/paint.nvim",
    ft = { "lua" },
    config = function()
      require "configs.ui.paint"
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost" },
    opts = {
      highlight = {
        comments_only = false, -- uses treesitter to match keywords in comments only
      },
    },
  },

  {
    "tzachar/local-highlight.nvim",
    event = { "CursorHold", "CursorHoldI" },
    config = function()
      require "configs.ui.local-highlight"
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    keys = { "<leader>cc" },
    ft = { "css", "typescript", "typescriptreact" },
    opts = { user_default_options = { names = false } },
    config = function(_, opts)
      require("colorizer").setup(opts)

      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },
}
