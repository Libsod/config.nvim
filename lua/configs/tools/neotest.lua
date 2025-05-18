-- This file configures neotest, a highly extensible test runner framework for Neovim.
-- It primarily defines which test adapters to use for different programming languages or test frameworks.

-- Defines a table of configuration options for neotest.
local options = {
  -- The 'adapters' table is crucial for neotest. It lists the test adapters
  -- that neotest should load and use to discover and run tests.
  adapters = {
    -- Enables the neotest adapter for Zig programming language tests.
    -- This requires the 'neotest-zig' plugin to be installed.
    require "neotest-zig",

    -- Enables the neotest adapter provided by the 'rustaceanvim' plugin for Rust tests.
    -- This integrates neotest with rustaceanvim's testing capabilities.
    require "rustaceanvim.neotest",

    -- Enables and configures the neotest adapter for Python tests.
    -- This requires the 'neotest-python' plugin to be installed.
    require "neotest-python" {
      -- Specifies 'python-unittest' as the test runner for Python.
      -- Other options might include 'pytest', 'nose2', etc., depending on the adapter's capabilities
      -- and your project's testing framework.
      runner = "python-unittest",
      -- dap = { ... } -- Could configure DAP (Debug Adapter Protocol) integration here.
      -- args = { ... } -- Could pass additional arguments to the test runner.
    },
  },
  status = { virtual_text = true, signs = true }, -- Example: to enable virtual text and signs for test status.
  output = { open_on_run = "short" }, -- Example: to open a short output summary on test run.
}

return options
