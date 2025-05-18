-- This file orchestrates the setup of various LSP (Language Server Protocol) servers
-- using nvim-lspconfig. It defines a list of servers to enable and merges
-- general configurations with server-specific ones.

local M = {}

-- Imports a custom core LSP module, likely containing default LSP settings,
-- on_attach functions, and other common LSP utilities.
local lspcore = require "core.lsp"

-- Imports server-specific configurations. This module is expected to return a table
-- where keys are server names and values are their specific configuration tables.
local server_configs = require "configs.lsp.servers.init" -- Assuming 'init.lua' in 'servers' directory

-- Defines a list of LSP server names that should be configured and enabled.
local servers = {
  -- Shell scripting & low-level languages
  "bashls", -- Bash Language Server
  "clangd", -- C/C++/Objective-C
  "asm_lsp", -- Assembly Language Server
  "zls", -- Zig Language Server
  "ols", -- Odin Language Server

  -- Web development
  "html", -- HTML Language Server
  "cssls", -- CSS Language Server
  "tailwindcss", -- Tailwind CSS LSP (often needs specific setup)
  "eslint", -- ESLint LSP (for JavaScript/TypeScript linting)
  "astro", -- Astro framework LSP

  -- Python
  "basedpyright", -- A community-maintained fork of Pylance/Pyright
  "ruff", -- Ruff LSP (fast Python linter and formatter)

  -- C#
  "omnisharp", -- C# LSP (OmniSharp-roslyn)

  -- Golang
  "gopls", -- Go Language Server

  -- Lua
  "lua_ls", -- Lua Language Server (sumneko/lua-language-server)

  -- Markdown & other markup/text formats
  "marksman", -- Markdown LSP
  "textlsp", -- Generic text LSP (can be useful for prose)
  "texlab", -- LaTeX LSP
  "jsonls", -- JSON Language Server
  "yamlls", -- YAML Language Server
  "taplo", -- TOML Language Server
  "lemminx", -- XML Language Server

  -- Docker & SQL
  "docker_compose_language_service", -- Docker Compose LSP
  "dockerls", -- Dockerfile LSP
  -- "neocmake", -- Listed here and below, likely an oversight or specific need. Consider if it's purely an LSP or also a tool.
  "sqls", -- SQL Language Server

  -- Build systems & miscellaneous
  "autotools_ls", -- Autotools LSP
  "neocmake", -- CMake LSP (from neovim/nvim-lspconfig)
  "jdtls", -- Java Language Server
  "glsl_analyzer", -- GLSL (OpenGL Shading Language) Analyzer
}

-- The main setup function that configures and enables all listed LSP servers.
M.setup = function()
  -- Applies default LSP configurations and diagnostic settings,
  -- likely defined in the 'core.lsp' module.
  lspcore.defaults()

  -- Iterates over the list of server names to configure each one.
  for _, server_name in ipairs(servers) do
    -- Starts with a base set of options for each server, including the common on_attach function.
    -- The on_attach function is crucial for setting up LSP-related keymappings and features
    -- when a server attaches to a buffer.
    local opts = {
      on_attach = lspcore.on_attach,
    }

    -- If there's a specific configuration defined for this server in 'configs.lsp.servers.init',
    -- merge it with the base options. Server-specific options will override the defaults.
    if server_configs[server_name] then
      opts = vim.tbl_deep_extend("force", opts, server_configs[server_name])
    end

    -- Registers the configuration for the LSP server with Neovim.
    -- This tells Neovim what settings (including on_attach, cmd, root_dir if provided here or elsewhere)
    -- to use if/when this server is started. This function itself does not start the server.
    vim.lsp.config(server_name, opts)

    -- Enable the server.
    vim.lsp.enable(server_name)
  end
end

return M
