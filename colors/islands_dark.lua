vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "islands-dark"

local function parse(hex)
    local r, g, b, a = hex:match("^#(%x%x)(%x%x)(%x%x)(%x*)$")
    return tonumber(r, 16), tonumber(g, 16), tonumber(b, 16), (a ~= "" and tonumber(a, 16) / 255 or 1)
end

local function over(color, base)
    local r, g, b, a = parse(color)
    if a >= 1 then
        return string.format("#%02x%02x%02x", r, g, b)
    end
    local br, bgc, bb = parse(base)
    local function m(f, t)
        return math.floor(f * a + t * (1 - a) + 0.5)
    end
    return string.format("#%02x%02x%02x", m(r, br), m(g, bgc), m(b, bb))
end

local function set(name, opts)
    vim.api.nvim_set_hl(0, name, opts)
end

local function link(from, to)
    vim.api.nvim_set_hl(0, from, { link = to })
end

-- ---------------------------------------------------------------------------
-- palette 
-- ---------------------------------------------------------------------------
local P = {
    chrome = "#191a1c", -- background, tab_bar, title_bar, status_bar, terminal.background
    bg = "#1e1f22", -- editor.background, surface, panel, tab.active
    elevated = "#2b2d30", -- elevated_surface, element.background, border, editor.subheader
    border = "#2b2d30",
    fg = "#bcbec4", -- text, editor.foreground, syntax.primary
    fg_bright = "#ced0d6", -- terminal.bright_foreground
    muted = "#6f737a", -- text.muted, hint, ignored(vc)
    disabled = "#4e5157", -- text.disabled, editor.invisible, ignored

    blue = "#56a8f5", -- accent, function, info, modified
    red = "#f75464", -- error, deleted
    green = "#6aab73", -- string, success, created
    yellow = "#e0bb65", -- warning
    magenta = "#c77dbb", -- constant, property, conflict
    cyan = "#2aacb8", -- number, renamed
    orange = "#cf8e6d", -- keyword, boolean, tag, escape
    teal = "#16baae", -- syntax.enum
    olive = "#b3ae60", -- syntax.attribute
    comment = "#7a7e85", -- syntax.comment, syntax.predictive
    doc = "#5f826b", -- syntax.comment.doc
    str_special = "#73bd79", -- syntax.string.special
    regex = "#42c3d4", -- syntax.string.regex
    bright_blue = "#70aeff", -- link_text.hover

    sel = "#2d4f77", -- element.selected / ghost_element.selected
    hover = "#343538", -- element.hover
    active = "#404244", -- element.active
    ln = "#4b5059", -- editor.line_number
    ln_active = "#a1a3ab", -- editor.active_line_number
    guide = "#323438", -- editor.indent_guide
    guide_active = "#4e5157", -- editor.indent_guide_active
    wrap = "#2d2f34", -- editor.wrap_guide
    panel_guide = "#393b40", -- panel.indent_guide / editor.active_wrap_guide
}

-- half transparent, blend with zed colors
local B = {
    cursorline = over("#2b2d3280", P.bg), -- editor.active_line.background
    visual = over("#56a8f53d", P.bg), -- players[0].selection
    search = over("#56a8f540", P.bg), -- search.match_background
    search_cur = over("#56a8f580", P.bg), -- search.active_match_background
    ref_read = over("#56a8f520", P.bg), -- editor.document_highlight.read_background
    ref_write = over("#56a8f530", P.bg), -- editor.document_highlight.write_background
    bracket = over("#56a8f520", P.bg), -- editor.document_highlight.bracket_background
    diff_add = over("#6aab7320", P.bg), -- editor.diff_hunk.added.background
    diff_del = over("#f7546420", P.bg), -- editor.diff_hunk.deleted.background
    diff_chg = over("#56a8f520", P.bg), -- modified.background
    diff_txt = over("#56a8f540", P.bg),
    word_add = over("#6aab7340", P.bg), -- version_control.word_added
    word_del = over("#f7546440", P.bg), -- version_control.word_deleted
    err_bg = over("#f7546420", P.bg), -- error.background
    warn_bg = over("#e0bb6520", P.bg), -- warning.background
    info_bg = over("#56a8f520", P.bg), -- info.background
    hint_bg = over("#6f737a20", P.bg), -- hint.background
    ok_bg = over("#6aab7320", P.bg), -- success.background
    conflict_bg = over("#c77dbb20", P.bg),
    conflict_ours = over("#6aab7330", P.bg),
    conflict_theirs = over("#56a8f530", P.bg),
    inlay = over("#85704280", P.bg), -- syntax.hint (80 alpha)
    del_border = over("#f7546450", P.bg),
    thumb = over("#bcbec440", P.elevated), -- scrollbar.thumb.hover_background
    err_border = over("#f7546450", P.elevated),
    warn_border = over("#e0bb6550", P.elevated),
    info_border = over("#56a8f550", P.elevated),
    hint_border = over("#6f737a50", P.elevated),
    ok_border = over("#6aab7350", P.elevated),
}

-- ---------------------------------------------------------------------------
-- terminal (terminal.ansi.*)
-- ---------------------------------------------------------------------------
local ansi = {
    "#191a1c", "#f75464", "#6aab73", "#e0bb65", "#56a8f5", "#c77dbb", "#2aacb8", "#bcbec4",
    "#6f737a", "#fa6675", "#73bd79", "#f2c55c", "#70aeff", "#cf84cf", "#42c3d4", "#ced0d6",
}
for i, c in ipairs(ansi) do
    vim.g["terminal_color_" .. (i - 1)] = c
end

-- ---------------------------------------------------------------------------
-- editor UI
-- ---------------------------------------------------------------------------
local ui = {
    Normal = { fg = P.fg, bg = P.bg },
    NormalNC = { fg = P.fg, bg = P.bg },
    NormalFloat = { fg = P.fg, bg = P.elevated },
    FloatBorder = { fg = P.border, bg = P.elevated },
    FloatTitle = { fg = P.blue, bg = P.elevated, bold = true },
    FloatFooter = { fg = P.muted, bg = P.elevated },
    MsgArea = { fg = P.fg, bg = P.bg },
    MsgSeparator = { fg = P.border, bg = P.chrome },

    Cursor = { fg = P.bg, bg = P.blue },
    lCursor = { fg = P.bg, bg = P.blue },
    CursorIM = { fg = P.bg, bg = P.blue },
    TermCursor = { fg = P.bg, bg = P.blue },
    TermCursorNC = { fg = P.bg, bg = P.muted },

    CursorLine = { bg = B.cursorline },
    CursorColumn = { bg = B.cursorline },
    ColorColumn = { bg = P.wrap },
    CursorLineNr = { fg = P.ln_active, bold = false },
    LineNr = { fg = P.ln },
    LineNrAbove = { fg = P.ln },
    LineNrBelow = { fg = P.ln },
    SignColumn = { fg = P.ln, bg = P.bg },
    FoldColumn = { fg = P.ln, bg = P.bg },
    CursorLineSign = { bg = P.bg },
    CursorLineFold = { fg = P.ln_active, bg = P.bg },
    Folded = { fg = P.muted, bg = P.elevated },
    EndOfBuffer = { fg = P.bg },

    Visual = { bg = B.visual },
    VisualNOS = { bg = B.visual },
    Search = { bg = B.search },
    CurSearch = { bg = B.search_cur },
    IncSearch = { bg = B.search_cur },
    Substitute = { bg = B.search_cur },
    MatchParen = { bg = B.bracket },
    QuickFixLine = { bg = P.sel },
    SnippetTabstop = { bg = B.ref_write },

    Pmenu = { fg = P.fg, bg = P.elevated },
    PmenuSel = { fg = P.fg, bg = P.sel },
    PmenuKind = { fg = P.muted, bg = P.elevated },
    PmenuKindSel = { fg = P.muted, bg = P.sel },
    PmenuExtra = { fg = P.muted, bg = P.elevated },
    PmenuExtraSel = { fg = P.muted, bg = P.sel },
    PmenuSbar = { bg = P.elevated },
    PmenuThumb = { bg = B.thumb },
    PmenuMatch = { fg = P.blue, bg = P.elevated },
    PmenuMatchSel = { fg = P.blue, bg = P.sel },
    ComplMatchIns = { fg = P.muted },
    WildMenu = { fg = P.fg, bg = P.sel },

    StatusLine = { fg = P.fg, bg = P.chrome },
    StatusLineNC = { fg = P.muted, bg = P.chrome },
    StatusLineTerm = { fg = P.fg, bg = P.chrome },
    StatusLineTermNC = { fg = P.muted, bg = P.chrome },
    TabLine = { fg = P.muted, bg = P.chrome },
    TabLineSel = { fg = P.fg, bg = P.bg },
    TabLineFill = { bg = P.chrome },
    WinBar = { fg = P.fg, bg = P.bg },
    WinBarNC = { fg = P.muted, bg = P.bg },
    WinSeparator = { fg = P.border, bg = P.bg },
    VertSplit = { fg = P.border, bg = P.bg },

    NonText = { fg = P.disabled },
    Whitespace = { fg = P.disabled },
    SpecialKey = { fg = P.disabled },
    Conceal = { fg = P.muted },
    Directory = { fg = P.blue },
    Title = { fg = P.blue, bold = true },
    ErrorMsg = { fg = P.red },
    WarningMsg = { fg = P.yellow },
    MoreMsg = { fg = P.green },
    ModeMsg = { fg = P.fg },
    Question = { fg = P.blue },
    Error = { fg = P.red },
    Underlined = { underline = true },
    Ignore = { fg = P.disabled },
    SpellBad = { undercurl = true, sp = P.red },
    SpellCap = { undercurl = true, sp = P.yellow },
    SpellRare = { undercurl = true, sp = P.blue },
    SpellLocal = { undercurl = true, sp = P.muted },
    Terminal = { fg = P.fg, bg = P.chrome },

    -- diff
    DiffAdd = { bg = B.diff_add },
    DiffDelete = { fg = B.del_border, bg = B.diff_del },
    DiffChange = { bg = B.diff_chg },
    DiffText = { bg = B.diff_txt },
    Added = { fg = P.green },
    Removed = { fg = P.red },
    Changed = { fg = P.blue },
    diffAdded = { fg = P.green },
    diffRemoved = { fg = P.red },
    diffChanged = { fg = P.blue },
    diffOldFile = { fg = P.red },
    diffNewFile = { fg = P.green },
    diffFile = { fg = P.blue },
    diffLine = { fg = P.muted },
    diffIndexLine = { fg = P.muted },
}
for name, opts in pairs(ui) do
    set(name, opts)
end

-- ---------------------------------------------------------------------------
-- legacy (vim syntax) groups
-- ---------------------------------------------------------------------------
local legacy = {
    Comment = { fg = P.comment, italic = true },
    SpecialComment = { fg = P.doc, italic = true },
    Todo = { fg = P.comment, italic = true },
    Constant = { fg = P.magenta, italic = true },
    String = { fg = P.green },
    Character = { fg = P.green },
    Number = { fg = P.cyan },
    Float = { fg = P.cyan },
    Boolean = { fg = P.orange },
    Identifier = { fg = P.fg },
    Function = { fg = P.blue },
    Statement = { fg = P.orange },
    Conditional = { fg = P.orange },
    Repeat = { fg = P.orange },
    Label = { fg = P.blue },
    Operator = { fg = P.fg },
    Keyword = { fg = P.orange },
    Exception = { fg = P.orange },
    PreProc = { fg = P.orange },
    Include = { fg = P.orange },
    Define = { fg = P.orange },
    Macro = { fg = P.orange },
    PreCondit = { fg = P.orange },
    Type = { fg = P.fg },
    StorageClass = { fg = P.orange },
    Structure = { fg = P.orange },
    Typedef = { fg = P.orange },
    Special = { fg = P.orange },
    SpecialChar = { fg = P.orange },
    Tag = { fg = P.orange },
    Delimiter = { fg = P.fg },
    Debug = { fg = P.orange },
}
for name, opts in pairs(legacy) do
    set(name, opts)
end

-- ---------------------------------------------------------------------------
-- Treesitter (Neovim >= 0.10 names)
-- ---------------------------------------------------------------------------
local ts = {
    ["@variable"] = { fg = P.fg },
    ["@variable.builtin"] = { fg = P.orange }, -- syntax.variable.special
    ["@variable.parameter"] = { fg = P.fg },
    ["@variable.parameter.builtin"] = { fg = P.orange },
    ["@variable.member"] = { fg = P.magenta }, -- syntax.property

    ["@constant"] = { fg = P.magenta, italic = true },
    ["@constant.builtin"] = { fg = P.magenta, italic = true },
    ["@constant.macro"] = { fg = P.magenta, italic = true },

    ["@module"] = { fg = P.fg }, -- syntax.namespace
    ["@module.builtin"] = { fg = P.fg },
    ["@label"] = { fg = P.blue },

    ["@string"] = { fg = P.green },
    ["@string.documentation"] = { fg = P.green },
    ["@string.regexp"] = { fg = P.regex },
    ["@string.escape"] = { fg = P.orange },
    ["@string.special"] = { fg = P.str_special },
    ["@string.special.symbol"] = { fg = P.orange },
    ["@string.special.path"] = { fg = P.str_special },
    ["@string.special.url"] = { fg = P.blue },
    ["@character"] = { fg = P.green },
    ["@character.special"] = { fg = P.orange },

    ["@boolean"] = { fg = P.orange },
    ["@number"] = { fg = P.cyan },
    ["@number.float"] = { fg = P.cyan },

    ["@type"] = { fg = P.fg },
    ["@type.builtin"] = { fg = P.fg },
    ["@type.definition"] = { fg = P.fg },
    ["@type.qualifier"] = { fg = P.orange },

    ["@attribute"] = { fg = P.olive },
    ["@attribute.builtin"] = { fg = P.olive },
    ["@property"] = { fg = P.magenta },

    ["@function"] = { fg = P.blue },
    ["@function.builtin"] = { fg = P.blue },
    ["@function.call"] = { fg = P.blue },
    ["@function.macro"] = { fg = P.blue },
    ["@function.method"] = { fg = P.blue },
    ["@function.method.call"] = { fg = P.blue },
    ["@constructor"] = { fg = P.blue },
    ["@operator"] = { fg = P.fg },

    ["@keyword"] = { fg = P.orange },
    ["@keyword.coroutine"] = { fg = P.orange },
    ["@keyword.function"] = { fg = P.orange },
    ["@keyword.operator"] = { fg = P.orange },
    ["@keyword.import"] = { fg = P.orange },
    ["@keyword.type"] = { fg = P.orange },
    ["@keyword.modifier"] = { fg = P.orange },
    ["@keyword.repeat"] = { fg = P.orange },
    ["@keyword.return"] = { fg = P.orange },
    ["@keyword.debug"] = { fg = P.orange },
    ["@keyword.exception"] = { fg = P.orange },
    ["@keyword.conditional"] = { fg = P.orange },
    ["@keyword.conditional.ternary"] = { fg = P.orange },
    ["@keyword.directive"] = { fg = P.orange }, -- syntax.preproc
    ["@keyword.directive.define"] = { fg = P.orange },

    ["@punctuation"] = { fg = P.fg },
    ["@punctuation.delimiter"] = { fg = P.fg },
    ["@punctuation.bracket"] = { fg = P.fg },
    ["@punctuation.special"] = { fg = P.fg },

    ["@comment"] = { fg = P.comment, italic = true },
    ["@comment.documentation"] = { fg = P.doc, italic = true },
    ["@comment.error"] = { fg = P.comment, italic = true },
    ["@comment.warning"] = { fg = P.comment, italic = true },
    ["@comment.todo"] = { fg = P.comment, italic = true },
    ["@comment.note"] = { fg = P.comment, italic = true },

    ["@markup"] = { fg = P.fg },
    ["@markup.strong"] = { fg = P.orange, bold = true }, -- syntax.emphasis.strong
    ["@markup.italic"] = { fg = P.orange, italic = true }, -- syntax.emphasis
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.heading"] = { fg = P.blue, bold = true }, -- syntax.title
    ["@markup.heading.1"] = { fg = P.blue, bold = true },
    ["@markup.heading.2"] = { fg = P.blue, bold = true },
    ["@markup.heading.3"] = { fg = P.blue, bold = true },
    ["@markup.heading.4"] = { fg = P.blue, bold = true },
    ["@markup.heading.5"] = { fg = P.blue, bold = true },
    ["@markup.heading.6"] = { fg = P.blue, bold = true },
    ["@markup.quote"] = { fg = P.fg },
    ["@markup.math"] = { fg = P.fg },
    ["@markup.link"] = { fg = P.green }, -- syntax.link_text
    ["@markup.link.label"] = { fg = P.green },
    ["@markup.link.url"] = { fg = P.blue }, -- syntax.link_uri
    ["@markup.raw"] = { fg = P.green }, -- syntax.text.literal
    ["@markup.raw.block"] = { fg = P.green },
    ["@markup.list"] = { fg = P.fg }, -- syntax.punctuation.list_marker
    ["@markup.list.checked"] = { fg = P.green },
    ["@markup.list.unchecked"] = { fg = P.muted },

    ["@diff.plus"] = { fg = P.green },
    ["@diff.minus"] = { fg = P.red },
    ["@diff.delta"] = { fg = P.blue },

    ["@tag"] = { fg = P.orange },
    ["@tag.builtin"] = { fg = P.orange },
    ["@tag.attribute"] = { fg = P.olive },
    ["@tag.delimiter"] = { fg = P.fg },

    -- CSS: syntax.selector / selector.pseudo
    ["@tag.css"] = { fg = P.blue },
    ["@tag.scss"] = { fg = P.blue },
    ["@type.css"] = { fg = P.blue },
    ["@type.scss"] = { fg = P.blue },

    ["@embedded"] = { fg = P.fg },
    ["@none"] = {},
    ["@spell"] = {},
    ["@nospell"] = {},
}
for name, opts in pairs(ts) do
    set(name, opts)
end

-- old names (nvim-treesitter / Neovim 0.8-0.9)
local legacy_ts = {
    ["@field"] = "@variable.member",
    ["@namespace"] = "@module",
    ["@parameter"] = "@variable.parameter",
    ["@method"] = "@function.method",
    ["@method.call"] = "@function.method.call",
    ["@conditional"] = "@keyword.conditional",
    ["@repeat"] = "@keyword.repeat",
    ["@include"] = "@keyword.import",
    ["@exception"] = "@keyword.exception",
    ["@storageclass"] = "@keyword.modifier",
    ["@define"] = "@keyword.directive.define",
    ["@preproc"] = "@keyword.directive",
    ["@float"] = "@number.float",
    ["@symbol"] = "@string.special.symbol",
    ["@variable.global"] = "@variable.builtin",
    ["@text"] = "@markup",
    ["@text.strong"] = "@markup.strong",
    ["@text.emphasis"] = "@markup.italic",
    ["@text.underline"] = "@markup.underline",
    ["@text.strike"] = "@markup.strikethrough",
    ["@text.title"] = "@markup.heading",
    ["@text.literal"] = "@markup.raw",
    ["@text.uri"] = "@markup.link.url",
    ["@text.reference"] = "@markup.link.label",
    ["@text.todo"] = "@comment.todo",
    ["@text.note"] = "@comment.note",
    ["@text.warning"] = "@comment.warning",
    ["@text.danger"] = "@comment.error",
    ["@text.diff.add"] = "@diff.plus",
    ["@text.diff.delete"] = "@diff.minus",
    ["@string.regex"] = "@string.regexp",
    ["@debug"] = "@keyword.debug",
    ["@type.enum"] = "@lsp.type.enum",
}
for from, to in pairs(legacy_ts) do
    link(from, to)
end

-- ---------------------------------------------------------------------------
-- LSP: semantic tokens, references, inlay hints, code lens
-- ---------------------------------------------------------------------------
set("@lsp.type.enum", { fg = P.teal }) -- syntax.enum
set("@lsp.type.enumMember", { fg = P.orange }) -- syntax.variant
set("@lsp.type.selfKeyword", { fg = P.orange })
set("@lsp.type.selfTypeKeyword", { fg = P.orange })
link("@lsp.type.macro", "@function.macro")
link("@lsp.type.decorator", "@attribute")
link("@lsp.type.builtinType", "@type.builtin")
link("@lsp.type.namespace", "@module")
link("@lsp.type.property", "@property")
link("@lsp.type.parameter", "@variable.parameter")
link("@lsp.type.variable", "@variable")
link("@lsp.type.function", "@function")
link("@lsp.type.method", "@function.method")
link("@lsp.type.comment", "@comment")
link("@lsp.type.keyword", "@keyword")
link("@lsp.type.string", "@string")
link("@lsp.type.number", "@number")
link("@lsp.type.operator", "@operator")
link("@lsp.type.regexp", "@string.regexp")
link("@lsp.type.class", "@type")
link("@lsp.type.interface", "@type")
link("@lsp.type.struct", "@type")
link("@lsp.type.type", "@type")
link("@lsp.type.typeParameter", "@type.definition")
link("@lsp.typemod.variable.defaultLibrary", "@variable.builtin")
link("@lsp.typemod.function.defaultLibrary", "@function.builtin")
link("@lsp.typemod.method.defaultLibrary", "@function.builtin")

set("LspReferenceText", { bg = B.ref_read })
set("LspReferenceRead", { bg = B.ref_read })
set("LspReferenceWrite", { bg = B.ref_write })
set("LspReferenceTarget", { bg = B.ref_write })
set("LspInlayHint", { fg = B.inlay, italic = true })
set("LspCodeLens", { fg = P.muted })
set("LspCodeLensSeparator", { fg = P.disabled })
set("LspSignatureActiveParameter", { fg = P.blue, bold = true, underline = true })
set("LspInfoBorder", { fg = P.border, bg = P.elevated })

-- ---------------------------------------------------------------------------
-- diagnostics
-- ---------------------------------------------------------------------------
local diag = {
    Error = { P.red, B.err_bg },
    Warn = { P.yellow, B.warn_bg },
    Info = { P.blue, B.info_bg },
    Hint = { P.muted, B.hint_bg },
    Ok = { P.green, B.ok_bg },
}
for kind, v in pairs(diag) do
    set("Diagnostic" .. kind, { fg = v[1] })
    set("DiagnosticVirtualText" .. kind, { fg = v[1], bg = v[2] })
    set("DiagnosticFloating" .. kind, { fg = v[1] })
    set("DiagnosticSign" .. kind, { fg = v[1] })
    set("DiagnosticUnderline" .. kind, { undercurl = true, sp = v[1] })
end
set("DiagnosticUnnecessary", { fg = P.muted }) -- unreachable
set("DiagnosticDeprecated", { strikethrough = true, sp = P.muted })

-- ---------------------------------------------------------------------------
-- ===== PLUGINS =====
-- ---------------------------------------------------------------------------

-- gitsigns.nvim ------------------------------------------------------------
local gs = {
    GitSignsAdd = { fg = P.green },
    GitSignsChange = { fg = P.blue },
    GitSignsDelete = { fg = P.red },
    GitSignsTopdelete = { fg = P.red },
    GitSignsChangedelete = { fg = P.blue },
    GitSignsUntracked = { fg = P.green },
    GitSignsAddNr = { fg = P.green },
    GitSignsChangeNr = { fg = P.blue },
    GitSignsDeleteNr = { fg = P.red },
    GitSignsTopdeleteNr = { fg = P.red },
    GitSignsChangedeleteNr = { fg = P.blue },
    GitSignsUntrackedNr = { fg = P.green },
    GitSignsAddLn = { bg = B.diff_add },
    GitSignsChangeLn = { bg = B.diff_chg },
    GitSignsDeleteLn = { bg = B.diff_del },
    GitSignsUntrackedLn = { bg = B.diff_add },
    GitSignsAddInline = { bg = B.word_add },
    GitSignsChangeInline = { bg = B.diff_txt },
    GitSignsDeleteInline = { bg = B.word_del },
    GitSignsAddLnInline = { bg = B.word_add },
    GitSignsChangeLnInline = { bg = B.diff_txt },
    GitSignsDeleteLnInline = { bg = B.word_del },
    GitSignsAddPreview = { fg = P.green, bg = B.diff_add },
    GitSignsDeletePreview = { fg = P.red, bg = B.diff_del },
    GitSignsDeleteVirtLn = { bg = B.diff_del },
    GitSignsDeleteVirtLnInLine = { bg = B.word_del },
    GitSignsVirtLnum = { fg = P.ln },
    GitSignsCurrentLineBlame = { fg = P.muted, italic = true },
    -- staged: производные (приглушённые версии version_control.*)
    GitSignsStagedAdd = { fg = over("#6aab7380", P.bg) },
    GitSignsStagedChange = { fg = over("#56a8f580", P.bg) },
    GitSignsStagedDelete = { fg = over("#f7546480", P.bg) },
    GitSignsStagedTopdelete = { fg = over("#f7546480", P.bg) },
    GitSignsStagedChangedelete = { fg = over("#56a8f580", P.bg) },
}
for name, opts in pairs(gs) do
    set(name, opts)
end

-- telescope.nvim -----------------------------------------------------------
local tele = {
    TelescopeNormal = { fg = P.fg, bg = P.elevated },
    TelescopeBorder = { fg = P.border, bg = P.elevated },
    TelescopeTitle = { fg = P.blue, bold = true },
    TelescopePromptNormal = { fg = P.fg, bg = P.elevated },
    TelescopePromptBorder = { fg = P.border, bg = P.elevated },
    TelescopePromptTitle = { fg = P.blue, bold = true },
    TelescopePromptPrefix = { fg = P.blue },
    TelescopePromptCounter = { fg = P.muted },
    TelescopeResultsNormal = { fg = P.fg, bg = P.elevated },
    TelescopeResultsBorder = { fg = P.border, bg = P.elevated },
    TelescopeResultsTitle = { fg = P.blue },
    TelescopePreviewNormal = { fg = P.fg, bg = P.elevated },
    TelescopePreviewBorder = { fg = P.border, bg = P.elevated },
    TelescopePreviewTitle = { fg = P.blue },
    TelescopeSelection = { fg = P.fg, bg = P.sel },
    TelescopeSelectionCaret = { fg = P.blue, bg = P.sel },
    TelescopeMultiSelection = { fg = P.yellow },
    TelescopeMatching = { fg = P.blue, bold = true },
    TelescopeResultsDiffAdd = { fg = P.green },
    TelescopeResultsDiffChange = { fg = P.blue },
    TelescopeResultsDiffDelete = { fg = P.red },
    TelescopeResultsDiffUntracked = { fg = P.muted },
    TelescopeResultsComment = { fg = P.comment },
}
for name, opts in pairs(tele) do
    set(name, opts)
end

-- fzf-lua ------------------------------------------------------------------
local fzf = {
    FzfLuaNormal = { fg = P.fg, bg = P.elevated },
    FzfLuaBorder = { fg = P.border, bg = P.elevated },
    FzfLuaTitle = { fg = P.blue, bold = true },
    FzfLuaPreviewNormal = { fg = P.fg, bg = P.elevated },
    FzfLuaPreviewBorder = { fg = P.border, bg = P.elevated },
    FzfLuaPreviewTitle = { fg = P.blue },
    FzfLuaCursor = { fg = P.bg, bg = P.blue },
    FzfLuaCursorLine = { bg = P.sel },
    FzfLuaCursorLineNr = { fg = P.ln_active, bg = P.sel },
    FzfLuaSearch = { bg = B.search_cur },
    FzfLuaScrollBorderFull = { fg = P.muted },
    FzfLuaScrollFloatFull = { fg = P.muted },
    FzfLuaHeaderBind = { fg = P.orange },
    FzfLuaHeaderText = { fg = P.red },
    FzfLuaBufNr = { fg = P.yellow },
    FzfLuaBufFlagCur = { fg = P.red },
    FzfLuaBufFlagAlt = { fg = P.blue },
    FzfLuaTabTitle = { fg = P.cyan },
    FzfLuaTabMarker = { fg = P.yellow },
    FzfLuaLivePrompt = { fg = P.orange },
}
for name, opts in pairs(fzf) do
    set(name, opts)
end

-- yazi ---------------------------------------------------------------------
local yazi = {
    YaziFloat = { fg = P.fg, bg = P.elevated },
    YaziFloatBorder = { fg = P.border, bg = P.elevated },
}
for name, opts in pairs(yazi) do
    set(name, opts)
end

-- nvim-cmp / blink.cmp -----------------------------------------------------
local kinds = {
    Text = P.fg, Method = P.blue, Function = P.blue, Constructor = P.blue,
    Field = P.magenta, Variable = P.fg, Class = P.fg, Interface = P.fg,
    Module = P.fg, Property = P.magenta, Unit = P.cyan, Value = P.cyan,
    Enum = P.teal, Keyword = P.orange, Snippet = P.green, Color = P.magenta,
    File = P.fg, Reference = P.fg, Folder = P.blue, EnumMember = P.orange,
    Constant = P.magenta, Struct = P.fg, Event = P.yellow, Operator = P.fg,
    TypeParameter = P.fg, Copilot = P.green, Codeium = P.green, Supermaven = P.green,
    TabNine = P.green, Namespace = P.fg, Package = P.fg, String = P.green,
    Number = P.cyan, Boolean = P.orange, Array = P.fg, Object = P.fg, Key = P.magenta, Null = P.magenta,
}
for name, color in pairs(kinds) do
    set("CmpItemKind" .. name, { fg = color })
    set("BlinkCmpKind" .. name, { fg = color })
end
local cmp = {
    CmpNormal = { fg = P.fg, bg = P.elevated },
    CmpPmenu = { fg = P.fg, bg = P.elevated },
    CmpBorder = { fg = P.border, bg = P.elevated },
    CmpDocNormal = { fg = P.fg, bg = P.elevated },
    CmpDocBorder = { fg = P.border, bg = P.elevated },
    CmpItemAbbr = { fg = P.fg },
    CmpItemAbbrDeprecated = { fg = P.muted, strikethrough = true },
    CmpItemAbbrMatch = { fg = P.blue },
    CmpItemAbbrMatchFuzzy = { fg = P.blue },
    CmpItemMenu = { fg = P.muted },
    CmpGhostText = { fg = P.comment, italic = true }, -- syntax.predictive

    BlinkCmpMenu = { fg = P.fg, bg = P.elevated },
    BlinkCmpMenuBorder = { fg = P.border, bg = P.elevated },
    BlinkCmpMenuSelection = { bg = P.sel },
    BlinkCmpScrollBarThumb = { bg = B.thumb },
    BlinkCmpScrollBarGutter = { bg = P.elevated },
    BlinkCmpLabel = { fg = P.fg },
    BlinkCmpLabelDeprecated = { fg = P.muted, strikethrough = true },
    BlinkCmpLabelMatch = { fg = P.blue },
    BlinkCmpLabelDetail = { fg = P.muted },
    BlinkCmpLabelDescription = { fg = P.muted },
    BlinkCmpSource = { fg = P.muted },
    BlinkCmpGhostText = { fg = P.comment, italic = true },
    BlinkCmpDoc = { fg = P.fg, bg = P.elevated },
    BlinkCmpDocBorder = { fg = P.border, bg = P.elevated },
    BlinkCmpDocSeparator = { fg = P.border, bg = P.elevated },
    BlinkCmpDocCursorLine = { bg = P.sel },
    BlinkCmpSignatureHelp = { fg = P.fg, bg = P.elevated },
    BlinkCmpSignatureHelpBorder = { fg = P.border, bg = P.elevated },
    BlinkCmpSignatureHelpActiveParameter = { fg = P.blue, bold = true, underline = true },
}
for name, opts in pairs(cmp) do
    set(name, opts)
end

-- copilot / supermaven -----------------------------------------------------
-- set("CopilotSuggestion", { fg = P.comment, italic = true })
-- set("CopilotAnnotation", { fg = P.comment, italic = true })
-- set("SupermavenSuggestion", { fg = P.comment, italic = true })

-- nvim-tree ----------------------------------------------------------------
local nt = {
    NvimTreeNormal = { fg = P.fg, bg = P.bg },
    NvimTreeNormalNC = { fg = P.fg, bg = P.bg },
    NvimTreeNormalFloat = { fg = P.fg, bg = P.elevated },
    NvimTreeEndOfBuffer = { fg = P.bg },
    NvimTreeWinSeparator = { fg = P.border, bg = P.bg },
    NvimTreeCursorLine = { bg = P.sel },
    NvimTreeRootFolder = { fg = P.fg, bold = true },
    NvimTreeFolderName = { fg = P.fg },
    NvimTreeOpenedFolderName = { fg = P.fg },
    NvimTreeEmptyFolderName = { fg = P.muted },
    NvimTreeFolderIcon = { fg = P.blue },
    NvimTreeFileIcon = { fg = P.fg },
    NvimTreeIndentMarker = { fg = P.panel_guide }, -- panel.indent_guide
    NvimTreeSymlink = { fg = P.cyan },
    NvimTreeExecFile = { fg = P.green },
    NvimTreeSpecialFile = { fg = P.magenta },
    NvimTreeImageFile = { fg = P.fg },
    NvimTreeOpenedFile = { fg = P.fg, bold = true },
    NvimTreeModifiedFile = { fg = P.blue },
    NvimTreeModifiedIcon = { fg = P.blue },
    NvimTreeBookmark = { fg = P.yellow },
    NvimTreeGitDirty = { fg = P.blue },
    NvimTreeGitNew = { fg = P.green },
    NvimTreeGitDeleted = { fg = P.red },
    NvimTreeGitStaged = { fg = P.green },
    NvimTreeGitRenamed = { fg = P.cyan },
    NvimTreeGitMerge = { fg = P.magenta },
    NvimTreeGitIgnored = { fg = P.disabled },
    NvimTreeGitFileDirtyHL = { fg = P.blue },
    NvimTreeGitFolderDirtyHL = { fg = P.blue },
    NvimTreeGitFileNewHL = { fg = P.green },
    NvimTreeGitFolderNewHL = { fg = P.green },
    NvimTreeGitFileDeletedHL = { fg = P.red },
    NvimTreeGitFileIgnoredHL = { fg = P.disabled },
    NvimTreeGitFolderIgnoredHL = { fg = P.disabled },
    NvimTreeWindowPicker = { fg = P.bg, bg = P.blue, bold = true },
    NvimTreeDiagnosticErrorIcon = { fg = P.red },
    NvimTreeDiagnosticWarnIcon = { fg = P.yellow },
    NvimTreeDiagnosticInfoIcon = { fg = P.blue },
    NvimTreeDiagnosticHintIcon = { fg = P.muted },
}
for name, opts in pairs(nt) do
    set(name, opts)
end

-- neo-tree.nvim ------------------------------------------------------------
local neo = {
    NeoTreeNormal = { fg = P.fg, bg = P.bg },
    NeoTreeNormalNC = { fg = P.fg, bg = P.bg },
    NeoTreeEndOfBuffer = { fg = P.bg, bg = P.bg },
    NeoTreeWinSeparator = { fg = P.border, bg = P.bg },
    NeoTreeVertSplit = { fg = P.border, bg = P.bg },
    NeoTreeCursorLine = { bg = P.sel },
    NeoTreeRootName = { fg = P.fg, bold = true },
    NeoTreeDirectoryName = { fg = P.fg },
    NeoTreeDirectoryIcon = { fg = P.blue },
    NeoTreeFileName = { fg = P.fg },
    NeoTreeFileNameOpened = { fg = P.fg, bold = true },
    NeoTreeFileIcon = { fg = P.fg },
    NeoTreeDotfile = { fg = P.muted },
    NeoTreeHiddenByName = { fg = P.muted },
    NeoTreeDimText = { fg = P.muted },
    NeoTreeFadeText1 = { fg = P.muted },
    NeoTreeFadeText2 = { fg = P.disabled },
    NeoTreeIndentMarker = { fg = P.panel_guide },
    NeoTreeExpander = { fg = P.muted },
    NeoTreeSymbolicLinkTarget = { fg = P.cyan },
    NeoTreeModified = { fg = P.blue },
    NeoTreeMessage = { fg = P.muted },
    NeoTreeTitleBar = { fg = P.bg, bg = P.blue, bold = true },
    NeoTreeFloatTitle = { fg = P.blue, bg = P.elevated, bold = true },
    NeoTreeFloatBorder = { fg = P.border, bg = P.elevated },
    NeoTreeFloatNormal = { fg = P.fg, bg = P.elevated },
    NeoTreeTabActive = { fg = P.fg, bg = P.bg, bold = true },
    NeoTreeTabInactive = { fg = P.muted, bg = P.chrome },
    NeoTreeTabSeparatorActive = { fg = P.bg, bg = P.bg },
    NeoTreeTabSeparatorInactive = { fg = P.chrome, bg = P.chrome },
    NeoTreeGitAdded = { fg = P.green },
    NeoTreeGitConflict = { fg = P.magenta },
    NeoTreeGitDeleted = { fg = P.red },
    NeoTreeGitIgnored = { fg = P.disabled },
    NeoTreeGitModified = { fg = P.blue },
    NeoTreeGitRenamed = { fg = P.cyan },
    NeoTreeGitStaged = { fg = P.green },
    NeoTreeGitUnstaged = { fg = P.blue },
    NeoTreeGitUntracked = { fg = P.green },
}
for name, opts in pairs(neo) do
    set(name, opts)
end

-- oil.nvim -----------------------------------------------------------------
local oil = {
    OilDir = { fg = P.blue },
    OilDirIcon = { fg = P.blue },
    OilLink = { fg = P.cyan },
    OilLinkTarget = { fg = P.muted },
    OilFile = { fg = P.fg },
    OilSocket = { fg = P.magenta },
    OilCreate = { fg = P.green },
    OilDelete = { fg = P.red },
    OilMove = { fg = P.cyan },
    OilCopy = { fg = P.magenta },
    OilChange = { fg = P.blue },
    OilRestore = { fg = P.green },
    OilPurge = { fg = P.red },
    OilTrash = { fg = P.red },
    OilTrashSourcePath = { fg = P.muted },
}
for name, opts in pairs(oil) do
    set(name, opts)
end

-- indent-blankline.nvim (ibl) / mini.indentscope / snacks.indent -----------
-- set("IblIndent", { fg = P.guide, nocombine = true }) -- editor.indent_guide
-- set("IblWhitespace", { fg = P.disabled, nocombine = true }) -- editor.invisible
-- set("IblScope", { fg = P.guide_active, nocombine = true }) -- editor.indent_guide_active
-- set("IndentBlanklineChar", { fg = P.guide, nocombine = true })
-- set("IndentBlanklineContextChar", { fg = P.guide_active, nocombine = true })
-- set("MiniIndentscopeSymbol", { fg = P.guide_active })
-- set("SnacksIndent", { fg = P.guide, nocombine = true })
-- set("SnacksIndentScope", { fg = P.guide_active, nocombine = true })
-- set("SnacksIndentChunk", { fg = P.guide_active, nocombine = true })

-- which-key.nvim -----------------------------------------------------------
local wk = {
    WhichKey = { fg = P.blue },
    WhichKeyGroup = { fg = P.magenta },
    WhichKeyDesc = { fg = P.fg },
    WhichKeySeparator = { fg = P.muted },
    WhichKeyNormal = { fg = P.fg, bg = P.elevated },
    WhichKeyBorder = { fg = P.border, bg = P.elevated },
    WhichKeyTitle = { fg = P.blue, bg = P.elevated, bold = true },
    WhichKeyValue = { fg = P.muted },
    WhichKeyIcon = { fg = P.blue },
    WhichKeyIconAzure = { fg = P.blue },
    WhichKeyIconBlue = { fg = P.blue },
    WhichKeyIconCyan = { fg = P.cyan },
    WhichKeyIconGreen = { fg = P.green },
    WhichKeyIconGrey = { fg = P.muted },
    WhichKeyIconOrange = { fg = P.orange },
    WhichKeyIconPurple = { fg = P.magenta },
    WhichKeyIconRed = { fg = P.red },
    WhichKeyIconYellow = { fg = P.yellow },
}
for name, opts in pairs(wk) do
    set(name, opts)
end

-- noice.nvim / nvim-notify -------------------------------------------------
-- local noice = {
--     NoiceCmdline = { fg = P.fg, bg = P.chrome },
--     NoiceCmdlineIcon = { fg = P.blue },
--     NoiceCmdlineIconSearch = { fg = P.yellow },
--     NoiceCmdlinePopup = { fg = P.fg, bg = P.elevated },
--     NoiceCmdlinePopupBorder = { fg = P.border, bg = P.elevated },
--     NoiceCmdlinePopupTitle = { fg = P.blue, bg = P.elevated },
--     NoiceCmdlinePopupBorderSearch = { fg = P.border, bg = P.elevated },
--     NoicePopup = { fg = P.fg, bg = P.elevated },
--     NoicePopupBorder = { fg = P.border, bg = P.elevated },
--     NoicePopupmenu = { fg = P.fg, bg = P.elevated },
--     NoicePopupmenuBorder = { fg = P.border, bg = P.elevated },
--     NoicePopupmenuSelected = { bg = P.sel },
--     NoicePopupmenuMatch = { fg = P.blue },
--     NoiceConfirm = { fg = P.fg, bg = P.elevated },
--     NoiceConfirmBorder = { fg = P.border, bg = P.elevated },
--     NoiceMini = { fg = P.muted, bg = P.elevated },
--     NoiceVirtualText = { fg = P.muted },
--     NoiceLspProgressTitle = { fg = P.muted },
--     NoiceLspProgressClient = { fg = P.blue },
--     NoiceLspProgressSpinner = { fg = P.blue },
--     NoiceFormatProgressDone = { fg = P.bg, bg = P.green },
--     NoiceFormatProgressTodo = { fg = P.muted, bg = P.hover },
--
--     NotifyBackground = { fg = P.fg, bg = P.elevated },
--     NotifyERRORBorder = { fg = B.err_border, bg = P.elevated },
--     NotifyWARNBorder = { fg = B.warn_border, bg = P.elevated },
--     NotifyINFOBorder = { fg = B.info_border, bg = P.elevated },
--     NotifyDEBUGBorder = { fg = B.hint_border, bg = P.elevated },
--     NotifyTRACEBorder = { fg = B.hint_border, bg = P.elevated },
--     NotifyERRORIcon = { fg = P.red },
--     NotifyWARNIcon = { fg = P.yellow },
--     NotifyINFOIcon = { fg = P.blue },
--     NotifyDEBUGIcon = { fg = P.muted },
--     NotifyTRACEIcon = { fg = P.magenta },
--     NotifyERRORTitle = { fg = P.red },
--     NotifyWARNTitle = { fg = P.yellow },
--     NotifyINFOTitle = { fg = P.blue },
--     NotifyDEBUGTitle = { fg = P.muted },
--     NotifyTRACETitle = { fg = P.magenta },
--     NotifyERRORBody = { fg = P.fg, bg = P.elevated },
--     NotifyWARNBody = { fg = P.fg, bg = P.elevated },
--     NotifyINFOBody = { fg = P.fg, bg = P.elevated },
--     NotifyDEBUGBody = { fg = P.fg, bg = P.elevated },
--     NotifyTRACEBody = { fg = P.fg, bg = P.elevated },
-- }
-- for name, opts in pairs(noice) do
--     set(name, opts)
-- end

-- trouble.nvim -------------------------------------------------------------
-- local trouble = {
--     TroubleNormal = { fg = P.fg, bg = P.bg },
--     TroubleNormalNC = { fg = P.fg, bg = P.bg },
--     TroubleText = { fg = P.fg },
--     TroubleCount = { fg = P.blue, bg = P.elevated },
--     TroubleCode = { fg = P.muted },
--     TroubleSource = { fg = P.muted },
--     TroublePos = { fg = P.muted },
--     TroubleIndent = { fg = P.panel_guide },
--     TroubleIndentFoldOpen = { fg = P.muted },
--     TroubleIndentFoldClosed = { fg = P.muted },
--     TroubleIconDirectory = { fg = P.blue },
--     TroubleDirectory = { fg = P.fg },
--     TroubleBasename = { fg = P.fg },
--     TroubleFilename = { fg = P.fg },
--     TroublePreview = { bg = B.search },
-- }
-- for name, opts in pairs(trouble) do
--     set(name, opts)
-- end

-- flash / leap / hop -------------------------------------------------------
-- set("FlashBackdrop", { fg = P.muted })
-- set("FlashLabel", { fg = P.bg, bg = P.magenta, bold = true })
-- set("FlashMatch", { bg = B.search })
-- set("FlashCurrent", { bg = B.search_cur })
-- set("FlashPrompt", { fg = P.fg, bg = P.elevated })
-- set("FlashPromptIcon", { fg = P.blue })
-- set("LeapBackdrop", { fg = P.muted })
-- set("LeapMatch", { fg = P.fg, bg = B.search, bold = true })
-- set("LeapLabel", { fg = P.bg, bg = P.magenta, bold = true })
-- set("LeapLabelPrimary", { fg = P.bg, bg = P.magenta, bold = true })
-- set("LeapLabelSecondary", { fg = P.bg, bg = P.blue, bold = true })
-- set("HopNextKey", { fg = P.magenta, bold = true })
-- set("HopNextKey1", { fg = P.blue, bold = true })
-- set("HopNextKey2", { fg = P.blue })
-- set("HopUnmatched", { fg = P.muted })

-- vim-illuminate / mini.cursorword -----------------------------------------
-- set("IlluminatedWordText", { bg = B.ref_read })
-- set("IlluminatedWordRead", { bg = B.ref_read })
-- set("IlluminatedWordWrite", { bg = B.ref_write })
-- set("MiniCursorword", { bg = B.ref_read })
-- set("MiniCursorwordCurrent", { bg = B.ref_read })

-- nvim-treesitter-context (sticky scroll → editor.subheader.background) ----
-- set("TreesitterContext", { bg = P.elevated })
-- set("TreesitterContextLineNumber", { fg = P.ln_active, bg = P.elevated })
-- set("TreesitterContextSeparator", { fg = P.border })
-- set("TreesitterContextBottom", { sp = P.border, underline = true })

-- rainbow-delimiters (в Zed нет; берутся цвета из палитры темы) ------------
local rainbow = {
    RainbowDelimiterRed = P.red, RainbowDelimiterYellow = P.yellow, RainbowDelimiterBlue = P.blue,
    RainbowDelimiterOrange = P.orange, RainbowDelimiterGreen = P.green, RainbowDelimiterViolet = P.magenta,
    RainbowDelimiterCyan = P.cyan,
}
for name, color in pairs(rainbow) do
    set(name, { fg = color })
end

-- mini.nvim ----------------------------------------------------------------
-- local mini = {
--     MiniStatuslineModeNormal = { fg = P.bg, bg = P.blue, bold = true },
--     MiniStatuslineModeInsert = { fg = P.bg, bg = P.green, bold = true },
--     MiniStatuslineModeVisual = { fg = P.bg, bg = P.magenta, bold = true },
--     MiniStatuslineModeReplace = { fg = P.bg, bg = P.red, bold = true },
--     MiniStatuslineModeCommand = { fg = P.bg, bg = P.yellow, bold = true },
--     MiniStatuslineModeOther = { fg = P.bg, bg = P.cyan, bold = true },
--     MiniStatuslineDevinfo = { fg = P.fg, bg = P.elevated },
--     MiniStatuslineFilename = { fg = P.fg, bg = P.chrome },
--     MiniStatuslineFileinfo = { fg = P.fg, bg = P.elevated },
--     MiniStatuslineInactive = { fg = P.muted, bg = P.chrome },
--     MiniTablineCurrent = { fg = P.fg, bg = P.bg, bold = true },
--     MiniTablineVisible = { fg = P.muted, bg = P.chrome },
--     MiniTablineHidden = { fg = P.muted, bg = P.chrome },
--     MiniTablineModifiedCurrent = { fg = P.blue, bg = P.bg },
--     MiniTablineModifiedVisible = { fg = P.blue, bg = P.chrome },
--     MiniTablineModifiedHidden = { fg = P.blue, bg = P.chrome },
--     MiniTablineFill = { bg = P.chrome },
--     MiniTablineTabpagesection = { fg = P.bg, bg = P.blue },
--     MiniDiffSignAdd = { fg = P.green },
--     MiniDiffSignChange = { fg = P.blue },
--     MiniDiffSignDelete = { fg = P.red },
--     MiniDiffOverAdd = { bg = B.diff_add },
--     MiniDiffOverChange = { bg = B.diff_chg },
--     MiniDiffOverDelete = { bg = B.diff_del },
--     MiniDiffOverContext = { bg = B.diff_chg },
--     MiniFilesNormal = { fg = P.fg, bg = P.elevated },
--     MiniFilesBorder = { fg = P.border, bg = P.elevated },
--     MiniFilesBorderModified = { fg = P.blue, bg = P.elevated },
--     MiniFilesTitle = { fg = P.blue, bg = P.elevated },
--     MiniFilesTitleFocused = { fg = P.blue, bg = P.elevated, bold = true },
--     MiniFilesCursorLine = { bg = P.sel },
--     MiniFilesDirectory = { fg = P.blue },
--     MiniFilesFile = { fg = P.fg },
--     MiniPickNormal = { fg = P.fg, bg = P.elevated },
--     MiniPickBorder = { fg = P.border, bg = P.elevated },
--     MiniPickBorderText = { fg = P.blue, bg = P.elevated },
--     MiniPickMatchCurrent = { bg = P.sel },
--     MiniPickMatchMarked = { bg = B.search },
--     MiniPickMatchRanges = { fg = P.blue },
--     MiniPickPrompt = { fg = P.fg, bg = P.elevated },
--     MiniPickPromptCaret = { fg = P.blue },
--     MiniPickPromptPrefix = { fg = P.blue },
--     MiniPickHeader = { fg = P.blue },
--     MiniPickPreviewLine = { bg = B.cursorline },
--     MiniPickPreviewRegion = { bg = B.search },
--     MiniStarterHeader = { fg = P.blue },
--     MiniStarterFooter = { fg = P.muted },
--     MiniStarterItem = { fg = P.fg },
--     MiniStarterItemBullet = { fg = P.muted },
--     MiniStarterItemPrefix = { fg = P.magenta },
--     MiniStarterSection = { fg = P.muted },
--     MiniStarterQuery = { fg = P.blue },
--     MiniStarterCurrent = {},
--     MiniStarterInactive = { fg = P.muted },
--     MiniTrailspace = { bg = P.red },
--     MiniJump = { fg = P.bg, bg = P.magenta },
--     MiniJump2dSpot = { fg = P.magenta, bold = true },
--     MiniHipatternsFixme = { fg = P.bg, bg = P.red, bold = true },
--     MiniHipatternsHack = { fg = P.bg, bg = P.yellow, bold = true },
--     MiniHipatternsNote = { fg = P.bg, bg = P.blue, bold = true },
--     MiniHipatternsTodo = { fg = P.bg, bg = P.cyan, bold = true },
--     MiniNotifyNormal = { fg = P.fg, bg = P.elevated },
--     MiniNotifyBorder = { fg = P.border, bg = P.elevated },
--     MiniNotifyTitle = { fg = P.blue, bg = P.elevated },
--     MiniOperatorsExchangeFrom = { bg = B.search },
--     MiniSurround = { bg = B.search_cur },
--     MiniCompletionActiveParameter = { fg = P.blue, underline = true },
-- }
-- for name, opts in pairs(mini) do
--     set(name, opts)
-- end

-- snacks.nvim (то, что не подхватывается через NormalFloat/Special) --------
-- set("SnacksNormal", { fg = P.fg, bg = P.elevated })
-- set("SnacksWinBar", { fg = P.fg, bg = P.elevated })
-- set("SnacksDashboardHeader", { fg = P.blue })
-- set("SnacksDashboardIcon", { fg = P.blue })
-- set("SnacksDashboardKey", { fg = P.magenta })
-- set("SnacksDashboardDesc", { fg = P.fg })
-- set("SnacksDashboardFooter", { fg = P.muted })
-- set("SnacksDashboardDir", { fg = P.muted })
-- set("SnacksDashboardFile", { fg = P.fg })
-- set("SnacksDashboardSpecial", { fg = P.orange })
-- set("SnacksDashboardTitle", { fg = P.blue })
-- set("SnacksPickerMatch", { fg = P.blue, bold = true })
-- set("SnacksPickerDir", { fg = P.muted })
-- set("SnacksPickerPathHidden", { fg = P.muted })
-- set("SnacksPickerPathIgnored", { fg = P.disabled })
-- set("SnacksPickerGitStatusAdded", { fg = P.green })
-- set("SnacksPickerGitStatusModified", { fg = P.blue })
-- set("SnacksPickerGitStatusDeleted", { fg = P.red })
-- set("SnacksPickerGitStatusRenamed", { fg = P.cyan })
-- set("SnacksPickerGitStatusUntracked", { fg = P.green })
-- set("SnacksNotifierBorderError", { fg = B.err_border, bg = P.elevated })
-- set("SnacksNotifierBorderWarn", { fg = B.warn_border, bg = P.elevated })
-- set("SnacksNotifierBorderInfo", { fg = B.info_border, bg = P.elevated })
-- set("SnacksNotifierBorderDebug", { fg = B.hint_border, bg = P.elevated })
-- set("SnacksNotifierBorderTrace", { fg = B.hint_border, bg = P.elevated })

-- dashboard-nvim / alpha-nvim ----------------------------------------------
-- set("DashboardHeader", { fg = P.blue })
-- set("DashboardCenter", { fg = P.fg })
-- set("DashboardShortcut", { fg = P.magenta })
-- set("DashboardFooter", { fg = P.muted })
-- set("DashboardIcon", { fg = P.blue })
-- set("DashboardDesc", { fg = P.fg })
-- set("DashboardKey", { fg = P.magenta })
-- set("AlphaHeader", { fg = P.blue })
-- set("AlphaButtons", { fg = P.fg })
-- set("AlphaShortcut", { fg = P.magenta })
-- set("AlphaFooter", { fg = P.muted })

-- lazy.nvim / mason.nvim ---------------------------------------------------
local mgr = {
    -- LazyNormal = { fg = P.fg, bg = P.elevated },
    -- LazyBorder = { fg = P.border, bg = P.elevated },
    -- LazyButton = { fg = P.fg, bg = P.hover },
    -- LazyButtonActive = { fg = P.fg, bg = P.sel },
    -- LazyH1 = { fg = P.bg, bg = P.blue, bold = true },
    -- LazyH2 = { fg = P.blue, bold = true },
    -- LazySpecial = { fg = P.blue },
    -- LazyProgressDone = { fg = P.green },
    -- LazyProgressTodo = { fg = P.disabled },
    -- LazyReasonPlugin = { fg = P.blue },
    -- LazyReasonEvent = { fg = P.yellow },
    -- LazyReasonKeys = { fg = P.magenta },
    -- LazyReasonCmd = { fg = P.orange },
    -- LazyReasonFt = { fg = P.cyan },
    -- LazyReasonRuntime = { fg = P.green },
    -- LazyReasonSource = { fg = P.cyan },
    -- LazyReasonStart = { fg = P.fg },
    -- LazyReasonImport = { fg = P.fg },
    -- LazyCommit = { fg = P.green },
    -- LazyCommitType = { fg = P.blue },
    -- LazyCommitScope = { fg = P.magenta },
    -- LazyUrl = { fg = P.blue },
    -- LazyDir = { fg = P.muted },
    -- LazyProp = { fg = P.muted },
    -- LazyValue = { fg = P.cyan },
    -- LazyLocal = { fg = P.yellow },
    -- LazyNoCond = { fg = P.red },
    -- LazyDimmed = { fg = P.muted },
    -- LazyTaskOutput = { fg = P.fg },
    -- LazyTaskError = { fg = P.red },
    MasonNormal = { fg = P.fg, bg = P.elevated },
    MasonHeader = { fg = P.bg, bg = P.blue, bold = true },
    MasonHeaderSecondary = { fg = P.bg, bg = P.magenta, bold = true },
    MasonHighlight = { fg = P.blue },
    MasonHighlightBlock = { fg = P.bg, bg = P.blue },
    MasonHighlightBlockBold = { fg = P.bg, bg = P.blue, bold = true },
    MasonHighlightSecondary = { fg = P.magenta },
    MasonHighlightBlockSecondary = { fg = P.bg, bg = P.magenta },
    MasonHighlightBlockBoldSecondary = { fg = P.bg, bg = P.magenta, bold = true },
    MasonMuted = { fg = P.muted },
    MasonMutedBlock = { fg = P.fg, bg = P.hover },
    MasonMutedBlockBold = { fg = P.fg, bg = P.hover, bold = true },
    MasonError = { fg = P.red },
    MasonWarning = { fg = P.yellow },
    MasonHeading = { fg = P.blue, bold = true },
}
for name, opts in pairs(mgr) do
    set(name, opts)
end

-- nvim-dap / dap-ui ---------------------------------------------------------
set("DapBreakpoint", { fg = P.red })
set("DapBreakpointCondition", { fg = P.yellow })
set("DapBreakpointRejected", { fg = P.muted })
set("DapLogPoint", { fg = P.blue })
set("DapStopped", { fg = P.green })
set("DapStoppedLine", { bg = B.ok_bg })
set("DapUIScope", { fg = P.blue })
set("DapUIType", { fg = P.fg })
set("DapUIValue", { fg = P.cyan })
set("DapUIVariable", { fg = P.fg })
set("DapUIModifiedValue", { fg = P.blue, bold = true })
set("DapUIDecoration", { fg = P.blue })
set("DapUIThread", { fg = P.green })
set("DapUIStoppedThread", { fg = P.blue })
set("DapUISource", { fg = P.magenta })
set("DapUILineNumber", { fg = P.blue })
set("DapUIFloatBorder", { fg = P.border })
set("DapUIWatchesEmpty", { fg = P.red })
set("DapUIWatchesValue", { fg = P.green })
set("DapUIWatchesError", { fg = P.red })
set("DapUIBreakpointsPath", { fg = P.blue })
set("DapUIBreakpointsInfo", { fg = P.green })
set("DapUIBreakpointsCurrentLine", { fg = P.green, bold = true })
set("DapUIStepOver", { fg = P.blue })
set("DapUIStepInto", { fg = P.blue })
set("DapUIStepBack", { fg = P.blue })
set("DapUIStepOut", { fg = P.blue })
set("DapUIStop", { fg = P.red })
set("DapUIPlayPause", { fg = P.green })
set("DapUIRestart", { fg = P.green })
set("DapUIUnavailable", { fg = P.disabled })

-- diffview.nvim / neogit ---------------------------------------------------
local vcs = {
    DiffviewFilePanelTitle = { fg = P.blue, bold = true },
    DiffviewFilePanelCounter = { fg = P.magenta },
    DiffviewFilePanelFileName = { fg = P.fg },
    DiffviewFilePanelPath = { fg = P.muted },
    DiffviewFilePanelInsertions = { fg = P.green },
    DiffviewFilePanelDeletions = { fg = P.red },
    DiffviewStatusAdded = { fg = P.green },
    DiffviewStatusModified = { fg = P.blue },
    DiffviewStatusRenamed = { fg = P.cyan },
    DiffviewStatusDeleted = { fg = P.red },
    DiffviewStatusUntracked = { fg = P.green },
    DiffviewStatusConflict = { fg = P.magenta },
    DiffviewStatusIgnored = { fg = P.disabled },
    DiffviewDiffAddAsDelete = { bg = B.diff_del },
    DiffviewDiffDelete = { fg = P.disabled },
    DiffviewNormal = { fg = P.fg, bg = P.bg },
    DiffviewCursorLine = { bg = P.sel },
    DiffviewEndOfBuffer = { fg = P.bg },
    DiffviewVertSplit = { fg = P.border, bg = P.bg },
    NeogitDiffAdd = { fg = P.green, bg = B.diff_add },
    NeogitDiffAddHighlight = { fg = P.green, bg = B.diff_add },
    NeogitDiffAddCursor = { fg = P.green, bg = B.cursorline },
    NeogitDiffDelete = { fg = P.red, bg = B.diff_del },
    NeogitDiffDeleteHighlight = { fg = P.red, bg = B.diff_del },
    NeogitDiffDeleteCursor = { fg = P.red, bg = B.cursorline },
    NeogitDiffContext = { fg = P.fg },
    NeogitDiffContextHighlight = { fg = P.fg, bg = B.cursorline },
    NeogitDiffContextCursor = { fg = P.fg, bg = B.cursorline },
    NeogitHunkHeader = { fg = P.blue, bg = P.elevated },
    NeogitHunkHeaderHighlight = { fg = P.blue, bg = P.elevated, bold = true },
    NeogitHunkHeaderCursor = { fg = P.blue, bg = P.sel },
    NeogitBranch = { fg = P.blue },
    NeogitRemote = { fg = P.green },
    NeogitSectionHeader = { fg = P.blue, bold = true },
    NeogitChangeAdded = { fg = P.green },
    NeogitChangeModified = { fg = P.blue },
    NeogitChangeDeleted = { fg = P.red },
    NeogitChangeRenamed = { fg = P.cyan },
    NeogitChangeNewFile = { fg = P.green },
    NeogitCursorLine = { bg = B.cursorline },
    NeogitPopupSwitchKey = { fg = P.magenta },
    NeogitPopupOptionKey = { fg = P.magenta },
    NeogitPopupActionKey = { fg = P.magenta },
    NeogitPopupConfigKey = { fg = P.magenta },
}
for name, opts in pairs(vcs) do
    set(name, opts)
end

-- render-markdown.nvim / markview -----------------------------------------
-- set("RenderMarkdownH1", { fg = P.blue, bold = true })
-- set("RenderMarkdownH2", { fg = P.blue, bold = true })
-- set("RenderMarkdownH3", { fg = P.blue, bold = true })
-- set("RenderMarkdownH4", { fg = P.blue, bold = true })
-- set("RenderMarkdownH5", { fg = P.blue, bold = true })
-- set("RenderMarkdownH6", { fg = P.blue, bold = true })
-- set("RenderMarkdownCode", { bg = P.elevated })
-- set("RenderMarkdownCodeInline", { fg = P.green, bg = P.elevated })
-- set("RenderMarkdownBullet", { fg = P.fg })
-- set("RenderMarkdownQuote", { fg = P.muted })
-- set("RenderMarkdownLink", { fg = P.blue })
-- set("RenderMarkdownTableHead", { fg = P.blue, bold = true })
-- set("RenderMarkdownTableRow", { fg = P.fg })
-- set("RenderMarkdownDash", { fg = P.border })
-- set("RenderMarkdownChecked", { fg = P.green })
-- set("RenderMarkdownUnchecked", { fg = P.muted })
-- set("RenderMarkdownSuccess", { fg = P.green })
-- set("RenderMarkdownInfo", { fg = P.blue })
-- set("RenderMarkdownHint", { fg = P.cyan })
-- set("RenderMarkdownWarn", { fg = P.yellow })
-- set("RenderMarkdownError", { fg = P.red })

-- nvim-ufo / hlslens / todo-comments / navic / dropbar --------------------
-- set("UfoFoldedBg", { bg = P.elevated })
-- set("UfoFoldedFg", { fg = P.muted })
-- set("UfoPreviewSbar", { bg = P.elevated })
-- set("UfoPreviewThumb", { bg = B.thumb })
-- set("UfoFoldedEllipsis", { fg = P.muted })
set("HlSearchNear", { bg = B.search_cur })
set("HlSearchLens", { fg = P.muted, bg = P.elevated })
set("HlSearchLensNear", { fg = P.blue, bg = P.elevated })
set("HlSearchFloat", { bg = B.search_cur })
-- set("NavicText", { fg = P.fg })
-- set("NavicSeparator", { fg = P.muted })
-- set("NavicIconsFunction", { fg = P.blue })
-- set("NavicIconsMethod", { fg = P.blue })
-- set("NavicIconsVariable", { fg = P.fg })
-- set("NavicIconsField", { fg = P.magenta })
-- set("NavicIconsProperty", { fg = P.magenta })
-- set("NavicIconsClass", { fg = P.fg })
-- set("NavicIconsInterface", { fg = P.fg })
-- set("NavicIconsEnum", { fg = P.teal })
-- set("NavicIconsKeyword", { fg = P.orange })
-- set("NavicIconsConstant", { fg = P.magenta })
-- set("DropBarMenuNormalFloat", { fg = P.fg, bg = P.elevated })
-- set("DropBarMenuCurrentContext", { bg = P.sel })
-- set("DropBarMenuHoverEntry", { bg = P.hover })
-- set("DropBarCurrentContext", { bg = P.sel })
-- set("DropBarIconUISeparator", { fg = P.muted })

-- statuscol / scrollbar / nvim-scrollbar / satellite -----------------------
-- set("ScrollbarHandle", { bg = B.thumb })
-- set("ScrollbarCursorHandle", { bg = B.thumb })
-- set("ScrollbarError", { fg = P.red })
-- set("ScrollbarWarn", { fg = P.yellow })
-- set("ScrollbarInfo", { fg = P.blue })
-- set("ScrollbarHint", { fg = P.muted })
-- set("ScrollbarSearch", { fg = P.blue })
-- set("ScrollbarMisc", { fg = P.magenta })
-- set("SatelliteBar", { bg = over("#bcbec420", P.bg) })
-- set("SatelliteBackground", { bg = P.bg })
-- set("SatelliteCursor", { fg = P.blue })
-- set("SatelliteSearch", { fg = P.blue })
-- set("SatelliteDiagnosticError", { fg = P.red })
-- set("SatelliteDiagnosticWarn", { fg = P.yellow })
-- set("SatelliteDiagnosticInfo", { fg = P.blue })
-- set("SatelliteDiagnosticHint", { fg = P.muted })
-- set("SatelliteGitSignsAdd", { fg = P.green })
-- set("SatelliteGitSignsChange", { fg = P.blue })
-- set("SatelliteGitSignsDelete", { fg = P.red })

-- ---------------------------------------------------------------------------
-- terminal buffers: terminal.background (#191a1c) вместо editor.background
-- ---------------------------------------------------------------------------
set("IslandsTerminal", { fg = P.fg, bg = P.chrome })
local aug = vim.api.nvim_create_augroup("IslandsDarkTerminal", { clear = true })
vim.api.nvim_create_autocmd({ "TermOpen", "BufWinEnter" }, {
    group = aug,
    callback = function()
        if vim.g.colors_name ~= "islands-dark" then
            return
        end
        if vim.bo.buftype == "terminal" then
            pcall(function()
                vim.opt_local.winhighlight:append({ Normal = "IslandsTerminal", NormalNC = "IslandsTerminal" })
            end)
        end
    end,
})

-- ---------------------------------------------------------------------------
--   require("islands-dark").lualine       -- theme = require("islands-dark").lualine
--   require("islands-dark").bufferline    -- highlights = require("islands-dark").bufferline
--   
--   works only after :colorscheme islands-dark
-- ---------------------------------------------------------------------------
local function lualine_theme()
    local function mode(color)
        return {
            a = { fg = P.bg, bg = color, gui = "bold" },
            b = { fg = P.fg, bg = P.elevated },
            c = { fg = P.fg, bg = P.chrome },
        }
    end
    return {
        normal = mode(P.blue),
        insert = mode(P.green),
        visual = mode(P.magenta),
        replace = mode(P.red),
        command = mode(P.yellow),
        terminal = mode(P.cyan),
        inactive = {
            a = { fg = P.muted, bg = P.chrome },
            b = { fg = P.muted, bg = P.chrome },
            c = { fg = P.muted, bg = P.chrome },
        },
    }
end

local function bufferline_hl()
    local bl = {
        fill = { bg = P.chrome },
        background = { fg = P.muted, bg = P.chrome },
        tab = { fg = P.muted, bg = P.chrome },
        tab_selected = { fg = P.fg, bg = P.bg },
        tab_separator = { fg = P.chrome, bg = P.chrome },
        tab_separator_selected = { fg = P.chrome, bg = P.bg },
        tab_close = { fg = P.muted, bg = P.chrome },
        close_button = { fg = P.muted, bg = P.chrome },
        close_button_visible = { fg = P.muted, bg = P.chrome },
        close_button_selected = { fg = P.fg, bg = P.bg },
        buffer_visible = { fg = P.muted, bg = P.chrome },
        buffer_selected = { fg = P.fg, bg = P.bg, bold = true, italic = false },
        numbers = { fg = P.muted, bg = P.chrome },
        numbers_visible = { fg = P.muted, bg = P.chrome },
        numbers_selected = { fg = P.fg, bg = P.bg, bold = true, italic = false },
        modified = { fg = P.blue, bg = P.chrome },
        modified_visible = { fg = P.blue, bg = P.chrome },
        modified_selected = { fg = P.blue, bg = P.bg },
        duplicate = { fg = P.disabled, bg = P.chrome, italic = true },
        duplicate_visible = { fg = P.disabled, bg = P.chrome, italic = true },
        duplicate_selected = { fg = P.muted, bg = P.bg, italic = true },
        separator = { fg = P.chrome, bg = P.chrome },
        separator_visible = { fg = P.chrome, bg = P.chrome },
        separator_selected = { fg = P.chrome, bg = P.bg },
        indicator_visible = { fg = P.chrome, bg = P.chrome },
        indicator_selected = { fg = P.blue, bg = P.bg },
        pick = { fg = P.red, bg = P.chrome, bold = true },
        pick_visible = { fg = P.red, bg = P.chrome, bold = true },
        pick_selected = { fg = P.red, bg = P.bg, bold = true },
        offset_separator = { fg = P.border, bg = P.bg },
        trunc_marker = { fg = P.muted, bg = P.chrome },
        group_label = { fg = P.bg, bg = P.blue },
        group_separator = { fg = P.blue, bg = P.chrome },
        diagnostic = { fg = P.muted, bg = P.chrome },
        diagnostic_visible = { fg = P.muted, bg = P.chrome },
        diagnostic_selected = { fg = P.muted, bg = P.bg },
    }
    local fams = { error = P.red, warning = P.yellow, info = P.blue, hint = P.muted }
    for name, color in pairs(fams) do
        bl[name] = { fg = color, bg = P.chrome }
        bl[name .. "_visible"] = { fg = color, bg = P.chrome }
        bl[name .. "_selected"] = { fg = color, bg = P.bg, bold = true, italic = false }
        bl[name .. "_diagnostic"] = { fg = color, bg = P.chrome }
        bl[name .. "_diagnostic_visible"] = { fg = color, bg = P.chrome }
        bl[name .. "_diagnostic_selected"] = { fg = color, bg = P.bg }
    end
    return bl
end

package.loaded["islands-dark"] = {
    palette = P,
    lualine = lualine_theme(),
    bufferline = bufferline_hl(),
}
