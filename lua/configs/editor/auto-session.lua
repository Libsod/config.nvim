local options = {
  auto_restore_enabled = false,
  auto_save_enabled = true,
  auto_session_suppress_dirs = { "~/", "~/dev", "~/Downloads", "/" },

  session_lens = {
    load_on_setup = true,
    theme_conf = { border = true },
  },
}

return require("auto-session").setup(options)
