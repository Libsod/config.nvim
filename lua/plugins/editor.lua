return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opts = function()
      return require "configs.editor.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        event = { "LspAttach" },
        build = "make install_jsregexp",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "nvchad.configs.luasnip"
        end,
        dependencies = "rafamadriz/friendly-snippets",
      },

      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
  },

  {
    "lukas-reineke/cmp-under-comparator",
    ft = { "python" },
  },

  {
    "hrsh7th/cmp-nvim-lua",
    ft = { "Lua" },
  },

  {
    "LunarVim/bigfile.nvim",
    cond = function()
      local file = vim.fn.expand("%:p")       -- Get the full path of the current file
      if file == "" or vim.fn.filereadable(file) == 0 then
        return false                          -- No file or unreadable file
      end
      local file_size = vim.fn.getfsize(file) -- Get the file size in bytes
      return file_size >= 1024 * 1024         -- Load plugin if file size is >= 1 MB
    end,
    lazy = false,
    config = function()
      require "configs.editor.bigfile"
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    config = function()
      require "configs.editor.trouble"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "configs.editor.treesitter"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "syntax")
      dofile(vim.g.base46_cache .. "treesitter")
      require("nvim-treesitter.configs").setup(opts)
    end,
    -- dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  },

  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "xml", "typescriptreact", "astro" },
    config = function()
      require "configs.editor.ts-autotag"
    end,
  },

  {
    "Wansmer/treesj",
    keys = {
      {
        "gm",
        "<cmd>lua require('treesj').toggle({ split = { recursive = true } })<CR>",
        mode = { "n" },
      },
      {
        "gs",
        "<cmd>lua require('treesj').split({ recursive = true })<CR>",
        mode = { "n" },
      },
      {
        "gj",
        "<cmd>lua require('treesj').join()<CR>",
        mode = { "n" },
      },
    },
    config = function()
      require("treesj").setup { use_default_keymaps = false }
    end,
  },
}
