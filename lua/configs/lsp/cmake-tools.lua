local options = {
  cmake_command = "cmake", -- this is used to specify cmake command path
  ctest_command = "ctest", -- this is used to specify ctest command path
  cmake_use_preset = true,
  cmake_regenerate_on_save = false, -- auto generate when save CMakeLists.txt
  cmake_generate_options = {
    "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
    "-DCMAKE_TOOLCHAIN_FILE=~/.vcpkg/vcpkg/scripts/buildsystems/vcpkg.cmake",
    "-DCMAKE_C_STANDARD=23",
    "-DCMAKE_C_FLAGS=-Wall -Wextra -Wpedantic -Walloca -Wcast-qual -Wconversion -Wformat=2 -Wformat-security -Wnull-dereference -Wstack-protector -Wvla -Warray-bounds -Warray-bounds-pointer-arithmetic -Wassign-enum -Wbad-function-cast -Wconditional-uninitialized -Wconversion -Wfloat-equal -Wformat-type-confusion -Widiomatic-parentheses -Wimplicit-fallthrough -Wloop-analysis -Wpointer-arith -Wshift-sign-overflow -Wshorten-64-to-32 -Wswitch-enum -Wtautological-constant-in-range-compare -Wunreachable-code-aggressive -Wthread-safety -Wthread-safety-beta -Wcomma",
  },
  cmake_build_options = {
    "-j 10",
  },
  cmake_build_directory = function()
    return "build/${variant:buildType}"
  end,
  cmake_soft_link_compile_commands = true, -- this will automatically make a soft link from compile commands file to project root dir
  cmake_compile_commands_from_lsp = false, -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
  cmake_kits_path = nil, -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
  cmake_variants_message = {
    short = { show = true }, -- whether to show short message
    long = { show = true, max_length = 40 }, -- whether to show long message
  },
  cmake_executor = { -- executor to use
    name = "toggleterm", -- name of the executor
    opts = {
      direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
      close_on_exit = false, -- whether close the terminal when exit
      auto_scroll = true, -- whether auto scroll to the bottom
      singleton = true, -- single instance, autocloses the opened one, if present
    }, -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
  },
  cmake_runner = { -- runner to use
    name = "toggleterm", -- name of the runner
    opts = {
      direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
      close_on_exit = false, -- whether close the terminal when exit
      auto_scroll = true, -- whether auto scroll to the bottom
      singleton = true, -- single instance, autocloses the opened one, if present
    }, -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
  },
  cmake_notifications = {
    runner = { enabled = false },
    executor = { enabled = false },
    spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
    refresh_rate_ms = 100, -- how often to iterate icons
  },
  cmake_virtual_text_support = false,
}

return require("cmake-tools").setup(options)
