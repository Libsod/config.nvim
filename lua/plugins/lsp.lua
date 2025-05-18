return {

  --  SECTION: Core LSP Setup

  {
    -- Core plugin for configuring and managing Neovim's built-in LSP client.
    "neovim/nvim-lspconfig",
    config = function()
      -- Conditionally sets up Neodev and Neoconf for enhanced Lua development
      -- within Neovim itself (e.g., for plugin or configuration development)
      -- when editing Lua or Luadoc files.
      local filetype = vim.bo.filetype
      if vim.tbl_contains({ "lua", "luadoc" }, filetype) then
        require("neodev").setup {} -- Provides Neovim API intellisense.
        require("neoconf").setup {} -- Manages project-local Neovim configurations.
      end
      require("configs.lsp.lspconfig").setup()
    end,
  },

  {
    -- Provides a better development experience for Neovim Lua plugin development by offering
    -- full type information for the Neovim API, enabling autocompletion and type checking.
    "folke/neodev.nvim",
    ft = { "lua" },
    dependencies = {
      -- A configuration management tool that can be used with Neodev to handle
      -- project-local Neovim API versions or other Neovim-specific settings.
      "folke/neoconf.nvim",
    },
  },

  --  SECTION: Language Specific LSP Suites

  {
    -- A comprehensive suite of tools and enhancements for Rust development,
    -- building upon the rust-analyzer LSP.
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    config = function()
      require "configs.lsp.plugins.rustaceanvim"
    end,
  },

  {
    -- A suite of tools for TypeScript and JavaScript development, offering features
    -- like refactoring, code organization, and enhanced LSP interactions beyond
    -- what the standard tsserver provides.
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = function()
      return require "configs.lsp.plugins.typescript-tools"
    end,
    config = function(_, opts)
      require("typescript-tools").setup(opts)
    end,
  },

  {
    -- Extends the functionality of the clangd LSP server for C and C++ development,
    -- offering additional features and commands.
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "h", "hpp" },
    opts = function()
      return require "configs.lsp.plugins.clangd"
    end,
    config = function(_, opts)
      require("clangd_extensions").setup(opts)
    end,
  },

  --  SECTION: LSP Extensions & Utilities

  {
    -- Displays function signature information (parameter hints) in a floating window
    -- as you type or on demand, for languages supported by an LSP server.
    "ray-x/lsp_signature.nvim",
    -- Lazy-loads the plugin when an LSP client attaches to a buffer, ensuring it's ready
    -- to provide signature help.
    event = { "LspAttach" },
  },

  --  SECTION: Build System & Dependency Management LSP Integrations

  {
    -- Integrates CMake project management tools into Neovim, allowing for
    -- easier building, configuring, and running of CMake-based projects.
    "Civitasv/cmake-tools.nvim",
    ft = { "c", "cpp", "h", "hpp", "cmake" },
    opts = function()
      return require "configs.lsp.plugins.cmake-tools"
    end,
    config = function(_, opts)
      require("cmake-tools").setup(opts)
    end,
    dependencies = {
      -- A terminal manager plugin, often used by cmake-tools.nvim to display build output
      -- and run CMake commands. The 'config = true' ensures toggleterm's own setup is run.
      -- 'version = "*"' means it will use the latest available version.
      { "akinsho/toggleterm.nvim", config = true, version = "*" },
    },
  },

  {
    -- Provides utilities for managing Rust crate (dependency) versions directly
    -- from within Neovim, typically by interacting with Cargo.toml files.
    "saecki/crates.nvim",
    -- Specifies that the "stable" release tag of the plugin should be used.
    tag = "stable",
    -- Lazy-loads the plugin when a Cargo.toml file is read into a buffer.
    event = "BufReadPost Cargo.toml",
    opts = function()
      return require "configs.lsp.plugins.crates"
    end,
    config = function(_, opts)
      require("crates").setup(opts)
    end,
  },
}
