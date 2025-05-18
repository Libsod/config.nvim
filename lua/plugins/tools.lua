return {

  --  SECTION: File Management & Project Navigation

  {
    -- A file explorer that aims to replace netrw, providing a more modern
    -- and potentially faster file navigation experience within Neovim.
    "stevearc/oil.nvim",
    cmd = "Oil",
    opts = function()
      return require "configs.tools.oil"
    end,
    config = function(_, opts)
      require("oil").setup(opts)
    end,
  },

  {
    -- A highly extensible fuzzy finder, used for quickly searching files, buffers,
    -- Git history, LSP symbols, and many other things within Neovim.
    "nvim-telescope/telescope.nvim",
    opts = function()
      return require "configs.tools.telescope"
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)

      -- Loads any specified Telescope extensions.
      for _, ext in ipairs(opts.extensions_list) do
        pcall(telescope.load_extension, ext) -- Use pcall for safety
      end
    end,
    dependencies = {
      {
        -- Native FZF sorter for Telescope, significantly improving performance for large lists.
        "nvim-telescope/telescope-fzf-native.nvim",
        -- Specifies build commands to compile the native extension.
        build = "cmake -S. -Bbuild -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
      -- Provides a way to use Telescope as a UI replacement for `vim.ui.select()`.
      "nvim-telescope/telescope-ui-select.nvim",
    },
  },

  --  SECTION: Search & Replace Utilities

  {
    -- A project-wide search and replace tool, offering a UI to preview changes
    -- before applying them across multiple files.
    "nvim-pack/nvim-spectre",
    keys = {
      {
        "<leader>S",
        function()
          require("spectre").toggle()
        end,
        mode = { "n" },
        desc = "spectre: toggle",
      },
      {
        "<leader>sw",
        "<esc><cmd>lua require('spectre').open_visual()<cr>",
        mode = { "v" },
        desc = "spectre: visual search",
      },
      {
        "<leader>sw",
        function()
          require("spectre").open_visual { select_word = true }
        end,
        mode = { "n" },
        desc = "spectre: word search",
      },
      {
        "<leader>sf",
        function()
          require("spectre").open_file_search()
        end,
        mode = { "n" },
        desc = "spectre: file search",
      },
      {
        "<leader>sp",
        function()
          require("spectre").open_file_search { select_word = true }
        end,
        mode = { "n" },
        desc = "spectre: word file search",
      },
    },
  },

  --  SECTION: Code Quality & Formatting

  {
    -- A formatting plugin that integrates with various code formatters,
    -- allowing for consistent code styling across projects and languages.
    "stevearc/conform.nvim",
    -- Lazy-loads the plugin just before a buffer is written to disk,
    -- enabling automatic formatting on save.
    event = "BufWritePre",
    opts = function()
      return require "configs.tools.conform"
    end,
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },

  {
    -- A linting plugin that integrates with various linters to provide
    -- real-time or on-save code analysis and error reporting.
    "mfussenegger/nvim-lint",
    ft = { "golang", "c", "cpp", "bash", "sh", "yaml", "json" },
    config = function()
      require "configs.tools.lint"
    end,
  },

  --  SECTION: Testing Framework

  {
    -- A modern, extensible test runner framework for Neovim, allowing integration
    -- with various test adapters for different languages and test frameworks.
    "nvim-neotest/neotest",
    keys = {
      "<leader>n",
    },
    opts = function()
      return require "configs.tools.neotest"
    end,
    config = function(_, opts)
      require("neotest").setup(opts)
    end,
    dependencies = {
      -- An asynchronous I/O library, required by Neotest for its operations.
      "nvim-neotest/nvim-nio",
      -- A utility plugin to fix potential issues with the CursorHold autocommand,
      -- which Neotest might use for certain features.
      "antoinemadec/FixCursorHold.nvim",
    },
  },

  {
    -- An adapter for Neotest that enables running tests for the Zig programming language.
    "lawrence-laz/neotest-zig",
    ft = { "zig" },
  },

  {
    -- An adapter for Neotest that enables running tests for Python,
    -- integrating with common Python test runners.
    "nvim-neotest/neotest-python",
    ft = { "python" },
  },

  --  SECTION: Version Control

  {
    -- A Git porcelain (user interface) for Neovim, providing a Magit-like experience
    -- for managing Git repositories.
    "NeogitOrg/neogit",
    cmd = "Neogit",
    config = function()
      require("neogit").setup {
        mappings = {
          commit_editor = {
            ["q"] = "Close",
            ["<m-s>"] = "Submit",
            ["<m-a>"] = "Abort",
          },
          commit_editor_I = {
            ["<m-s>"] = "Submit",
            ["<m-a>"] = "Abort",
          },
        },
      }
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "sindrets/diffview.nvim",
      "ibhagwan/fzf-lua",
    },
  },

  --  SECTION: Specialized Tools

  {
    -- Integrates Neovim with Obsidian, a popular note-taking and knowledge base application,
    -- allowing for linking, backlinks, and other Obsidian-specific features within Neovim.
    "epwalsh/obsidian.nvim",
    version = "*",
    event = {
      "BufEnter " .. vim.fn.expand "~" .. "/notes/*",
      "BufNewFile " .. vim.fn.expand "~" .. "/notes/*",
    },
    opts = function()
      return require "configs.tools.obsidian"
    end,
    config = function(_, opts)
      require("obsidian").setup(opts)
    end,
  },
}
