local oskwid_colors = require("oskwid.palette").colors
local oskwid_themes = require("oskwid.palette").themes

local cmd = vim.cmd
local fn = vim.fn

-- merged opts, defaults <- user_opts
local opts = {}
local defaults = {
  comment_italics = true,
  transparent_background = true,
  transparent_float_background = true,
  reverse_visual = false,
  dim_nc = false,
  cmp_cmdline_disable_search_highlight_group = false,
  telescope_border_follow_float_background = false,
  lspsaga_border_follow_float_background = false,
  diagnostic_virtual_text_background = false,
  colors = {}, -- override `oskwid_colors`
  themes = {}, -- override `oskwid_themes`
}

local M = {
  Color = require("colorbuddy.init").Color,
  colors = require("colorbuddy.init").colors,
  Group = require("colorbuddy.init").Group,
  groups = require("colorbuddy.init").groups,
  styles = require("colorbuddy.init").styles,
}

function M.setup(user_opts)
  user_opts = user_opts or {}
  opts = vim.tbl_extend("force", defaults, user_opts)
  oskwid_colors = vim.tbl_extend("force", oskwid_colors, opts.colors)
  oskwid_themes = vim.tbl_extend("force", oskwid_themes, opts.themes)
end

function M.load()
  -- only needed to clear when not the default colorscheme
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  if fn.exists("syntax_on") then
    cmd("syntax reset")
  end

  vim.g.colors_name = "oskwid"

  local Color = M.Color
  local colors = M.colors
  local Group = M.Group
  local groups = M.groups
  local styles = M.styles

  Color.new("bg", oskwid_themes.background)

  Color.new("black", oskwid_colors.black)
  Color.new("black1", oskwid_colors.black1)
  Color.new("black2", oskwid_colors.black2)
  Color.new("black3", oskwid_colors.black3)
  Color.new("white3", oskwid_colors.white3)
  Color.new("white2", oskwid_colors.white2)
  Color.new("white1", oskwid_colors.white1)
  Color.new("white", oskwid_colors.white)
  Color.new("purple6", oskwid_colors.purple6)

  Color.new("primary", oskwid_themes.primary)

  Color.new("baseForeground", oskwid_themes.foreground)
  Color.new("activeForeground", oskwid_themes.activeForeground)
  Color.new("secondaryForeground", oskwid_themes.secondaryForeground)
  Color.new("ignored", oskwid_themes.ignored)
  Color.new("border", oskwid_themes.border)

  Color.new("baseBackground", oskwid_themes.background)
  Color.new("activeBackground", oskwid_themes.activeBackground)

  Color.new("lowBackground", oskwid_themes.lowBackground)
  Color.new("lowActiveBackground", oskwid_themes.lowActiveBackground)
  Color.new("lowBorder", oskwid_themes.lowBorder)

  Color.new("comment", oskwid_themes.comment)
  Color.new("string", oskwid_themes.string)
  Color.new("variable", oskwid_themes.variable)
  Color.new("keyword", oskwid_themes.keyword)
  Color.new("number", oskwid_themes.number)
  Color.new("boolean", oskwid_themes.boolean)
  Color.new("operator", oskwid_themes.operator)
  Color.new("func", oskwid_themes.func)
  Color.new("constant", oskwid_themes.constant)
  Color.new("class", oskwid_themes.class)
  Color.new("interface", oskwid_themes.interface)
  Color.new("type", oskwid_themes.type)
  Color.new("builtin", oskwid_themes.builtin)
  Color.new("property", oskwid_themes.property)
  Color.new("namespace", oskwid_themes.namespace)
  Color.new("punctuation", oskwid_themes.punctuation)
  Color.new("decorator", oskwid_themes.decorator)
  Color.new("regex", oskwid_themes.regex)

  Group.new("Comment", colors.comment, colors.none, opts.comment_italics and styles.italic or styles.NONE)
  Group.new("String", colors.string)
  Group.new("Variable", colors.variable)
  Group.new("Keyword", colors.keyword)
  Group.new("Number", colors.number)
  Group.new("Boolean", colors.boolean)
  Group.new("Operator", colors.operator)
  Group.new("Function", colors.func)
  Group.new("Constant", colors.constant)
  Group.new("Class", colors.class)
  Group.new("Interface", colors.interface)
  Group.new("Type", colors.type)
  Group.new("Builtin", colors.builtin)
  Group.new("Property", colors.property)
  Group.new("Namespace", colors.namespace)
  Group.new("Punctuation", colors.punctuation)
  Group.new("Decorator", colors.decorator)
  Group.new("Regex", colors.regex)

  Color.new("green", oskwid_themes.green)
  Color.new("cyan", oskwid_themes.cyan)
  Color.new("blue", oskwid_themes.blue)
  Color.new("red", oskwid_themes.red)
  Color.new("orange", oskwid_themes.orange)
  Color.new("yellow", oskwid_themes.yellow)
  Color.new("magenta", oskwid_themes.magenta)

  Color.new("Error", oskwid_themes.red)
  Color.new("Warn", oskwid_themes.yellow)
  Color.new("Info", oskwid_themes.blue)
  Color.new("Hint", oskwid_themes.cyan)

  Group.new("Error", colors.Error)
  Group.new("Warn", colors.Warn)
  Group.new("Info", colors.Info)
  Group.new("Hint", colors.Hint)

  local normal = {
    fg = colors.baseForeground,
    bg = colors.baseBackground,
    nc_fg = colors.baseForeground,
    float_bg = colors.lowBackground,
  }

  if opts.transparent_background then
    normal.bg = colors.none
  end
  if opts.transparent_float_background then
    normal.float_bg = colors.none
  end
  if opts.dim_nc then
    normal.nc_fg = colors.secondaryForeground
  end
  Group.new("Normal", normal.fg, normal.bg)
  -- normal non-current text, means non-focus window text
  Group.new("NormalNC", normal.nc_fg, normal.bg)
  Group.new("NormalFloat", groups.Normal, normal.float_bg)

  -- pum (popup menu) float
  Group.link("Pmenu", groups.NormalFloat)                                   -- popup menu normal item
  Group.new("PmenuSel", colors.activeBackground, normal.fg, styles.reverse) -- selected item
  Group.new("PmenuSbar", colors.black1, colors.none, styles.reverse)
  Group.new("PmenuThumb", colors.black2, colors.none, styles.reverse)

  -- be nice for this float border to be cyan if active
  -- https://neovim.io/doc/user/news-0.10.html#_-breaking-changes
  Group.link("FloatBorder", groups.NormalFloat)

  Group.new("LineNr", colors.ignored:light():light(), colors.none, styles.NONE)
  Group.new("CursorLine", colors.none, colors.lowActiveBackground, styles.NONE)
  Group.new("CursorLineNr", colors.activeForeground, colors.none, styles.NONE)
  Group.new("Cursor", colors.black3, colors.secondaryForeground, styles.NONE)
  Group.link("lCursor", groups.Cursor)
  Group.link("TermCursor", groups.Cursor)
  Group.new("TermCursorNC", colors.black3, colors.activeBackground)

  Group.link("Identifier", groups.Property)

  -- any statement, conditional, repeat (for, do while), label, operator
  Group.new("Statement", colors.green)
  Group.new("PreProc", colors.red)      -- was orange
  Group.new("Special", colors.property) -- was red
  Group.new("SpecialKey", colors.property)
  Group.new("Underlined", colors.red)
  Group.new("Strikethrough", colors.activeBackground, colors.none, styles.strikethrough)
  Group.new("Ignore", groups.Comment)
  Group.new("Todo", colors.blue)

  Group.link("Include", groups.PreProc)
  Group.link("Macro", groups.PreProc)
  Group.link("Delimiter", groups.Special)
  Group.link("Repeat", groups.Statement)
  Group.link("Conditional", groups.Statement)
  Group.link("Define", groups.PreProc)
  Group.link("Character", groups.Constant)
  Group.link("Float", groups.Constant)
  Group.link("Debug", groups.Special)
  Group.link("Label", groups.Statement)
  Group.link("Exception", groups.Statement)
  Group.link("StorageClass", groups.Type)

  Group.link("SpecialChar", groups.Special)
  Group.new("SpecialKey", colors.black3, colors.black1, styles.bold)
  Group.link("String", groups.String)
  Group.new("NonText", colors.black3, colors.none, styles.bold)
  Group.new("StatusLine", colors.lowBackground, colors.black1, styles.reverse)
  Group.new("StatusLineNC", colors.lowActiveBackground, colors.black1, styles.reverse)
  Group.new("Visual", colors.none, colors.black3, opts.reverse_visual and styles.reverse or styles.none)
  Group.new("Directory", colors.blue)
  Group.new("ErrorMsg", colors.red, colors.none, styles.reverse)

  Group.new("IncSearch", colors.orange, colors.none, styles.standout)
  Group.new("Search", colors.yellow, colors.none, styles.reverse)

  Group.new("MoreMsg", colors.blue, colors.none, styles.NONE)
  Group.new("ModeMsg", colors.blue, colors.none, styles.NONE)
  Group.new("Question", colors.cyan, colors.none, styles.bold)
  Group.new("VertSplit", colors.black3, colors.none, styles.NONE)
  Group.new("Title", colors.orange, colors.none, styles.bold)
  Group.new("VisualNOS", colors.none, colors.black1, styles.reverse)
  Group.new("WarningMsg", groups.Warn)
  Group.new("WildMenu", colors.baseForeground, colors.black1, styles.reverse)
  Group.new("Folded", colors.secondaryForeground, colors.black1, styles.bold, colors.black3)
  Group.new("FoldColumn", colors.secondaryForeground, colors.black1)

  Group.new("SignColumn", colors.secondaryForeground, colors.none, styles.NONE)
  Group.new("Conceal", colors.blue, colors.none, styles.NONE)

  Group.new("SpellBad", colors.none, colors.none, styles.undercurl, colors.red)
  Group.new("SpellCap", colors.none, colors.none, styles.undercurl, colors.purple6)
  Group.new("SpellRare", colors.none, colors.none, styles.undercurl, colors.cyan)
  Group.new("SpellLocal", colors.none, colors.none, styles.undercurl, colors.yellow)

  Group.new("MatchParen", colors.red, colors.activeBackground, styles.bold)

  -- vim highlighting
  Group.link("vimVar", groups.Identifier)
  Group.link("vimFunc", groups.Identifier)
  Group.link("vimUserFunc", groups.Identifier)
  Group.link("helpSpecial", groups.Special)
  Group.link("vimSet", groups.Normal)
  Group.link("vimSetEqual", groups.Normal)
  Group.new("vimCommentString", colors.purple6)
  Group.new("vimCommand", colors.yellow)
  Group.new("vimCmdSep", colors.blue, colors.NONE, styles.bold)
  Group.new("helpExample", colors.baseForeground)
  Group.new("helpOption", colors.cyan)
  Group.new("helpNote", colors.magenta)
  Group.new("helpVim", colors.magenta)
  Group.new("helpHyperTextJump", colors.blue, colors.NONE, styles.underline)
  Group.new("helpHyperTextEntry", colors.green)
  Group.new("vimIsCommand", colors.black3)
  Group.new("vimSynMtchOpt", colors.yellow)
  Group.new("vimSynType", colors.cyan)
  Group.new("vimHiLink", colors.blue)
  Group.new("vimGroup", colors.blue, colors.NONE, styles.underline + styles.bold)

  -- diff
  Group.new("DiffAdd", colors.none, colors.green:dark():dark(), styles.bold, colors.green)
  Group.new("DiffChange", colors.none, colors.orange:dark():dark():dark():dark(), styles.bold, colors.orange)
  Group.new("DiffDelete", colors.none, colors.red:dark():dark():dark():dark(), styles.bold, colors.red)
  Group.new("DiffText", colors.none, colors.blue:dark():dark():dark():dark(), styles.bold, colors.blue)

  -- alias ui
  Group.new("Folder", colors.orange)
  Group.new("FolderRoot", colors.blue)

  -- plugins

  -- treesitter, important
  require("oskwid.plugins.treesitter")(opts)
  -- lsp
  require("oskwid.plugins.lsp")(opts)
  -- neomake
  require("oskwid.plugins.neomake")
  -- gitgutter
  require("oskwid.plugins.gitgutter")
  -- gitsigns
  require("oskwid.plugins.gitsigns")
  -- cmp
  require("oskwid.plugins.cmp")(opts)
  -- lspsaga
  require("oskwid.plugins.lspsaga")(opts, { normal = normal })
  -- telescope
  require("oskwid.plugins.telescope")(opts, { normal = normal })
  -- neogit
  require("oskwid.plugins.neogit")(opts)
  -- Primeagen/harpoon
  require("oskwid.plugins.harpoon")
  -- nvim-tree/nvim-tree.lua
  require("oskwid.plugins.nvim-tree")
  -- phaazon/hop.nvim
  require("oskwid.plugins.hop")
  -- j-hui/fidget
  require("oskwid.plugins.fidget")
  -- lukas-reineke/indent-blankline.nvim
  require("oskwid.plugins.indent-blankline")
  -- folke/which-key.nvim
  require("oskwid.plugins.which-key")
  -- folke/noice.nvim
  require("oskwid.plugins.noice")(opts, { normal = normal })
  -- neo-tree
  require("oskwid.plugins.neo-tree")(opts)
  -- alpha
  require("oskwid.plugins.alpha")(opts)
  -- echasnovski/mini.indentscope
  require("oskwid.plugins.mini-indentscope")(opts)
  -- vim-illuminate
  require("oskwid.plugins.illuminate")(opts)
  -- seblj/nvim-tabline
  require("oskwid.plugins.tabline")(opts, { normal = normal })

  return M
end

return M
