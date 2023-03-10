-- triggers CursorHold event faster
vim.opt.updatetime = 200

require("barbecue").setup({
  ---whether to attach navic to language servers automatically
  ---@type boolean
  attach_navic = true,

  ---whether to create winbar updater autocmd
  ---@type boolean
  create_autocmd = true,

  ---buftypes to enable winbar in
  ---@type string[]
  include_buftypes = { "" },

  ---filetypes not to enable winbar in
  ---@type string[]
  exclude_filetypes = { "gitcommit", "toggleterm" },

  modifiers = {
    ---filename modifiers applied to dirname
    ---@type string
    dirname = ":~:.",

    ---filename modifiers applied to basename
    ---@type string
    basename = "",
  },

  ---whether to display path to file
  ---@type boolean
  show_dirname = true,

  ---whether to replace file icon with the modified symbol when buffer is modified
  ---@type boolean
  show_modified = false,

  ---whether to show/use navic in the winbar
  ---@type boolean
  show_navic = true,

  ---returns a string to be shown at the end of winbar
  ---@type fun(bufnr: number): string

  custom_section = function() return "" end,
  ---`auto` uses your current colorscheme's theme or generates a theme based on it
  ---`string` is the theme name to be used (theme should be located under `barbecue.theme` module)
  ---`barbecue.Theme` is a table that overrides the `auto` theme detection/generation
  ---@type "auto"|string|barbecue.Theme
  theme = "auto",

  symbols = {
    ---modification indicator
    ---@type string
    modified = "●",

    ---truncation indicator
    ---@type string
    ellipsis = "…",

    ---entry separator
    ---@type string
    separator = "->",
  },

  ---icons for different context entry kinds
  ---`false` to disable kind icons
  ---@type table<string, string>|false
  kinds = {
    File = "",
    Module = "",
    Namespace = "",
    Package = "",
    Class = "",
    Method = "",
    Property = "",
    Field = "",
    Constructor = "",
    Enum = "",
    Interface = "",
    Function = "",
    Variable = "",
    Constant = "",
    String = "",
    Number = "",
    Boolean = "",
    Array = "",
    Object = "",
    Key = "",
    Null = "",
    EnumMember = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
  },
})

vim.api.nvim_create_autocmd({
  "WinResized",
  "BufWinEnter",
  "CursorHold",
  "InsertLeave",

  -- include these if you have set `show_modified` to `true`
  "BufWritePost",
  "TextChanged",
  "TextChangedI",
}, {
  group = vim.api.nvim_create_augroup("barbecue.updater", {}),
  callback = function()
    require("barbecue.ui").update()
  end,
})

-- require("barbecue").setup({
--   theme = {
--     -- this highlight is used to override other highlights
--     -- you can take advantage of its `bg` and set a background throughout your winbar
--     -- (e.g. basename will look like this: { fg = "#c0caf5", bold = true })
--     normal = { fg = "#c0caf5" },
--
--     -- these highlights correspond to symbols table from config
--     ellipsis = { fg = "#737aa2" },
--     separator = { fg = "#737aa2" },
--     modified = { fg = "#737aa2" },
--
--     -- these highlights represent the _text_ of three main parts of barbecue
--     dirname = { fg = "#737aa2" },
--     basename = { bold = true },
--     context = {},
--
--     -- these highlights are used for context/navic icons
--     context_file = { fg = "#ac8fe4" },
--     context_module = { fg = "#ac8fe4" },
--     context_namespace = { fg = "#ac8fe4" },
--     context_package = { fg = "#ac8fe4" },
--     context_class = { fg = "#ac8fe4" },
--     context_method = { fg = "#ac8fe4" },
--     context_property = { fg = "#ac8fe4" },
--     context_field = { fg = "#ac8fe4" },
--     context_constructor = { fg = "#ac8fe4" },
--     context_enum = { fg = "#ac8fe4" },
--     context_interface = { fg = "#ac8fe4" },
--     context_function = { fg = "#ac8fe4" },
--     context_variable = { fg = "#ac8fe4" },
--     context_constant = { fg = "#ac8fe4" },
--     context_string = { fg = "#ac8fe4" },
--     context_number = { fg = "#ac8fe4" },
--     context_boolean = { fg = "#ac8fe4" },
--     context_array = { fg = "#ac8fe4" },
--     context_object = { fg = "#ac8fe4" },
--     context_key = { fg = "#ac8fe4" },
--     context_null = { fg = "#ac8fe4" },
--     context_enum_member = { fg = "#ac8fe4" },
--     context_struct = { fg = "#ac8fe4" },
--     context_event = { fg = "#ac8fe4" },
--     context_operator = { fg = "#ac8fe4" },
--     context_type_parameter = { fg = "#ac8fe4" },
--   },
-- })
