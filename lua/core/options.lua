local set = vim.opt

set.swapfile = false
set.shiftwidth = 2
set.tabstop = 2
set.expandtab = true
set.gdefault = true
set.number = true
set.wrap = false
set.linebreak = true
set.breakindent = true
set.splitbelow = true
set.splitright = true
set.splitkeep = 'screen'
set.undofile = true
set.autowrite = true
set.autowriteall = true
set.confirm = true
set.signcolumn = 'yes'
set.numberwidth = 3
set.updatetime = 300
set.timeoutlen = 2000
set.ttimeoutlen = 10
set.completeopt = 'menuone,noselect,noinsert'
set.complete:remove('t')
set.pumheight = 5
set.wildmode = 'longest:full,full'
set.diffopt = 'internal,filler,closeoff,context:3,indent-heuristic,algorithm:patience,linematch:60'
set.sessionoptions = 'buffers,curdir,tabpages,folds,winpos,winsize'
set.list = true
set.listchars = { lead = '⋅', trail = '⋅', tab = '┊ ·', nbsp = '␣' }
set.shortmess:append({
  I = true,
  w = true,
  s = true,
})
set.fillchars = {
  eob = ' ',
  diff = ' ',
}
set.grepprg = 'rg --color=never --vimgrep'
set.grepformat = '%f:%l:%c:%m'
