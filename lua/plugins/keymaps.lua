return {
  'nvim-mini/mini.keymap',
  config = function()
    require('mini.keymap').setup()

    local map_multistep = require('mini.keymap').map_multistep
    local map_combo = require('mini.keymap').map_combo
    local map = vim.keymap.set

    map_multistep({ 'i', 's' }, '<Tab>', { 'vimsnippet_next', 'blink_next' })
    map_multistep({ 'i', 's' }, '<S-Tab>', { 'vimsnippet_prev', 'blink_prev' })
    map_multistep('i', '<CR>', { 'blink_accept' })

    map('n', 'j', 'gj')
    map('n', 'k', 'gk')
    map('n', '<Down>', 'gj')
    map('n', '<Up>', 'gk')

    map('n', '-', '<Plug>(nvim-dir-up)', { desc = 'Open directory listing' })

    map_combo('t', 'jk', '<BS><BS><C-\\><C-n>')
    map_combo('t', 'kj', '<BS><BS><C-\\><C-n>')
    map_combo({ 'i', 'c', 'x', 's' }, 'jk', '<BS><BS><Esc>')
    map_combo('n', 'vv', 'viw', { delay = 1000 })

    map_combo('n', '[e', function()
      vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
    end, { desc = 'Previous error diagnostic' })

    map_combo('n', ']e', function()
      vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
    end, { desc = 'Next error diagnostic' })
  end,
}
