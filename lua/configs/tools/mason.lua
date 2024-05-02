local options = {
  ensure_installed = {
    -- Shell
    "bashls",

    -- Low-level
    "clangd",
    "clang-format", -- formatter
    "zls",
    "rust_analyzer",
    "asm_lsp",
    "asmfmt", -- formatter

    -- Web
    "html",
    "cssls",
    "prettier", -- formatter
    "tailwindcss",
    "tsserver",
    "eslint",
    "astro",

    -- Python
    "pyright",
    "ruff_lsp",

    -- Lua
    "lua_ls",
    "stylua", -- formatter

    -- Markdown
    "marksman",
    -- textlsp

    -- LaTeX
    "texlab",

    -- Markup config langs
    "jsonls",
    "htmlls",
    "yamlls",
    "taplo",
    "lemminx",

    -- Nix
    -- nixd - LSP (Not available at Mason)
    "nixpkgs_fmt",
    -- nixfmt -- formatter (Not available at Mason)

    -- Docker
    "docker_compose_language_service",
    "dockerls",

    -- Sql
    -- postgres_lsp
    "sqls",

    -- Build system's langs
    "autotools_ls",
    "neocmake",

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
