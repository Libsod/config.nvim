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
      { "BufWritePre", "/tmp/*", "setlocal noundofile" },
      { "BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile" },
      { "BufWritePre", "MERGE_MSG", "setlocal noundofile" },
      { "BufWritePre", "*.tmp", "setlocal noundofile" },
      { "BufWritePre", "*.bak", "setlocal noundofile" },

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
      { "VimResized", "*", [[tabdo wincmd =]] },
    },
    ft = {
      { "FileType", "markdown", "set wrap" },
      { "FileType", "make", "set noexpandtab shiftwidth=8 softtabstop=0" },
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
        [[silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=150})]],
      },
    },
  }

  autocmd.nvim_create_augroups(definitions)
end

autocmd.load_autocmds()
