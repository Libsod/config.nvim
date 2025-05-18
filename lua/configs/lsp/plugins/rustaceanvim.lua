-- This file configures rustaceanvim, a comprehensive plugin for Rust development in Neovim,
-- which enhances the rust-analyzer LSP server.

-- Imports the common 'on_attach' function defined in 'core.lsp'.
-- This function is typically used to set up keymappings and other buffer-local settings
-- when an LSP server attaches.
local on_attach = require("core.lsp").on_attach

-- Imports NvChad's default LSP configurations, likely for 'on_init' and 'capabilities'.
local nvlsp = require "nvchad.configs.lspconfig"

-- Imports custom options for hover windows from 'core.utils'.
-- The '()' at the end suggests hover_opts is a function that returns an options table.
local hover_opts = require("core.utils").hover_opts()

-- Sets up the global configuration table `vim.g.rustaceanvim`.
-- rustaceanvim reads its configuration from this global variable.
vim.g.rustaceanvim = {
  -- Configuration for tools provided by rustaceanvim, such as UI elements.
  tools = {
    -- Applies the custom hover window options to floating windows used by rustaceanvim
    -- (e.g., for hover information, code actions).
    float_win_config = hover_opts,
  },

  -- Configuration for the rust-analyzer LSP server managed by rustaceanvim.
  server = {
    -- Uses the common 'on_attach' function for Rust LSP buffers.
    on_attach = on_attach,
    -- Uses NvChad's 'on_init' function, which might perform actions when the LSP server initializes.
    on_init = nvlsp.on_init,
    -- Uses NvChad's default LSP capabilities, which inform the server about client features.
    capabilities = nvlsp.capabilities,
    -- Default settings specifically for the 'rust-analyzer' LSP server.
    default_settings = {
      ["rust-analyzer"] = {
        -- Configuration for import suggestions and auto-imports.
        imports = {
          granularity = {
            -- Groups imports by module.
            group = "module",
          },
          -- Prefixes imports with 'self' where appropriate (e.g., 'use self::my_module;').
          prefix = "self",
        },
        -- Configuration related to Cargo, Rust's build system and package manager.
        cargo = {
          -- Additional environment variables for Cargo commands run by rust-analyzer.
          -- Here, it sets up a specific profile inheritance for rust-analyzer.
          extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = "dev" },
          -- Extra arguments to pass to Cargo commands.
          -- Uses a dedicated "rust-analyzer" profile.
          extraArgs = { "--profile", "rust-analyzer" },
          -- Enables all features for Cargo operations by default.
          features = "all",
        },
        -- Configuration for diagnostics (errors, warnings).
        diagnostics = {
          -- Enables diagnostics from rust-analyzer.
          enable = true,
        },
        -- Configuration for 'cargo check' or similar linting commands run by rust-analyzer.
        check = {
          -- Uses 'clippy' (Rust's linter) for checks.
          command = "clippy",
          -- Checks the entire workspace.
          workspace = true,
          -- Enables all features for checks.
          features = "all",
          -- Additional arguments for clippy, enabling more lint groups.
          extraArgs = {
            "--",
            "-Wclippy::all",
            "-Wclippy::pedantic",
          },
        },
        -- rustfmt = { -- Configuration for rustfmt (Rust's code formatter).
        --   extraArgs = { "+nightly" }, -- Example: use nightly rustfmt.
        -- },
        -- Configuration for code assists and quick fixes.
        assist = {
          -- Default behavior for filling expressions (e.g., match arms).
          expressionFillDefault = "default",
        },
        -- Configuration for inlay hints (inline type/parameter information).
        inlayHints = {
          typeHints = { enable = true }, -- Shows hints for variable types.
          bindingModeHints = { enable = true }, -- Shows hints for binding modes (e.g., 'mut').
          closingBraceHints = { -- Shows hints for closing braces of multiline blocks.
            minLines = 11, -- Only for blocks longer than 10 lines.
          },
          closureCaptureHints = { enable = true }, -- Shows hints for what closures capture.
          closureReturnTypeHints = { -- Shows return type hints for closures.
            enable = "with_block", -- Only for closures with a block body.
          },
          closureStyle = "rust_analyzer", -- Style of closure hints.
          discriminantHints = { -- Shows hints for enum discriminants.
            enable = "fieldless", -- Only for fieldless enums.
          },
          parameterHints = { enable = true }, -- Shows hints for function parameter names.
          rangeExclusiveHints = { enable = true }, -- Shows hints for exclusive ranges.
          renderColons = false, -- Disables rendering of colons before inlay hints.
          expressionAdjustmentHints = { -- Hints for expression adjustments (e.g., reborrows).
            mode = "prefer_postfix",
            enable = "reborrow",
          },
          lifetimeElisionHints = { -- Hints for elided lifetimes.
            enable = "skip_trivial", -- Skips hints for trivial elisions.
          },
        },
        -- Configuration for CodeLens (actionable information interspersed in code).
        lens = {
          run = { enable = true }, -- Enables CodeLens for running tests/binaries.
        },
        -- Configuration for autocompletion.
        completion = {
          fullFunctionSignatures = { enable = true }, -- Shows full function signatures in completion.
        },
        -- Enables support for procedural macros.
        procMacro = { enable = true },
        -- Configuration related to typing assistance.
        typing = {
          autoClosingAngleBrackets = { enable = true }, -- Automatically closes angle brackets.
        },
        -- Configuration for semantic highlighting provided by rust-analyzer.
        semanticHighlighting = {
          operator = {
            specialization = { enable = true }, -- Enables highlighting for operator specialization.
          },
          punctuation = {
            separate = {
              macro = {
                bang = true, -- Separately highlights the '!' in macros.
              },
            },
            enable = true, -- Enables semantic highlighting for punctuation.
          },
        },
        -- Configuration for workspace-related features.
        workspace = {
          symbol = {
            search = {
              -- Scope for workspace symbol search.
              kind = "all_symbols",
            },
          },
        },
        -- Configuration for signature help information.
        signatureInfo = {
          documentation = {
            enable = true, -- Shows documentation within signature help.
          },
        },
      },
    },
  },
}
