local lint = require "lint"

local cppcheck_pattern = [[([^:]*):(%d*):([^:]*): %[([^%]\]*)%] ([^:]*): (.*)]]
local cppcheck_groups = { "file", "lnum", "col", "code", "severity", "message" }
local cppcheck_severity_map = {
  ["error"] = vim.diagnostic.severity.ERROR,
  ["warning"] = vim.diagnostic.severity.WARN,
  ["performance"] = vim.diagnostic.severity.WARN,
  ["style"] = vim.diagnostic.severity.INFO,
  ["information"] = vim.diagnostic.severity.INFO,
}

lint.linters_by_ft = {
  c = { "cppcheck" },
  cpp = { "cppcheck" },
  golang = { "golangcilint" },
  bash = { "shellcheck" },
  sh = { "shellcheck" },
  yaml = { "yamllint" },
  json = { "jsonlint" },
}

lint.linters.cppcheck = {
  name = "cppcheck",
  cmd = "cppcheck",
  stdin = false,
  args = {
    "--enable=warning,style,performance,portability,information",
    "--check-level=exhaustive",
    "--suppress=missingIncludeSystem",
    "--suppress=missingInclude",
    "--inline-suppr",
    "-j 10",
    function()
      if vim.bo.filetype == "cpp" then
        return "--language=c++"
      else
        return "--language=c"
      end
    end,
    "--quiet",
    function()
      if vim.fn.isdirectory "build" == 1 then
        return "--cppcheck-build-dir=build"
      else
        return nil
      end
    end,
    "--template={file}:{line}:{column}: [{id}] {severity}: {message}",
  },
  stream = "stderr",
  parser = require("lint.parser").from_pattern(
    cppcheck_pattern,
    cppcheck_groups,
    cppcheck_severity_map,
    { ["source"] = "cppcheck" }
  ),
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  callback = function()
    lint.try_lint()
  end,
})
