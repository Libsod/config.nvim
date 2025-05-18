-- This file defines configuration options for cmake-tools.nvim,
-- a plugin that integrates CMake project management into Neovim.

-- Main configuration table for cmake-tools.nvim.
local options = {
  -- Specifies the command or path for the CMake executable.
  cmake_command = "cmake",
  -- Specifies the command or path for the CTest executable (CMake's testing tool).
  ctest_command = "ctest",
  -- Enables the use of CMake presets (CMakePresets.json or CMakeUserPresets.json)
  -- for configuring builds, if available in the project.
  cmake_use_preset = true,
  -- Disables automatic regeneration of the CMake cache when CMakeLists.txt is saved.
  -- Regeneration will need to be triggered manually.
  cmake_regenerate_on_save = false,
  -- Default options passed to CMake during the generation/configuration phase.
  cmake_generate_options = {
    "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON", -- Ensures compile_commands.json is generated for LSP use.
    "-DCMAKE_TOOLCHAIN_FILE=~/.vcpkg/vcpkg/scripts/buildsystems/vcpkg.cmake", -- Specifies a vcpkg toolchain file.
    "-G Ninja", -- Instructs CMake to generate build files for the Ninja build system.
  },
  -- Default options passed to CMake during the build phase.
  cmake_build_options = {
    "-j 10", -- Specifies the number of parallel jobs for building (e.g., using 10 cores).
  },
  -- A function that determines the build directory path.
  -- This allows for dynamic build directory naming, here incorporating the build type.
  cmake_build_directory = function()
    -- Uses a placeholder that will be replaced with the current build type (e.g., "Debug", "Release").
    return "build/${variant:buildType}"
  end,
  -- If true, automatically creates a symbolic link to compile_commands.json in the project root directory.
  -- This can make it easier for LSPs to find the compilation database.
  cmake_soft_link_compile_commands = true,
  -- If true, attempts to get the compile_commands.json path from an active LSP server.
  -- This is disabled as soft linking is preferred.
  cmake_compile_commands_from_lsp = false,
  -- Path to a global CMake Kits file, if used. Set to nil to disable.
  cmake_kits_path = nil,
  -- Configuration for messages displayed related to CMake variants (build configurations).
  cmake_variants_message = {
    short = { show = true }, -- Enables display of a short variant message.
    long = { show = true, max_length = 40 }, -- Enables display of a longer variant message, truncated if necessary.
  },
  -- Configuration for the "executor" used to run CMake commands (like configure, build).
  cmake_executor = {
    -- Specifies 'toggleterm' as the executor, meaning commands will run in a toggleable terminal.
    name = "toggleterm",
    -- Options passed to the 'toggleterm' executor.
    opts = {
      direction = "float", -- Opens the terminal in a floating window.
      close_on_exit = false, -- Keeps the terminal window open after the command finishes.
      auto_scroll = true, -- Automatically scrolls to the bottom of the terminal output.
      singleton = true, -- Ensures only one instance of this executor terminal is open at a time.
    },
  },
  -- Configuration for the "runner" used to execute built targets.
  cmake_runner = {
    -- Specifies 'toggleterm' as the runner.
    name = "toggleterm",
    -- Options passed to the 'toggleterm' runner.
    opts = {
      direction = "float", -- Opens the terminal in a floating window.
      close_on_exit = false, -- Keeps the terminal window open after the target finishes.
      auto_scroll = true, -- Automatically scrolls to the bottom of the terminal output.
      singleton = true, -- Ensures only one instance of this runner terminal is open.
    },
  },
  -- Configuration for notifications and progress display.
  cmake_notifications = {
    runner = { enabled = false }, -- Disables notifications specifically for the runner.
    executor = { enabled = false }, -- Disables notifications specifically for the executor.
    -- Defines a sequence of characters (spinner) used to indicate progress.
    spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
    -- Refresh rate in milliseconds for the progress spinner animation.
    refresh_rate_ms = 100,
  },
  -- Disables CMake Tools' own virtual text support for diagnostics or other info.
  -- This is often preferred if using a dedicated diagnostics plugin like trouble.nvim.
  cmake_virtual_text_support = false,
}

return options
