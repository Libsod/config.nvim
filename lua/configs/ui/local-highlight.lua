local options = {
  file_types = nil,
  hlgroup = "Search",
  cw_hlgroup = nil,
  insert_mode = false,
  min_match_len = 1,
  max_match_len = math.huge,
  highlight_single_match = false,
}

return require("local-highlight").setup(options)
