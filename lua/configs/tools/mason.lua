local options = {
  ensure_installed = {
    -- Shell
    "bash-language-server",

    -- Low-level
    "clangd",
    "clang-format", -- formatter
    "zls",
    "rust-analyzer",
    "asm-lsp",
    "asmfmt", -- formatter

    -- Web
    "html-lsp",
    "css-lsp",
    "prettier", -- formatter
    "tailwindcss-language-server",
    "typescript-language-server",
    "eslint-lsp",
    "astro-language-server",

    -- Python
    "pyright",
    "ruff-lsp",

    -- Lua
    "lua-language-server",
    "stylua", -- formatter

    -- Markdown
    "marksman",
    -- textlsp

    -- LaTeX
    "texlab",

    -- Markup config langs
    "json-lsp",
    "yaml-language-server",
    "taplo",
    "lemminx",

    -- Nix
    -- nixd - LSP (Not available at Mason)
    "nixpkgs-fmt",
    -- nixfmt -- formatter (Not available at Mason)

    -- Docker
    "docker-compose-language-service",
    "dockerfile-language-server",

    -- Sql
    -- postgres_lsp (Not available at Mason)
    "sqls",

    -- Build system's langs
    "autotools-language-server",
    "neocmakelsp",

    -- Odin
    "ols",

    -- Java
    "jdtls",

    -- OpenGL
    "glsl_analyzer",
  },

  PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = "󰄳 ",
      package_uninstalled = " 󰚌",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },

  max_concurrent_installers = 10,
}

return options
