local M = {}

-- Import NvChad's default autocommands first.
-- This primarily handles cursor position restoration.
require "nvchad.autocmds"

-- Utility local variables for Neovim API, functions, and options.
local api = vim.api
local fn = vim.fn
local opt_local = vim.opt_local
local map = vim.keymap.set
local cmd = vim.cmd

-- Helper function to create an autocommand group.
-- Ensures the group is cleared of existing autocmds before creation.
-- @param name (string) The name of the augroup.
-- @return (integer) The ID of the created augroup.
local function create_augroup(name)
  return api.nvim_create_augroup(name, { clear = true })
end

-- Define various autocommand groups for organizing custom autocommands.
local user_general_augroup = create_augroup "UserGeneral"
local user_filetype_settings_augroup = create_augroup "UserFileTypeSettings"
local user_lsp_augroup = create_augroup "UserLspAttachSpecific"
local user_editor_behavior_augroup = create_augroup "UserEditorBehavior"
local user_terminal_augroup = create_augroup "UserTerminalSpecific"
local user_cmake_augroup = create_augroup "UserCmakeKeymaps"
local user_cargo_augroup = create_augroup "UserCargoKeymaps"
local user_markdown_augroup = create_augroup "UserMarkdownKeymaps"
local user_yank_augroup = create_augroup "UserYankHighlight"

-- Autocmd: For Quickfix (`qf`) filetypes.
-- Purpose: Prevents quickfix buffers from appearing in the buffer list.
api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  group = user_general_augroup,
  callback = function()
    opt_local.buflisted = false
  end,
})

-- Autocmd: When any terminal buffer is opened.
-- Purpose: Disables the sign column to save space in terminal buffers.
api.nvim_create_autocmd("TermOpen", {
  group = user_terminal_augroup,
  pattern = "*", -- Applies to all terminal buffers.
  command = "setlocal signcolumn=no",
})

-- Autocmd: When a 'toggleterm' terminal is opened.
-- Purpose: Sets up custom keymappings for easier navigation and interaction within toggleterm instances.
api.nvim_create_autocmd("TermOpen", {
  group = user_terminal_augroup,
  pattern = "term://toggleterm#", -- Specifically targets toggleterm buffers.
  callback = function()
    local opts = { buffer = 0 } -- Apply mappings to the current terminal buffer.
    -- Establishes intuitive exit mappings.
    map("t", "<esc>", [[<C-\><C-n>]], opts)
    map("t", "jk", [[<C-\><C-n>]], opts)
    -- Facilitates window navigation from within the terminal.
    map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
    map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
    map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
    map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    -- Allows Neovim window commands to be prefixed with <C-w> from terminal mode.
    map("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
  end,
})

-- Autocmd: For C, C++, and CMake related filetypes.
-- Purpose: Sets up keymappings for CMake-tools plugin commands, specific to these filetypes.
api.nvim_create_autocmd("FileType", {
  group = user_cmake_augroup,
  pattern = { "c", "cpp", "h", "hpp", "cmake" },
  callback = function()
    local map_opts = { silent = true }
    map("n", "<leader>cb", "<cmd>CMakeBuild<cr>", vim.tbl_extend("keep", { desc = "cmake: build" }, map_opts))
    map("n", "<leader>cg", "<cmd>CMakeGenerate<cr>", vim.tbl_extend("keep", { desc = "cmake: generate" }, map_opts))
    map("n", "<leader>ci", "<cmd>CMakeInstall<cr>", vim.tbl_extend("keep", { desc = "cmake: install" }, map_opts))
    map(
      "n",
      "<leader>cqb",
      "<cmd>CMakeQuickBuild<cr>",
      vim.tbl_extend("keep", { desc = "cmake: quick build" }, map_opts)
    )
    map("n", "<leader>cqr", "<cmd>CMakeQuickRun<cr>", vim.tbl_extend("keep", { desc = "cmake: quick run" }, map_opts))
    map(
      "n",
      "<leader>cqs",
      "<cmd>CMakeQuickStart<cr>",
      vim.tbl_extend("keep", { desc = "cmake: quick start" }, map_opts)
    )
    map(
      "n",
      "<leader>cl",
      "<cmd>CMakeLaunchArgs<cr>",
      vim.tbl_extend("keep", { desc = "cmake: launch args" }, map_opts)
    )
    map("n", "<leader>crr", "<cmd>CMakeRun<cr>", vim.tbl_extend("keep", { desc = "cmake: run" }, map_opts))
    map(
      "n",
      "<leader>crf",
      "<cmd>CMakeRunCurrentFile<cr>",
      vim.tbl_extend("keep", { desc = "cmake: run current file" }, map_opts)
    )
    map("n", "<leader>crt", "<cmd>CMakeRunTest<cr>", vim.tbl_extend("keep", { desc = "cmake: run test" }, map_opts))
    map("n", "<leader>ccl", "<cmd>CMakeClean<cr>", vim.tbl_extend("keep", { desc = "cmake: clean" }, map_opts))
    map(
      "n",
      "<leader>cce",
      "<cmd>CMakeCloseExecutor<cr>",
      vim.tbl_extend("keep", { desc = "cmake: close executor" }, map_opts)
    )
    map(
      "n",
      "<leader>ccr",
      "<cmd>CMakeCloseRunner<cr>",
      vim.tbl_extend("keep", { desc = "cmake: close runner" }, map_opts)
    )
    map(
      "n",
      "<leader>cor",
      "<cmd>CMakeOpenExecutor<cr>",
      vim.tbl_extend("keep", { desc = "cmake: open executor" }, map_opts)
    )
    map(
      "n",
      "<leader>coe",
      "<cmd>CMakeOpenRunner<cr>",
      vim.tbl_extend("keep", { desc = "cmake: open runner" }, map_opts)
    )
    map(
      "n",
      "<leader>cssr",
      "<cmd>CMakeStopRunner<cr>",
      vim.tbl_extend("keep", { desc = "cmake: stop runner" }, map_opts)
    )
    map(
      "n",
      "<leader>csse",
      "<cmd>CMakeStopExecutor<cr>",
      vim.tbl_extend("keep", { desc = "cmake: stop executor" }, map_opts)
    )
    map(
      "n",
      "<leader>cssp",
      "<cmd>CMakeSelectBuildPreset<cr>",
      vim.tbl_extend("keep", { desc = "cmake: select build preset" }, map_opts)
    )
    map(
      "n",
      "<leader>csst",
      "<cmd>CMakeSelectBuildTarget<cr>",
      vim.tbl_extend("keep", { desc = "cmake: select build target" }, map_opts)
    )
    map(
      "n",
      "<leader>cssl",
      "<cmd>CMakeSelectLaunchTarget<cr>",
      vim.tbl_extend("keep", { desc = "cmake: select launch target" }, map_opts)
    )
    map(
      "n",
      "<leader>cssb",
      "<cmd>CMakeSelectBuildType<cr>",
      vim.tbl_extend("keep", { desc = "cmake: select build type" }, map_opts)
    )
  end,
})

-- Autocmd: When an LSP client attaches, specifically for 'rust-analyzer'.
-- Purpose: Sets up Rust-specific keymappings provided by the RustLsp extensions or similar.
api.nvim_create_autocmd("LspAttach", {
  group = user_lsp_augroup,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "rust-analyzer" then
      return
    end
    local buf_map = function(modes, lhs, rhs, desc)
      map(modes, lhs, rhs, { buffer = args.buf, silent = true, desc = desc })
    end
    buf_map("n", "<leader>ra", "<cmd>RustLsp codeAction<cr>", "rust: code action")
    buf_map("n", "<leader>rr", "<cmd>RustLsp runnables<cr>", "rust: run & select target")
    buf_map("n", "<leader>rn", "<cmd>RustLsp run<cr>", "rust: run at cursor")
    buf_map("n", "<leader>rm", "<cmd>RustLsp expandMacro<cr>", "rust: expand macro")
    buf_map("n", "<leader>rb", "<cmd>RustLsp rebuildProcMacros<cr>", "rust: rebuild proc macros")
    buf_map("n", "<leader>rk", "<cmd>RustLsp moveItem up<cr>", "rust: move item up")
    buf_map("n", "<leader>rj", "<cmd>RustLsp moveItem down<cr>", "rust: move item down")
    buf_map("n", "<leader>K", "<cmd>RustLsp hoverActions<cr>", "rust: hover actions")
    buf_map("n", "<leader>re", "<cmd>RustLsp explainError<cr>", "rust: explain error")
    buf_map("n", "<leader>rd", "<cmd>RustLsp renderDiagnostic<cr>", "rust: render diagnostic")
    buf_map("n", "<leader>rc", "<cmd>RustLsp openCargo<cr>", "rust: open Cargo.toml")
    buf_map("n", "<leader>ro", "<cmd>RustLsp openDocs<cr>", "rust: open docs.rs")
    buf_map("n", "<leader>rp", "<cmd>RustLsp parentModule<cr>", "rust: parent module")
    buf_map({ "n", "x" }, "<leader>rl", "<cmd>RustLsp joinLines<cr>", "rust: join lines")
    buf_map({ "n", "x" }, "<leader>rs", "<cmd>RustLsp ssr<cr>", "rust: structural search replace")
    buf_map("n", "<leader>rt", "<cmd>RustLsp syntaxTree<cr>", "rust: view syntax tree")
    buf_map("n", "<leader>rvh", "<cmd>RustLsp viewHir<cr>", "rust: view HIR")
    buf_map("n", "<leader>rvm", "<cmd>RustLsp viewMir<cr>", "rust: view MIR")
    buf_map("n", "<leader>ru", "<cmd>Rustc unpretty<cr>", "rust: rustc unpretty")
  end,
})

-- Autocmd: When an LSP client attaches, specifically for TypeScript language servers ('tsserver' or 'ts_ls').
-- Purpose: Sets up TypeScript-specific keymappings for TodoTrouble and TSTools plugins.
api.nvim_create_autocmd("LspAttach", {
  group = user_lsp_augroup,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or (client.name ~= "tsserver" and client.name ~= "ts_ls") then
      return
    end
    local buf_map = function(modes, lhs, rhs, desc)
      map(modes, lhs, rhs, { buffer = args.buf, silent = true, desc = desc })
    end
    pcall(vim.keymap.del, "n", "<leader>t", { buffer = args.buf }) -- Safely remove default if it exists.
    buf_map("n", "<leader>tt", "<cmd>TodoTrouble<cr>", "trouble: show TODOs")
    buf_map("n", "<leader>to", "<cmd>TSToolsOrganizeImports<cr>", "typescript: sort & remove unused imports")
    buf_map("n", "<leader>ts", "<cmd>TSToolsSortImports<cr>", "typescript: sort imports")
    buf_map("n", "<leader>tri", "<cmd>TSToolsRemoveUnusedImports<cr>", "typescript: remove unused imports")
    buf_map("n", "<leader>tru", "<cmd>TSToolsRemoveUnused<cr>", "typescript: remove all unused statements")
    buf_map(
      "n",
      "<leader>ta",
      "<cmd>TSToolsAddMissingImports<cr>",
      "typescript: add missing imports for all statements"
    )
    buf_map("n", "<leader>tff", "<cmd>TSToolsFixAll<cr>", "typescript: fix all fixable errors")
    buf_map("n", "<leader>tg", "<cmd>TSToolsGoToSourceDefinition<cr>", "typescript: go to source definition")
    buf_map("n", "<leader>tfc", "<cmd>TSToolsRenameFile<cr>", "typescript: rename file and update imports")
    buf_map("n", "<leader>tfr", "<cmd>TSToolsFileReferences<cr>", "typescript: find files referencing current file")
  end,
})

-- Autocmd: When a 'Cargo.toml' file is read.
-- Purpose: Sets up keymappings for the 'crates.nvim' plugin and a custom 'K' mapping for contextual documentation.
api.nvim_create_autocmd("BufRead", {
  group = user_cargo_augroup,
  pattern = "Cargo.toml",
  callback = function()
    local map_opts = { silent = true }
    local crates_required_ok, crates_mod = pcall(require, "crates")
    if not crates_required_ok then
      return
    end
    local crates = crates_mod

    map("n", "<leader>ct", function()
      crates.toggle()
    end, vim.tbl_extend("keep", { desc = "crates: toggle ui" }, map_opts))
    map("n", "<leader>cr", function()
      crates.reload()
    end, vim.tbl_extend("keep", { desc = "crates: reload" }, map_opts))
    map("n", "<leader>cv", function()
      crates.show_popup()
    end, vim.tbl_extend("keep", { desc = "crates: popup details" }, map_opts))
    map("n", "<leader>cf", function()
      crates.show_features_popup()
    end, vim.tbl_extend("keep", { desc = "crates: popup features" }, map_opts))
    map("n", "<leader>cd", function()
      crates.show_dependencies_popup()
    end, vim.tbl_extend("keep", { desc = "crates: popup deps" }, map_opts))
    map("n", "<leader>cul", function()
      crates.update_crate()
    end, vim.tbl_extend("keep", { desc = "crates: update crate" }, map_opts))
    map("v", "<leader>cuv", function()
      crates.update_crates()
    end, vim.tbl_extend("keep", { desc = "crates: update selected" }, map_opts))
    map("n", "<leader>cua", function()
      crates.update_all_crates()
    end, vim.tbl_extend("keep", { desc = "crates: update all" }, map_opts))
    map("n", "<leader>cUl", function()
      crates.upgrade_crate()
    end, vim.tbl_extend("keep", { desc = "crates: upgrade crate" }, map_opts))
    map("v", "<leader>cUv", function()
      crates.upgrade_crates()
    end, vim.tbl_extend("keep", { desc = "crates: upgrade selected" }, map_opts))
    map("n", "<leader>cUa", function()
      crates.upgrade_all_crates()
    end, vim.tbl_extend("keep", { desc = "crates: upgrade all" }, map_opts))
    map("n", "<leader>cx", function()
      crates.expand_plain_crate_to_inline_table()
    end, vim.tbl_extend("keep", { desc = "crates: expand inline" }, map_opts))
    map("n", "<leader>cX", function()
      crates.extract_crate_into_table()
    end, vim.tbl_extend("keep", { desc = "crates: extract to table" }, map_opts))
    map("n", "<leader>cH", function()
      crates.open_homepage()
    end, vim.tbl_extend("keep", { desc = "crates: open homepage" }, map_opts))
    map("n", "<leader>cR", function()
      crates.open_repository()
    end, vim.tbl_extend("keep", { desc = "crates: open repo" }, map_opts))
    map("n", "<leader>cD", function()
      crates.open_documentation()
    end, vim.tbl_extend("keep", { desc = "crates: open docs" }, map_opts))
    map("n", "<leader>cC", function()
      crates.open_crates_io()
    end, vim.tbl_extend("keep", { desc = "crates: open crates.io" }, map_opts))

    -- Provides context-aware documentation: Vim help, man pages, crates.nvim popup, or LSP hover.
    local function show_documentation()
      local current_filetype = vim.bo.filetype
      if vim.tbl_contains({ "vim", "help" }, current_filetype) then
        cmd("h " .. fn.expand "<cword>") -- Show Vim help for word under cursor.
      elseif vim.tbl_contains({ "man" }, current_filetype) then
        cmd("Man " .. fn.expand "<cword>") -- Show man page for word under cursor.
      elseif fn.expand "%:t" == "Cargo.toml" and crates_required_ok and crates.popup_available() then
        crates.show_popup() -- For Cargo.toml, show crates.nvim details.
      else
        vim.lsp.buf.hover() -- Fallback to LSP hover information.
      end
    end
    map("n", "K", show_documentation, { silent = true, desc = "Show documentation/hover" })
  end,
})

-- Autocmd: For Markdown filetypes.
-- Purpose: Defines a custom 'gz' mapping to open 'file://' URLs (often from LSP diagnostics)
--          and jump to the specified line number within the target file.
api.nvim_create_autocmd("FileType", {
  group = user_markdown_augroup,
  pattern = { "markdown" },
  callback = function()
    map("n", "gz", function()
      local url = fn.expand "<cfile>" -- Gets the "file path" under cursor, potentially a URL.
      local file, line_str = url:match "^file://(.+)#L(%d+)$" -- Parses file path and line number from URL.

      if file and line_str then
        local line_num = tonumber(line_str)
        if line_num then
          cmd("edit " .. fn.fnameescape(file)) -- Opens the extracted file path.
          fn.cursor(line_num, 0) -- Moves cursor to the extracted line number.
          -- Enhances visibility of the navigated line.
          vim.wo.relativenumber = true
          vim.o.number = true
          vim.wo.cursorline = true
          cmd "buffer" -- Refreshes buffer display.
        else
          cmd "normal! gf" -- Falls back to default 'gf' if line number is invalid.
        end
      else
        cmd "normal! gf" -- Falls back to default 'gf' if URL pattern doesn't match.
      end
    end, { buffer = true, silent = true, desc = "Custom gf for file:// URLs" })
  end,
})

-- Autocmd: Before writing temporary or specific files.
-- Purpose: Disables undo files for various temporary/generated files.
api.nvim_create_autocmd("BufWritePre", {
  group = user_editor_behavior_augroup,
  pattern = { "/tmp/*", "*.tmp", "*.bak" },
  command = "setlocal noundofile",
})

-- Autocmd: Before writing Git commit or merge message files.
-- Purpose: Disables undo files and sets 'colorcolumn' for commit messages.
api.nvim_create_autocmd("BufWritePre", {
  group = user_editor_behavior_augroup,
  pattern = "COMMIT_EDITMSG",
  callback = function()
    opt_local.undofile = false
    opt_local.colorcolumn = "72" -- Encourages standard commit message length.
  end,
})

api.nvim_create_autocmd("BufWritePre", {
  group = user_editor_behavior_augroup,
  pattern = "MERGE_MSG",
  command = "setlocal noundofile",
})

-- Autocmd: When Neovim is about to exit.
-- Purpose: Ensures session information (shada/viminfo) is saved.
api.nvim_create_autocmd("VimLeave", {
  group = user_editor_behavior_augroup,
  pattern = "*",
  command = "if has('nvim') | wshada! | else | wviminfo! | endif",
})

-- Autocmd: When Neovim gains focus.
-- Purpose: Checks for external modifications to files in focused buffers.
api.nvim_create_autocmd("FocusGained", {
  group = user_editor_behavior_augroup,
  pattern = "*",
  command = "checktime",
})

-- Autocmd: When the Neovim window is resized.
-- Purpose: Equalizes the dimensions of all windows across all tab pages.
api.nvim_create_autocmd("VimResized", {
  group = user_editor_behavior_augroup,
  pattern = "*",
  command = "tabdo wincmd =",
})

-- Autocmd: For all filetypes (generic).
-- Purpose: Modifies 'formatoptions' to prevent auto-wrapping of comments and
--          auto-insertion of comment leader on 'o' or 'O', if not already set by NvChad's defaults.
api.nvim_create_autocmd("FileType", {
  group = user_filetype_settings_augroup,
  pattern = "*",
  command = "setlocal formatoptions-=cro",
})

-- Autocmd: For Markdown filetypes.
-- Purpose: Enables line wrapping specifically for markdown files.
api.nvim_create_autocmd("FileType", {
  group = user_filetype_settings_augroup,
  pattern = "markdown",
  command = "setlocal wrap",
})

-- Autocmd: For 'make' (Makefile) filetypes.
-- Purpose: Sets specific indentation options (tabs, width 8) for Makefiles.
api.nvim_create_autocmd("FileType", {
  group = user_filetype_settings_augroup,
  pattern = "make",
  command = "setlocal noexpandtab shiftwidth=8 softtabstop=0",
})

-- Autocmd: After text is yanked (copied).
-- Purpose: Briefly highlights the yanked region for visual feedback.
api.nvim_create_autocmd("TextYankPost", {
  group = user_yank_augroup,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 100 } -- Using IncSearch for visibility, short timeout.
  end,
})

return M
