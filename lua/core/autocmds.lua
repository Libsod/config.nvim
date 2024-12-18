local autocmd = {}

function autocmd.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command("augroup " .. group_name)
    vim.api.nvim_command "autocmd!"
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command "augroup END"
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  command = "setlocal signcolumn=no",
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*toggleterm#*",
  callback = function()
    local opts = { buffer = 0 }
    local map = vim.keymap.set
    map("t", "<esc>", [[<C-\><C-n>]], opts)
    map("t", "jk", [[<C-\><C-n>]], opts)
    map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
    map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
    map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
    map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    map("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("CmakeKeymaps", { clear = true }),
  pattern = { "c", "cpp", "h", "hpp", "cmake" },
  callback = function()
    local map = vim.keymap.set

    -- CMake-tools
    map("n", "<leader>cb", ":CMakeBuild<CR>", { silent = true, desc = "[CMake]: Build" })
    map("n", "<leader>cg", ":CMakeGenerate<CR>", { silent = true, desc = "[CMake]: Generate" })
    map("n", "<leader>ci", ":CMakeInstall<CR>", { silent = true, desc = "[CMake]: Install" })
    map("n", "<leader>cqb", ":CMakeQuickBuild<CR>", { silent = true, desc = "[CMake]: Quick build" })
    map("n", "<leader>cqr", ":CMakeQuickRun<CR>", { silent = true, desc = "[CMake]: Quick run" })
    map("n", "<leader>cqs", ":CMakeQuickStart<CR>", { silent = true, desc = "[CMake]: Quick start" })
    map("n", "<leader>cl", ":CMakeLaunchArgs<CR>", { silent = true, desc = "[CMake]: Launch args" })
    map("n", "<leader>crr", ":CMakeRun<CR>", { silent = true, desc = "[CMake]: Run" })
    map("n", "<leader>crf", ":CMakeRunCurrentFile<CR>", { silent = true, desc = "[CMake]: Run current file" })
    map("n", "<leader>crt", ":CMakeRunTest<CR>", { silent = true, desc = "[CMake]: Run Test" })
    map("n", "<leader>ccl", ":CMakeClean<CR>", { silent = true, desc = "[CMake]: Clean" })
    map("n", "<leader>cce", ":CMakeCloseExecutor<CR>", { silent = true, desc = "[CMake]: Close Executor" })
    map("n", "<leader>ccr", ":CMakeCloseRunner<CR>", { silent = true, desc = "[CMake]: Close Runner" })
    map("n", "<leader>cor", ":CMakeOpenExecutor<CR>", { silent = true, desc = "[CMake]: Open Executor" })
    map("n", "<leader>coe", ":CMakeOpenRunner<CR>", { silent = true, desc = "[CMake]: Open Runner" })
    map("n", "<leader>cssr", ":CMakeStopRunner<CR>", { silent = true, desc = "[CMake]: Stop Runner" })
    map("n", "<leader>csse", ":CMakeStopExecutor<CR>", { silent = true, desc = "[CMake]: Stop Executor" })
    map("n", "<leader>cssp", ":CMakeSelectBuildPreset<CR>", { silent = true, desc = "[CMake]: Select build preset" })
    map("n", "<leader>csst", ":CMakeSelectBuildTarget<CR>", { silent = true, desc = "[CMake]: Select build target" })
    map("n", "<leader>cssl", ":CMakeSelectLaunchTarget<CR>", { silent = true, desc = "[CMake]: Select launch target" })
    map("n", "<leader>cssb", ":CMakeSelectBuildType<CR>", { silent = true, desc = "[CMake]: Select build type" })
  end,
})

vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("CargoKeymaps", { clear = true }),
  pattern = "Cargo.toml",
  callback = function()
    local map = vim.keymap.set
    -- Crates
    map("n", "<leader>ct", function()
      require("crates").toggle()
    end, { silent = true, noremap = true, desc = "[Crates] toggle ui elements" })
    map("n", "<leader>cr", function()
      require("crates").reload()
    end, { silent = true, noremap = true, desc = "[Crates] reload data" })
    map("n", "<leader>cv", function()
      require("crates").show_popup()
    end, { silent = true, noremap = true, desc = "[Crates] show popup w/ crate details" })
    map("n", "<leader>cv", function()
      require("crates").show_versions_popup()
    end, { silent = true, noremap = true, desc = "[Crates] show popup (always show versions)" })
    map("n", "<leader>cf", function()
      require("crates").show_features_popup()
    end, { silent = true, noremap = true, desc = "[Crates] show popup (always show features)" })
    map("n", "<leader>cd", function()
      require("crates").show_dependencies_popup()
    end, { silent = true, noremap = true, desc = "[Crates] show popup (always show dependencies)" })
    map("n", "<leader>cul", function()
      require("crates").update_crate()
    end, { silent = true, noremap = true, desc = "[Crates] update crate on currline" })
    map("v", "<leader>cuv", function()
      require("crates").update_crates()
    end, { silent = true, noremap = true, desc = "[Crates] update visually selected crates" })
    map("n", "<leader>cua", function()
      require("crates").update_all_crates()
    end, { silent = true, noremap = true, desc = "[Crates] update all crates in curr buffr" })
    map("n", "<leader>cUl", function()
      require("crates").upgrade_crate()
    end, { silent = true, noremap = true, desc = "[Crates] upgrade crate on currline" })
    map("v", "<leader>cUv", function()
      require("crates").upgrade_crates()
    end, { silent = true, noremap = true, desc = "[Crates] upgrade visually selected crates" })
    map("n", "<leader>cUa", function()
      require("crates").upgrade_all_crates()
    end, { silent = true, noremap = true, desc = "[Crates] upgrade all crates in curr buffr" })
    map("n", "<leader>cx", function()
      require("crates").expand_plain_crate_to_inline_table()
    end, { silent = true, noremap = true, desc = "[Crates] expand crate declaration -> inline table" })
    map("n", "<leader>cX", function()
      require("crates").extract_crate_into_table()
    end, {
      silent = true,
      noremap = true,
      desc = "[Crates] extract crate declaration from dependency section -> table",
    })
    map("n", "<leader>cH", function()
      require("crates").open_homepage()
    end, { silent = true, noremap = true, desc = "[Crates] open homepage of the crate on currline" })
    map("n", "<leader>cR", function()
      require("crates").open_repository()
    end, { silent = true, noremap = true, desc = "[Crates] open repo of the crate on currline" })
    map("n", "<leader>cD", function()
      require("crates").open_documentation()
    end, { silent = true, noremap = true, desc = "[Crates] open documentation of the crate on currline" })
    map("n", "<leader>cC", function()
      require("crates").open_crates_io()
    end, { silent = true, noremap = true, desc = "[Crates] open crates.io of the crate on currline" })

    local function show_documentation()
      local filetype = vim.bo.filetype
      if vim.tbl_contains({ "vim", "help" }, filetype) then
        vim.cmd("h " .. vim.fn.expand "<cword>")
      elseif vim.tbl_contains({ "man" }, filetype) then
        vim.cmd("Man " .. vim.fn.expand "<cword>")
      elseif vim.fn.expand "%:t" == "Cargo.toml" and require("crates").popup_available() then
        require("crates").show_popup()
      else
        vim.lsp.buf.hover()
      end
    end

    map("n", "K", show_documentation, { silent = true })
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = vim.tbl_map(function(path)
    return vim.fs.normalize(vim.loop.fs_realpath(path))
  end, vim.fn.glob(vim.fn.stdpath "config" .. "/lua/**/*.lua", true, true, true)),
  group = vim.api.nvim_create_augroup("ReloadConfig", {}),

  callback = function(opts)
    local fp = vim.fn.fnamemodify(vim.fs.normalize(vim.api.nvim_buf_get_name(opts.buf)), ":r") --[[@as string]]
    local app_name = vim.env.NVIM_APPNAME and vim.env.NVIM_APPNAME or "nvim"
    local module = string.gsub(fp, "^.*/" .. app_name .. "/lua/", ""):gsub("/", ".")

    require("plenary.reload").reload_module "nvconfig"
    require("plenary.reload").reload_module "chadrc"
    require("plenary.reload").reload_module "base46"
    require("plenary.reload").reload_module(module)

    local config = require "nvconfig"

    require("plenary.reload").reload_module "nvchad.stl.utils"
    require("plenary.reload").reload_module("nvchad.stl." .. config.ui.statusline.theme)
    vim.opt.statusline = "%!v:lua.require('nvchad.stl." .. config.ui.statusline.theme .. "')()"

    if config.ui.tabufline.enabled then
      require("plenary.reload").reload_module "nvchad.tabufline.modules"
      vim.opt.tabline = "%!v:lua.require('nvchad.tabufline.modules')()"
    end

    require("base46").load_all_highlights()
  end,
})

vim.api.nvim_create_autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_buf_get_option(args.buf, "buftype")

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name "NvFilePost"

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end, 0)
    end
  end,
})

function autocmd.load_autocmds()
  local definitions = {
    lazy = {},
    bufs = {
      { "BufWritePre", "/tmp/*",         "setlocal noundofile" },
      { "BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile | set colorcolumn=72" },
      { "BufWritePre", "MERGE_MSG",      "setlocal noundofile" },
      { "BufWritePre", "*.tmp",          "setlocal noundofile" },
      { "BufWritePre", "*.bak",          "setlocal noundofile" },

      -- auto place to last edit
      {
        "BufReadPost",
        "*",
        [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],
      },
    },
    wins = {
      {
        "VimLeave",
        "*",
        [[if has('nvim') | wshada | else | wviminfo! | endif]],
      },
      -- Check if file changed when its window is focus, more eager than 'autoread'
      { "FocusGained", "* checktime" },
      -- Equalize window dimensions when resizing vim window
      { "VimResized",  "*",          [[tabdo wincmd =]] },
    },
    ft = {
      { "FileType", "markdown", "set wrap" },
      { "FileType", "make",     "set noexpandtab shiftwidth=8 softtabstop=0" },
      {
        "FileType",
        "*",
        [[setlocal formatoptions-=cro]],
      },
    },
    yank = {
      {
        "TextYankPost",
        "*",
        [[silent! lua vim.highlight.on_yank({higroup="Yank", timeout=100})]],
      },
    },
  }

  autocmd.nvim_create_augroups(definitions)
end

autocmd.load_autocmds()
