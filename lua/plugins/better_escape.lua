return {
  timeout = vim.o.timeoutlen,
  default_mappings = true,
  mappings = {
    i = {
      j = {
        -- These can all also be functions
        k = "<Esc>",
        j = "<Esc>",
      },
    },
    c = {
      j = {
        k = "<Esc>",
        j = "<Esc>",
      },
    },
    t = false,
    v = {
      j = {
        k = "<Esc>",
      },
    },
    s = {
      j = {
        k = "<Esc>",
      },
    },
  },
}
