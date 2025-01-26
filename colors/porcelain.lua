local g = vim.g

local function flipped()
  return {
    base01 = '#6e7171',
    base02 = '#363646',
    base03 = '#45465e',
    base04 = '#7C81A4',
    base05 = '#151626',
    base06 = '#16161D',
    base07 = '#27324b',
    base08 = '#354364',
    base09 = '#444444',
    -- bg = '#131824',
    bg = '#122023',
    red = '#c45a65',
    dred = '#ed556a',
    qblue = '#4491d4',
    blue = '#7788d4',
    yslan = '#8fb2c9',
    applegreen = '#90a650',
    wzgreen = '#69a794',
    green = '#509987',
    orange = '#f0945d',
    yellow = '#e0af68',
    voilet = '#bc84a8',
    yjvoilet = '#525288',
    dpvoilet = '#957FB8',
    danlanzi = '#a7a8bd',
    aqua = '#55a6bd',
    manaohui = '#ccc9c6',
    notify_red = '#DE6E7C',
    notify_yellow = '#B77E64',
    notify_blue = '#88507D',
    notify_aqua = '#286486',
    notify_bg = '#1c2335',
    bluelnum = '#294161',
    non = 'NONE',
    diff_add = '#2a292b',
    diff_delete = '#2c1f31',
    diff_change = '#192236',
    diff_text = '#343843',
  }
end

local f = flipped()

local groups = {
  Normal = { fg = f.manaohui, bg = f.bg },
  SignColumn = { bg = f.bg },
  LineNr = { fg = f.bluelnum },
  EndOfBuffer = { bg = f.non, fg = f.bg },
  Search = { bg = f.base04, fg = f.base06 },
  Visual = { bg = f.base03 },
  ColorColumn = { bg = f.base06 },
  Whitespace = { fg = f.base02 },
  WinSeparator = { fg = f.base02 },
  Title = { fg = f.yellow },
  Cursorline = { bg = f.base02 },
  CursorLineNr = { fg = f.qblue },
  Pmenu = { bg = f.base03, fg = f.manaohui },
  PmenuSel = { bg = f.yellow, fg = f.base06 },
  PmenuThumb = { bg = f.base02 },
  PmenuKind = { bg = f.base03, fg = f.blue },
  PmenuKindSel = { link = 'PmenuSel' },
  PmenuExtra = { link = 'Pmenu' },
  PmenuExtraSel = { link = 'PmenuSel' },
  WildMenu = { link = 'pmenu' },
  StatusLine = { fg = f.base04, bg = f.base08 },
  StatusLineNC = { fg = f.base01, bg = f.base07 },
  WinBar = { bg = f.non },
  WinBarNC = { bg = f.non },
  ErrorMsg = { fg = f.notify_red },
  TODO = { bg = f.blue, fg = f.base02 },
  Conceal = { fg = f.green },
  Error = { fg = f.notify_red },
  NonText = { link = 'Comment' },
  FloatBorder = { fg = f.blue },
  FloatNormal = { link = 'Normal' },
  FloatShadow = { bg = f.base06 },
  Folded = { fg = f.yjvoilet },
  FoldColumn = { link = 'SignColumn' },
  SpellBad = { fg = f.notify_red },
  SpellCap = { undercurl = true, sp = f.notify_blue },
  SpellRare = { undercurl = true, sp = f.voilet },
  SpellLocal = { undercurl = true, sp = f.notify_aqua },
  WarningMsg = { fg = f.notify_red },
  MoreMsg = { fg = f.green },
  NvimInternalError = { fg = f.notify_red },
  Directory = { fg = f.blue },
  --------------------------------------------------------
  ---@Identifier
  Identifier = { fg = f.yslan },
  ['@variable'] = { fg = f.yslan },
  ['@variable.builtin'] = { fg = f.red },
  Constant = { fg = f.orange },
  ['@constant.builtin'] = { link = 'Constant' },
  ['@constant.macro'] = {},
  ['@namespace'] = { link = 'Include' },
  --------------------------------------------------------
  ---@Types
  Type = { fg = f.blue },
  ['@type.builtin'] = { link = 'Type' },
  ['@type.definition'] = { link = 'Type' },
  ['@type.qualifier'] = { fg = f.voilet, italic = true },
  ['@storageclass'] = { fg = f.voilet },
  ['@field'] = { fg = f.wzgreen },
  ['@property'] = { fg = f.wzgreen },
  --------------------------------------------------------
  ---@Keywords
  Keyword = { fg = f.voilet },
  ['@keyword.function'] = { link = 'Keyword' },
  ['@keyword.return'] = { fg = f.voilet, italic = true },
  ['@keyword.operator'] = { link = 'Operator' },
  Conditional = { fg = f.dpvoilet },
  Repeat = { link = 'Conditional' },
  Debug = { fg = f.red },
  Label = { fg = f.voilet },
  PreProc = { fg = f.dpvoilet },
  Include = { link = 'PreProc' },
  Exception = { fg = f.voilet },
  Statement = { fg = f.voilet },
  Special = { fg = f.yellow },
  --------------------------------------------------------
  ---@Functions
  Function = { fg = f.yellow },
  ['@function.builtin'] = { fg = f.qblue },
  ['@function.call'] = { link = 'Function' },
  ['@function.macro'] = { link = 'Function' },
  ['@method'] = { link = 'Function' },
  ['@method.call'] = { link = 'Function' },
  ['@constructor'] = { fg = f.wzgreen },
  ['@parameter'] = { fg = f.aqua },
  --------------------------------------------------------
  ---@Literals
  String = { fg = f.applegreen },
  Number = { fg = f.orange },
  Boolean = { fg = f.orange },
  Float = { link = 'Number' },
  --
  Define = { link = 'PreProc' },
  Operator = { fg = f.red },
  Comment = { fg = f.base01 },
  --------------------------------------------------------
  ---@punctuation
  ['@punctuation.bracket'] = { fg = '#7397ab' },
  ['@punctuation.delimiter'] = { fg = '#7397ab' },
  --------------------------------------------------------
  ---@Tag
  ['@tag.html'] = { fg = f.orange },
  ['@tag.attribute.html'] = { link = '@property' },
  ['@tag.delimiter.html'] = { link = '@punctuation.delimiter' },
  ['@tag.javascript'] = { link = '@tag.html' },
  ['@tag.attribute.javascript'] = { link = '@tag.attribute.html' },
  ['@tag.delimiter.javascript'] = { link = '@tag.delimiter.html' },
  ['@tag.typescript'] = { link = '@tag.html' },
  ['@tag.attribute.typescript'] = { link = '@tag.attribute.html' },
  ['@tag.delimiter.typescript'] = { link = '@tag.delimiter.html' },
  --------------------------------------------------------
  --------------------------------------------------------
  ---@Markdown
  ['@text.reference.markdown_inline'] = { fg = f.blue },
  ---@Diff
  DiffAdd = { bg = f.diff_add },
  DiffChange = { bg = f.diff_change },
  DiffDelete = { bg = f.diff_delete },
  DiffText = { bg = f.diff_text },
  diffAdded = { fg = f.green },
  diffRemoved = { fg = f.red },
  diffChanged = { fg = f.blue },
  diffOldFile = { fg = f.yellow },
  diffNewFile = { fg = f.orange },
  diffFile = { fg = f.cyan },
  --------------------------------------------------------
  ---@Diagnostic
  DiagnosticError = { fg = f.notify_red, bg = f.notify_bg },
  DiagnosticWarn = { fg = f.notify_yellow, bg = f.notify_bg },
  DiagnosticInfo = { fg = f.notify_blue, bg = f.notify_bg },
  DiagnosticHint = { fg = f.notify_aqua, bg = f.notify_bg },
  DiagnosticSignError = { link = 'DiagnosticError' },
  DiagnosticSignWarn = { link = 'DiagnosticWarn' },
  DiagnosticSignInfo = { link = 'DiagnosticInfo' },
  DiagnosticSignHint = { link = 'DiagnosticHint' },
  DiagnosticUnderlineError = { undercurl = true, sp = f.notify_red },
  DiagnosticUnderlineWarn = { undercurl = true, sp = f.notify_yellow },
  DiagnosticUnderlineInfo = { undercurl = true, sp = f.notify_blue },
  DiagnosticUnderlineHint = { undercurl = true, sp = f.notify_aqua },
  ---@plugin
  GitSignsAdd = { fg = f.green },
  GitSignsChange = { fg = f.blue },
  GitSignsDelete = { fg = f.notify_red },
  GitSignsChangeDelete = { fg = f.notify_red },
  --cmp
  CmpItemAbbr = { fg = f.manaohui },
  CmpItemAbbrMatch = { fg = f.green },
  CmpItemKind = { fg = f.blue },
  --Telescope
  TelescopePromptBorder = { bg = f.base06, fg = f.base07 },
  TelescopePromptNormal = { bg = f.base06, fg = f.dred },
  TelescopeResultsBorder = { bg = f.base06, fg = f.base07 },
  TelescopeResultsNormal = { fg = f.base04 },
  TelescopePreviewBorder = { bg = f.base06, fg = f.base07 },
  TelescopeSelectionCaret = { fg = f.yellow },
  TelescopeMatching = { fg = f.green },
  --FzfLua
  FzfLuaBorder = { fg = f.base02 },
  FzfLuaTitle = { fg = f.yellow },
  --CursorWord
  CursorWord = { bg = f.base02 },
}

g.terminal_color_0 = f.bg
g.terminal_color_1 = f.red
g.terminal_color_2 = f.applegreen
g.terminal_color_3 = f.yellow
g.terminal_color_4 = f.blue
g.terminal_color_5 = f.violet
g.terminal_color_6 = f.aqua
g.terminal_color_7 = f.base06
g.terminal_color_8 = f.base05
g.terminal_color_9 = f.notify_red
g.terminal_color_10 = f.green
g.terminal_color_11 = f.notify_yellow
g.terminal_color_12 = f.notify_blue
g.terminal_color_13 = f.violet
g.terminal_color_14 = f.notify_aqua
g.terminal_color_15 = f.manaohui

for group, conf in pairs(groups) do
  vim.api.nvim_set_hl(0, group, conf)
end
