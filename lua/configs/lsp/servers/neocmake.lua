-- This file defines server-specific configuration options for neocmake,
-- a Language Server for CMake files.

-- Returns a table containing the configuration settings for the neocmake LSP server.
-- This table is typically merged with common LSP settings and nvim-lspconfig defaults
-- when setting up the neocmake server.
return {
  -- Enables support for analyzing and providing LSP features for single,
  -- standalone CMakeLists.txt files that are not part of a larger CMake project structure
  -- (e.g., lacking a CMakeCache.txt or a build directory).
  single_file_support = true,

  -- Options passed to the language server during its initialization.
  -- These are specific to the neocmake LSP and control its initial behavior and features.
  init_options = {
    -- Configuration for formatting features provided by the neocmake LSP.
    format = {
      -- Enables CMake code formatting capabilities from the server.
      -- Note: If you use an external formatter (like conform.nvim with a CMake formatter),
      -- you might want to disable this or ensure they don't conflict.
      enable = true,
    },
    -- Configuration for linting features provided by the neocmake LSP.
    lint = {
      -- Enables CMake code linting capabilities from the server to detect potential issues.
      enable = true,
    },
    -- If true, instructs the server to also scan for CMake files that might be part of
    -- fetched or included packages (e.g., via FetchContent or find_package),
    -- potentially providing more comprehensive analysis in projects with external dependencies.
    scan_cmake_in_package = true,
  },
}
