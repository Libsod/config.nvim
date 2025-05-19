-- This file configures conform.nvim, a plugin for code formatting.

-- Main configuration table for conform.nvim.
local options = {
  -- Configures automatic formatting when a buffer is saved.
  format_on_save = {
    -- If a dedicated formatter for the current filetype is not found or fails,
    -- conform.nvim will attempt to use formatting capabilities provided by an active LSP server.
    lsp_fallback = true,
    -- Sets a timeout in milliseconds for the formatting process on save.
    -- If formatting takes longer than this, it will be aborted.
    timeout_ms = 500,
  },

  -- Defines which formatters to use for specific filetypes.
  -- Formatters are tried in the order they are listed for a given filetype.
  formatters_by_ft = {
    asm = { "asmfmt" },
    lua = { "stylua" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    astro = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    cpp = { "clang-format" },
    c = { "clang-format" },
    yaml = { "prettier" },
    json = { "prettier" },
    nix = { "nixpkgs_fmt" },
    -- For Go files, try 'gofumpt' first, then 'goimports-reviser'.
    go = { "gofumpt", "goimports-reviser" },
    gomod = { "gofumpt", "goimports-reviser" },
    gowork = { "gofumpt", "goimports-reviser" },
    gotmpl = { "gofumpt", "goimports-reviser" },
  },

  -- Defines specific configurations for individual formatters.
  formatters = {
    -- Custom configuration for the 'clang-format' formatter, used for C/C++.
    ["clang-format"] = {
      -- Arguments to be prepended to the clang-format command.
      -- This directly passes a Clang-Format style configuration string.
      prepend_args = {
        "-style={ \
        BasedOnStyle: LLVM, \
        IndentWidth: 2, \
        TabWidth: 2, \
        UseTab: Never, \
        AccessModifierOffset: 0, \
        IndentAccessModifiers: true, \
        PackConstructorInitializers: Never}",
      },
    },

    -- Custom configuration for 'goimports-reviser', used for Go files.
    ["goimports-reviser"] = {
      -- Adds the '-rm-unused' flag to remove unused imports.
      prepend_args = { "-rm-unused" },
    },
  },
}

return options
