local base = {
  _0 = '#1B2B34',
  _1 = '#343D46',
  _2 = '#4F5B66',
  _3 = '#65737E',
  _4 = '#A7ADBA',
  _5 = '#C0C5CE',
  _6 = '#CDD3DE',
  _7 = '#b0b6ba',
  _8 = '#EC5f67',
  _9 = '#cc6699',
  _A = '#9494c5',
  _B = '#79b573',
  _C = '#62b3b2',
  _D = '#6699CC',
  _E = '#C594C5',
  _F = '#AB7967',
}

local white = '#FFFFFF'
local diffbg = '#25353e'
local none = 'none'
local italic = 'italic'
local bold = 'bold'
local undercurl = 'undercurl'
local underline = 'underline'

local syntax = {
  Bold = { attr = bold },
  Italic = { attr = italic },
  Debug = { fg = base._8 },
  Directory = { fg = base._D },
  ErrorMsg = { fg = base._8, bg = base._0 },
  Exception = { fg = base._8 },
  FoldColumn = { fg = base._D, bg = base._0 },
  Folded = { fg = base._3, bg = base._1, attr = italic },
  IncSearch = { fg = base._1, bg = base._9, attr = none },
  Macro = { fg = base._8 },
  MatchParen = { fg = base._7, bg = base._2 },
  ModeMsg = { fg = base._B },
  MoreMsg = { fg = base._B },
  Question = { fg = base._D },
  Search = { fg = base._3, bg = base._A },
  SpecialKey = { fg = base._3 },
  TooLong = { fg = base._8 },
  Underlined = { fg = base._8 },
  Visual = { bg = base._2 },
  VisualNOS = { fg = base._8 },
  WarningMsg = { fg = base._8 },
  WildMenu = { fg = base._0, bg = base._D, attr = bold },
  Title = { fg = base._D },
  Conceal = { fg = base._D, bg = base._0 },

  Cursor = { fg = base._0, bg = base._5 },
  CursorColumn = { bg = base._1 },
  CursorLine = { bg = base._1, attr = none },
  CursorLineNr = { fg = base._3, bg = base._1 },
  TermCursor = { fg = base._0, bg = base._5, attr = none },
  TermCursorNC = { fg = base._0, bg = base._5 },

  NonText = { fg = base._2 },
  Normal = { fg = base._7, bg = base._0 },
  EndOfBuffer = { fg = base._5, bg = base._0 },
  LineNr = { fg = base._3, bg = base._0 },
  SignColumn = { fg = base._0, bg = base._0 },
  StatusLine = { fg = base._4, bg = base._2, cattr = none },
  StatusLineNC = { fg = base._3, bg = base._1 },
  WinSeparator = { fg = base._2 },
  ColorColumn = { bg = base._1 },
  PMenu = { fg = base._4, bg = base._1 },
  PMenuSel = { fg = base._7, bg = base._D },
  PmenuSbar = { bg = base._2 },
  PmenuThumb = { bg = base._7 },
  TabLine = { fg = base._3, bg = base._1 },
  TabLineFill = { fg = base._3, bg = base._1 },
  TabLineSel = { fg = base._B, bg = base._1 },
  helpExample = { fg = base._A },
  helpCommand = { fg = base._A },

  Boolean = { fg = base._9 },
  Character = { fg = base._8 },
  Comment = { fg = base._3, attr = italic },
  Conditional = { fg = base._E },
  Constant = { fg = base._9 },
  Define = { fg = base._E },
  Delimiter = { fg = base._F },
  Float = { fg = base._9 },
  Function = { fg = base._D },

  Identifier = { fg = base._C },
  Include = { fg = base._D },
  Keyword = { fg = base._E },

  Label = { fg = base._A },
  Number = { fg = base._9 },
  Operator = { fg = base._5 },
  PreProc = { fg = base._A },
  Repeat = { fg = base._A },
  Special = { fg = base._C },
  SpecialChar = { fg = base._F },
  Statement = { fg = base._8 },
  StorageClass = { fg = base._A },
  String = { fg = base._B },
  Structure = { fg = base._E },
  Tag = { fg = base._A },
  Todo = { fg = base._A, bg = base._1 },
  Type = { fg = base._A },
  Typedef = { fg = base._A },

  DiagnosticError = { fg = base._8, bg = base._1 },
  DiagnosticWarn = { fg = base._A, bg = base._1 },
  DiagnosticInfo = { fg = base._D, bg = base._1 },
  DiagnosticHint = { fg = base._C, bg = base._1 },

  DiagnosticUnderlineError = { attr = underline },
  DiagnosticUnderlineWarn = { attr = underline },
  DiagnosticUnderlineInfo = { attr = underline },
  DiagnosticUnderlineHint = { attr = underline },

  GitConflictCurrent = { bg = '#22281f' },
  GitConflictCurrentLabel = { bg = '#22281f' },
  GitConflictIncoming = { bg = '#1f2328' },
  GitConflictIncomingLabel = { bg = '#1f2328' },
  GitConflictAncestor = { bg = '#262323' },
  GitConflictAncestorLabel = { bg = '#262323' },

  ['@include'] = { fg = base._C },
  ['@punctuation.bracket'] = { fg = base._C },
  ['@punctuation.delimiter'] = { fg = base._7 },
  ['@type'] = { fg = base._A },
  ['@function'] = { fg = base._D },
  ['@tag.delimiter'] = { fg = base._C },
  ['@property'] = { fg = base._A },
  ['@method'] = { fg = base._D },
  ['@parameter'] = { fg = base._A },
  ['@constructor'] = { fg = base._7 },
  ['@variable'] = { fg = base._7 },
  ['@operator'] = { fg = base._7 },
  ['@tag'] = { fg = base._7 },
  ['@keyword'] = { fg = base._E },
  ['@keyword.operator'] = { fg = base._E },
  ['@variable.builtin'] = { fg = base._8 },
  ['@label'] = { fg = base._C },

  SpellBad = { attr = undercurl },
  SpellLocal = { attr = undercurl },
  SpellCap = { attr = undercurl },
  SpellRare = { attr = undercurl },

  csClass = { fg = base._A },
  csAttribute = { fg = base._A },
  csModifier = { fg = base._E },
  csType = { fg = base._8 },
  csUnspecifiedStatement = { fg = base._D },
  csContextualStatement = { fg = base._E },
  csNewDecleration = { fg = base._8 },
  cOperator = { fg = base._C },
  cPreCondit = { fg = base._E },

  cssColor = { fg = base._C },
  cssBraces = { fg = base._5 },
  cssClassName = { fg = base._E },

  -- builtins
  DiffAdd = { fg = none, bg = diffbg },
  DiffChange = { fg = none, bg = diffbg },
  DiffDelete = { fg = none, bg = diffbg },
  DiffText = { fg = base._D, bg = base._0, attr = bold },

  DiffAdded = { fg = base._B, bg = base._0, attr = bold },
  DiffFile = { fg = base._8, bg = base._0 },
  DiffNewFile = { fg = base._B, bg = base._0 },
  DiffLine = { fg = base._D, bg = base._0 },
  DiffRemoved = { fg = base._8, bg = base._0, attr = bold },

  gitCommitOverflow = { fg = base._8 },
  gitCommitSummary = { fg = base._B },

  htmlBold = { fg = base._A },
  htmlItalic = { fg = base._E },
  htmlTag = { fg = base._C },
  htmlEndTag = { fg = base._C },
  htmlArg = { fg = base._A },
  htmlTagName = { fg = base._7 },

  javaScript = { fg = base._5 },
  javaScriptNumber = { fg = base._9 },
  javaScriptBraces = { fg = base._5 },

  jsonKeyword = { fg = base._B },
  jsonQuote = { fg = base._B },

  markdownCode = { fg = base._B },
  markdownCodeBlock = { fg = base._B },
  markdownHeadingDelimiter = { fg = base._D },
  markdownItalic = { fg = base._E, attr = italic },
  markdownBold = { fg = base._A, attr = bold },
  markdownCodeDelimiter = { fg = base._F, attr = italic },
  markdownError = { fg = base._5, bg = base._0 },

  typescriptParens = { fg = base._5, bg = none },

  phpComparison = { fg = base._5 },
  phpParent = { fg = base._5 },
  phpMemberSelector = { fg = base._5 },

  pythonRepeat = { fg = base._E },
  pythonOperator = { fg = base._E },

  rubyConstant = { fg = base._A },
  rubySymbol = { fg = base._B },
  rubyAttribute = { fg = base._D },
  rubyInterpolation = { fg = base._B },
  rubyInterpolationDelimiter = { fg = base._F },
  rubyStringDelimiter = { fg = base._B },
  rubyRegexp = { fg = base._C },

  sassidChar = { fg = base._8 },
  sassClassChar = { fg = base._9 },
  sassInclude = { fg = base._E },
  sassMixing = { fg = base._E },
  sassMixinName = { fg = base._D },

  GitSignsAdd = { fg = base._B, bg = base._0, attr = bold },
  GitSignsChange = { fg = base._D, bg = base._0, attr = bold },
  GitSignsDelete = { fg = base._8, bg = base._0, attr = bold },
  GitSignsChangeDelete = { fg = base._E, bg = base._0, attr = bold },

  FzfLuaBorder = { fg = '#4f5b66' },

  xmlTag = { fg = base._C },
  xmlTagName = { fg = base._5 },
  xmlEndTag = { fg = base._C },

  CocErrorSign = { fg = base._8 },
  CocWarningSign = { fg = base._A },
  CocInfoSign = { fg = base._D },
  CocHintSign = { fg = base._C },
  CocErrorFloat = { fg = base._8 },
  CocWarningFloat = { fg = base._A },
  CocInfoFloat = { fg = base._D },
  CocHintFloat = { fg = base._C },
  CocDiagnosticsError = { fg = base._8 },
  CocDiagnosticsWarning = { fg = base._A },
  CocDiagnosticsInfo = { fg = base._D },
  CocDiagnosticsHint = { fg = base._C },
  CocSelectedText = { fg = base._E },
  CocCodeLens = { fg = base._4 },
}

vim.g.terminal_color_0 = base._0
vim.g.terminal_color_1 = base._8
vim.g.terminal_color_2 = base._B
vim.g.terminal_color_3 = base._A
vim.g.terminal_color_4 = base._D
vim.g.terminal_color_5 = base._E
vim.g.terminal_color_6 = base._C
vim.g.terminal_color_7 = base._5
vim.g.terminal_color_8 = base._3
vim.g.terminal_color_9 = base._8
vim.g.terminal_color_10 = base._B
vim.g.terminal_color_11 = base._A
vim.g.terminal_color_12 = base._D
vim.g.terminal_color_13 = base._E
vim.g.terminal_color_14 = base._C
vim.g.terminal_color_15 = base._5
vim.g.terminal_color_background = base._0
vim.g.terminal_color_foreground = white

vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end
vim.opt.background = 'dark'
vim.opt.termguicolors = true
vim.g.colors_name = 'oceanic'

function format(prefix, attribute)
  if attribute then
    return prefix .. attribute .. ' '
  end

  return ''
end

for group, colour in pairs(syntax) do
  vim.api.nvim_command(
    'highlight '
      .. group
      .. ' '
      .. format('guifg=', colour.fg)
      .. format('guibg=', colour.bg)
      .. format('gui=', colour.attr)
      .. format('guisp=', colour.attrsp)
      .. format('cterm=', colour.cattr)
  )
end

vim.cmd('hi link LspDiagnosticsDefaultError DiagnosticError')
vim.cmd('hi link LspDiagnosticsDefaultWarning DiagnosticWarn')
vim.cmd('hi link LspDiagnosticsDefaultInformation DiagnosticInfo')
vim.cmd('hi link LspDiagnosticsDefaultHint DiagnosticHint')

vim.cmd('hi link LspDiagnosticsSignError DiagnosticError')
vim.cmd('hi link LspDiagnosticsSignWarning DiagnosticWarn')
vim.cmd('hi link LspDiagnosticsSignInformation DiagnosticInfo')
vim.cmd('hi link LspDiagnosticsSignHint DiagnosticHint')

vim.cmd('hi link LspDiagnosticsUnderlineError DiagnosticUnderlineError')
vim.cmd('hi link LspDiagnosticsUnderlineWarning DiagnosticUnderlineWarn')
vim.cmd('hi link LspDiagnosticsUnderlineInformation DiagnosticUnderlineInfo')
vim.cmd('hi link LspDiagnosticsUnderlineHint DiagnosticUnderlineHint')

return syntax
