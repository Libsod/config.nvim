-- This file dynamically scans its own directory for other Lua files (excluding itself)
-- and attempts to load them as server-specific LSP configurations.
-- It aggregates these configurations into a single table, where keys are
-- server names (derived from filenames) and values are their respective config tables.

local M = {}

-- Defines the directory path where individual LSP server configuration files are located.
-- This is typically 'lua/configs/lsp/servers/' within your Neovim configuration directory.
local cfg_dir = vim.fn.stdpath "config" .. "/lua/configs/lsp/servers"

-- Attempts to scan the specified directory for its contents.
local scan_handle = vim.loop.fs_scandir(cfg_dir)

-- Proceeds only if the directory scanning was successful (scan_handle is not nil).
if scan_handle then
  -- Continuously read entries from the scanned directory.
  while true do
    -- Retrieves the next entry's name and type (file, directory, etc.).
    local name, entry_type = vim.loop.fs_scandir_next(scan_handle)

    -- If 'name' is nil, it means there are no more entries in the directory, so break the loop.
    if not name then
      break
    end

    -- Processes the entry only if it's a file, ends with '.lua', and is not 'init.lua' (this file itself).
    if entry_type == "file" and name:match "(.+)%.lua$" and name ~= "init.lua" then
      -- Extracts the module name from the filename (e.g., "clangd.lua" -> "clangd").
      local module_name = name:match "(.+)%.lua$"

      -- Safely attempts to require the discovered Lua module.
      -- `pcall` (protected call) prevents errors in one server config file from crashing the entire setup.
      local require_ok, server_config = pcall(require, "configs.lsp.servers." .. module_name)

      -- If the module was required successfully and it returned a table,
      -- add this configuration table to the main module 'M' using the module_name as the key.
      if require_ok and type(server_config) == "table" then
        M[module_name] = server_config
      elseif not require_ok then
        -- Optionally, log an error if a server configuration file fails to load.
        vim.notify(
          "Failed to load LSP server config: configs.lsp.servers."
            .. module_name
            .. "\nError: "
            .. tostring(server_config),
          vim.log.levels.WARN
        )
      end
    end
  end
end

return M
