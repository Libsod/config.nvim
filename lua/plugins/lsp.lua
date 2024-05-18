return {
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      local filetype = vim.bo.filetype
      if vim.tbl_contains({ "lua", "luadoc" }, filetype) then
        require("neodev").setup {}
      end
      require("configs.lsp.lspconfig").defaults()
      require "configs.lsp.server_configs.lspsetup"
    end,
    dependencies = {},
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    config = function()
      require "configs.lsp.rustaceanvim"
    end,
  },

  {
    "saecki/crates.nvim",
    tag = "stable",
    event = "BufReadPost Cargo.toml",
    config = function()
      require "configs.lsp.crates"
    end,
  },

  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "h", "hpp" },
    config = function()
      require "configs.lsp.clangd"
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    event = { "LspAttach" },
  },

  {
    "nvim-neotest/neotest",
    keys = {
      "<leader>n",
    },
    config = function()
      require "configs.lsp.neotest"
    end,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "antoinemadec/FixCursorHold.nvim",
    },
  },

  {
    "lawrence-laz/neotest-zig",
    ft = { "zig" },
  },

  {
    "nvim-neotest/neotest-python",
    ft = { "python" },
  },

  {
    "folke/neodev.nvim",
    ft = { "lua" },
    opts = {},
    dependencies = {
      "folke/neoconf.nvim",
    },
  },

  {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      require "configs.lsp.server_configs.tsserver"
    end,
  },

  {
    "tact-lang/tact.vim",
    ft = { "tact" },
    init = function()
      vim.g.tact_style_guide = 1
    end,
  },
}
