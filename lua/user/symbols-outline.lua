local opts = {
  highlight_hovered_item = true, -- Whether to highlight the currently hovered symbol (high cpu usage)
  show_guides = true,  -- 	Whether to show outline guides
  auto_preview = true, -- Show a preview of the code on hover
  position = 'right', --  Where to open the split window	'right' or 'left'	'right'
  relative_width = true,  --  Whether width of window is set relative to existing windows
  width = 25,  -- Width of window (as a % or columns based on relative_width)
  auto_close = false,  -- Whether to automatically close the window after selection
  show_numbers = false,  -- Shows numbers with the outline
  show_relative_numbers = false, --  Shows relative numbers with the outline
  show_symbol_details = true, -- Shows extra details with the symbols (lsp dependent)
  preview_bg_highlight = 'Pmenu',  -- Background color of the preview window
  winblend = 0, -- Pseudo-transparency of the preview window
  autofold_depth = nil,
  auto_unfold_hover = true, -- Automatically unfold hovered symbol
  fold_markers = { '', '' },
  wrap = false, -- Whether to wrap long lines, or let them flow off the window
  keymaps = { -- These keymaps can be a string or a table for multiple keys
    close = {"<Esc>", "q"},
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a",
    fold = "h",
    unfold = "l",
    fold_all = "W",
    unfold_all = "E",
    fold_reset = "R",
  },
  lsp_blacklist = {},
  symbol_blacklist = {},
  symbols = {
    File = {icon = "", hl = "TSURI"},
    Module = {icon = "", hl = "TSNamespace"},
    Namespace = {icon = "", hl = "TSNamespace"},
    Package = {icon = "", hl = "TSNamespace"},
    Class = {icon = "𝓒", hl = "TSType"},
    Method = {icon = "ƒ", hl = "TSMethod"},
    Property = {icon = "", hl = "TSMethod"},
    Field = {icon = "", hl = "TSField"},
    Constructor = {icon = "", hl = "TSConstructor"},
    Enum = {icon = "ℰ", hl = "TSType"},
    Interface = {icon = "ﰮ", hl = "TSType"},
    Function = {icon = "", hl = "TSFunction"},
    Variable = {icon = "", hl = "TSConstant"},
    Constant = {icon = "", hl = "TSConstant"},
    String = {icon = "𝓐", hl = "TSString"},
    Number = {icon = "#", hl = "TSNumber"},
    Boolean = {icon = "⊨", hl = "TSBoolean"},
    Array = {icon = "", hl = "TSConstant"},
    Object = {icon = "⦿", hl = "TSType"},
    Key = {icon = "🔐", hl = "TSType"},
    Null = {icon = "NULL", hl = "TSType"},
    EnumMember = {icon = "", hl = "TSField"},
    Struct = {icon = "𝓢", hl = "TSType"},
    Event = {icon = "🗲", hl = "TSType"},
    Operator = {icon = "+", hl = "TSOperator"},
    Component = { icon = "", hl = "@function" },
    Fragment = { icon = "", hl = "@constant" },
    TypeParameter = {icon = "𝙏", hl = "TSParameter"}
  }
}

require("symbols-outline").setup()


