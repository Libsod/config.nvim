-- This file configures nvim-lint, a plugin for asynchronous code linting in Neovim.
-- It defines linters for various filetypes and their specific command-line arguments and parsing logic.

-- Imports the nvim-lint plugin module.
local lint = require "lint"

-- Defines a Lua pattern to parse output from cppcheck.
-- This pattern captures file, line number, column, error code, severity, and message.
local cppcheck_pattern = [[([^:]*):(%d*):([^:]*): %[([^%]\]*)%] ([^:]*): (.*)]]
-- Specifies the names of the capture groups in the cppcheck_pattern.
local cppcheck_groups = { "file", "lnum", "col", "code", "severity", "message" }
-- Maps severity strings reported by cppcheck to Neovim's standard diagnostic severity levels.
local cppcheck_severity_map = {
  ["error"] = vim.diagnostic.severity.ERROR,
  ["warning"] = vim.diagnostic.severity.WARN,
  ["performance"] = vim.diagnostic.severity.WARN, -- Treating performance issues as warnings.
  ["style"] = vim.diagnostic.severity.INFO, -- Treating style issues as informational.
  ["information"] = vim.diagnostic.severity.INFO, -- Treating general information as informational.
}

-- Assigns linters to specific filetypes.
-- When a file of a given type is processed, the listed linters will be used.
lint.linters_by_ft = {
  c = { "cppcheck" },
  cpp = { "cppcheck" },
  golang = { "golangcilint" },
  bash = { "shellcheck" },
  sh = { "shellcheck" },
  yaml = { "yamllint" },
  json = { "jsonlint" },
}

-- Defines the configuration for the 'cppcheck' linter.
lint.linters.cppcheck = {
  -- A unique name for this linter configuration.
  name = "cppcheck",
  -- The command-line executable for cppcheck.
  cmd = "cppcheck",
  -- Indicates that cppcheck does not read from stdin for linting.
  stdin = false,
  -- Arguments passed to the cppcheck command.
  args = {
    "--enable=warning,style,performance,portability,information", -- Enables a broad range of checks.
    "--check-level=exhaustive", -- Performs the most thorough analysis.
    "--suppress=missingIncludeSystem", -- Suppresses warnings about missing system includes.
    "--suppress=missingInclude", -- Suppresses warnings about missing local includes.
    "--inline-suppr", -- Allows inline suppression of warnings in code.
    "-j 10", -- Uses 10 parallel jobs for faster analysis.
    -- Dynamically sets the language based on the current filetype.
    function()
      if vim.bo.filetype == "cpp" then
        return "--language=c++"
      else
        return "--language=c"
      end
    end,
    "--quiet", -- Suppresses non-essential output from cppcheck.
    -- Dynamically adds the build directory argument if a 'build' directory exists.
    -- This helps cppcheck find compile_commands.json or other build artifacts.
    function()
      if vim.fn.isdirectory "build" == 1 then
        return "--cppcheck-build-dir=build"
      else
        return nil -- If no build directory, this function returns nil, and lint.nvim filters it out.
      end
    end,
    -- Specifies the output format template for cppcheck, matching `cppcheck_pattern`.
    "--template={file}:{line}:{column}: [{id}] {severity}: {message}",
  },
  -- Specifies that cppcheck writes its output to stderr.
  stream = "stderr",
  -- Defines how to parse the output of cppcheck.
  -- Uses nvim-lint's built-in pattern parser with the custom pattern, groups, and severity map.
  -- Also adds a 'source' field to the diagnostics for identification.
  parser = require("lint.parser").from_pattern(
    cppcheck_pattern,
    cppcheck_groups,
    cppcheck_severity_map,
    { ["source"] = "cppcheck" } -- Sets the diagnostic source name.
  ),
}

-- Creates an autocommand to trigger linting on specific events.
-- This ensures that linting is performed automatically when entering a buffer,
-- after saving a buffer, or when leaving insert mode.
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  callback = function()
    -- Attempts to run the linters configured for the current buffer's filetype.
    lint.try_lint()
  end,
})
