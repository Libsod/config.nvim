local options = {
  adapters = {
    -- Zig
    require "neotest-zig",

    -- Rust
    require "rustaceanvim.neotest",

    -- Python
    require "neotest-python" {
      runner = "python-unittest",
    },
  },
}

return require("neotest").setup(options)
