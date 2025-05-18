return {

  --  SECTION: Autocompletion Engine

  {
    -- Core completion engine for Neovim, providing a framework for various completion sources.
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "configs.editor.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
    dependencies = {
      {
        -- Snippet engine integration for nvim-cmp, enabling snippet expansion.
        "L3MON4D3/LuaSnip",
        -- Specifies a build step to install the JavaScript regular expression engine,
        -- required for some advanced snippet functionalities.
        build = "make install_jsregexp",
      },
      {
        -- A completion source for file system paths (currently disabled).
        "hrsh7th/cmp-path",
        enabled = false,
      },
      -- An alternative, asynchronous completion source for file system paths.
      "https://codeberg.org/FelipeLema/cmp-async-path.git",
    },
  },

  {
    -- Completion source for Neovim's Lua API, useful when writing Lua plugins or configurations.
    "hrsh7th/cmp-nvim-lua",
    ft = { "Lua" },
  },

  --  SECTION: Syntax and Code Structure

  {
    -- Enables advanced syntax highlighting, code parsing, and structural analysis
    -- using Tree-sitter parsers for various programming languages.
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- Defines the list of language parsers that should be automatically installed and kept up-to-date.
      -- This list is sourced from 'configs.editor.treesitter'.
      ensure_installed = require "configs.editor.treesitter",
    },
  },

  {
    -- Automatically adds, renames, or removes corresponding HTML/XML/JSX closing tags as you type.
    "windwp/nvim-ts-autotag",
    ft = { "html", "xml", "typescriptreact", "astro" },
    opts = function()
      return require "configs.editor.ts-autotag"
    end,
    config = function(_, opts)
      require("nvim-ts-autotag").setup(opts)
    end,
  },

  {
    -- Facilitates splitting and joining blocks of code (e.g., objects, arrays, functions)
    -- based on their syntactical structure identified by Tree-sitter.
    "Wansmer/treesj",
    keys = {
      {
        -- Toggles splitting or joining the current code block, potentially recursively.
        "gm",
        function()
          require("treesj").toggle { split = { recursive = true } }
        end,
        mode = { "n" },
        desc = "treesj: toggle split/join",
      },
      {
        -- Splits the current Tree-sitter node into multiple lines.
        "gs",
        function()
          require("treesj").split()
        end,
        mode = { "v", "n" },
        desc = "treesj: node split",
      },
      {
        -- Joins the current Tree-sitter node onto a single line.
        "gj",
        function()
          require("treesj").join()
        end,
        mode = { "v", "n" },
        desc = "treesj: node join",
      },
    },
    config = function()
      require("treesj").setup {
        -- Disables the plugin's default keybindings, relying on custom mappings defined above.
        use_default_keymaps = false,
        -- Sets a character limit for how long a line can be when joining multiple lines.
        max_join_length = 180,
      }
    end,
  },

  --  SECTION: Editing Utilities

  {
    -- A plugin for easily commenting and uncommenting lines or blocks of code,
    -- with support for various comment styles across different languages.
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "comment: toggle current line" },
      { "gbc", mode = "n", desc = "comment: toggle current block" },
      { "gc", mode = { "x", "n", "o" }, desc = "comment: toggle linewise" },
      { "gb", mode = { "x", "n", "o" }, desc = "comment: toggle blockwise" },
      { "gco", mode = "n", desc = "comment: insert comment to next line" },
      { "gcO", mode = "n", desc = "comment: insert comment to prev line" },
      { "gcA", mode = "n", desc = "comment: insert comment to end of line" },
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },

  {
    -- Facilitates easy addition, deletion, and changing of surrounding character pairs
    -- like parentheses, brackets, quotes, and XML/HTML tags.
    "kylechui/nvim-surround",
    keys = { "ys", "ds", "cs" },
    version = "*",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    -- Provides enhanced operators and motions for search and replace operations,
    -- offering a more interactive way to perform substitutions.
    "gbprod/substitute.nvim",
    keys = {
      { "s", "<cmd>lua require('substitute').operator()<cr>", mode = { "n" }, desc = "substitute: replace operator" },
      {
        "s",
        function()
          require("substitute").visual()
        end,
        mode = { "v" },
        desc = "substitute: replace visual selection",
      },
      {
        "sc",
        function()
          vim.cmd "normal! ggVG"
          require("substitute").visual()
        end,
        mode = { "n" },
        desc = "substitute: replace entire buffer",
      },
      {
        "ss",
        function()
          require("substitute").line()
        end,
        mode = { "n" },
        desc = "substitute: replace current line",
      },
      {
        "S",
        function()
          require("substitute").eol()
        end,
        mode = { "n" },
        desc = "substitute: replace from cursor to eol",
      },
      {
        "sx",
        "<cmd>lua require('substitute.exchange').operator()<cr>",
        mode = { "n" },
        desc = "substitute: exchange operator",
      },
      {
        "sxx",
        function()
          require("substitute.exchange").line()
        end,
        mode = { "n" },
        desc = "substitute: exchange current line",
      },
      {
        "sX",
        function()
          require("substitute.exchange").visual()
        end,
        mode = { "x", "o" },
        desc = "substitute: exchange visual selection",
      },
      {
        "sxc",
        function()
          require("substitute.exchange").cancel()
        end,
        mode = { "n" },
        desc = "substitute: cancel last exchange",
      },
    },
    opts = function()
      return require "configs.editor.substitute"
    end,
  },

  --  SECTION: Enhanced Navigation

  {
    -- A motion plugin that allows for quick, precise jumps to any visible character,
    -- word, or line on the screen using hint characters.
    "smoka7/hop.nvim",
    version = "*",
    keys = {
      {
        "gw",
        function()
          require("hop").hint_words()
        end,
        mode = { "n" },
        desc = "hop: word",
      },
      {
        "<leader>k",
        function()
          require("hop").hint_lines()
        end,
        mode = { "v", "n" },
        desc = "hop: line",
      },
      {
        "<leader>gc",
        function()
          require("hop").hint_char1()
        end,
        mode = { "n" },
        desc = "hop: 1 char",
      },
      {
        "<leader>gv",
        function()
          require("hop").hint_char2()
        end,
        mode = { "n" },
        desc = "hop: 2 chars",
      },
    },
    config = function()
      require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
    end,
  },

  {
    -- Enhances word-based motions (w, b, e, ge) by making them "skip" over
    -- subwords within camelCase or snake_case identifiers, allowing for more granular navigation.
    "chrisgrieser/nvim-spider",
    keys = {
      { "e", "<cmd>lua require('spider').motion('e')<cr>", mode = { "n", "o", "x" } },
      { "w", "<cmd>lua require('spider').motion('w')<cr>", mode = { "n", "o", "x" } },
      { "b", "<cmd>lua require('spider').motion('b')<cr>", mode = { "n", "o", "x" } },
      { "ge", "<cmd>lua require('spider').motion('ge')<cr>", mode = { "n", "o", "x" } },
      { "cw", "c<cmd>lua require('spider').motion('e')<cr>", mode = { "n", "o", "x" } },
    },
  },
}
