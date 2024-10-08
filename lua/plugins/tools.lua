return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "nvchad.configs.nvimtree"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "nvimtree")
      require("nvim-tree").setup(opts)
    end,
  },

  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    config = function()
      require "configs.tools.oil"
    end,
  },

  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", "g" },
    cmd = "WhichKey",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup(opts)
    end,
  },

  {
    "dnlhc/glance.nvim",
    cmd = { "Glance" },
    config = function()
      require "configs.tools.glance"
    end,
  },

  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function()
      return require "configs.tools.mason"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "mason")
      require("mason").setup(opts)

      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if opts.ensure_installed and #opts.ensure_installed > 0 then
          vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
        end
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.editor.conform"
    end,
  },

  {
    "mfussenegger/nvim-lint",
    ft = { "golang", "c", "cpp", "bash", "sh", "yaml", "json" },
    config = function()
      require "configs.tools.lint"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    opts = function()
      return require "configs.tools.telescope"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require "telescope"
      telescope.setup(opts)

      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope-ui-select.nvim",
      },

      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
    },
  },

  {
    "phaazon/hop.nvim",
    cmd = { "HopWordMW", "HopLineMW", "HopChar1MW", "HopChar2MW" },
    branch = "v2", -- optional but strongly recommended
    config = function()
      require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
    end,
  },

  {
    "chrisgrieser/nvim-spider",
    keys = {
      {
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "w",
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "b",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "ge",
        "<cmd>lua require('spider').motion('ge')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "cw",
        "c<CMD>lua require('spider').motion('e')<CR>",
        mode = { "n", "o", "x" },
      },
    },
  },

  {
    "kylechui/nvim-surround",
    keys = { "ys", "ds", "cs" },
    version = "*",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "sindrets/diffview.nvim", -- optional - Diff integration
      "ibhagwan/fzf-lua", -- optional
    },
    config = function()
      local neogit = require "neogit"

      neogit.setup {
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
  },

  {
    "ojroques/nvim-bufdel",
    cmd = { "BufDel", "BufDelAll", "BufDelOthers" },
  },

  {
    "gbprod/substitute.nvim",
    keys = { "s", "ss", "S" },
    opts = function()
      return require "configs.tools.substitute"
    end,
  },

  {
    "nvim-pack/nvim-spectre",
    cmd = { "Spectre" },
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*",
    event = {
      "BufEnter " .. vim.fn.expand "~" .. "/notes/*",
      "BufNewFile " .. vim.fn.expand "~" .. "/notes/*",
    },
    config = function()
      require "configs.tools.obsidian"
    end,
  },
}
