local map = vim.keymap.set
local ts = require('telescope')
local actions = require('telescope.actions')
ts.setup({
  defaults = {
    prompt_prefix = '➤ ',
    selection_caret = '➤ ',
    path_display = {
      'absolute',
    },
    mappings = {
      i = {
        ['<c-n>'] = actions.cycle_history_prev,
        ['<c-p>'] = actions.cycle_history_next,
        ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
        ['<C-s>'] = actions.select_horizontal,
        ['<C-v>'] = actions.select_vertical,
      },
    },
    layout_strategy = 'vertical',
    layout_config = {
      width = 0.9,
    },
    scroll_strategy = 'limit',
    selection_strategy = 'reset',
    dynamic_preview_title = true,
    results_title = false,
  },
  pickers = {
    find_files = {
      find_command = {
        'fd',
        '-tf',
        '-H',
        '-E=node_modules',
        '-E=.git',
      },
    },
    buffers = {
      sort_mru = true,
      initial_mode = 'normal',
      sort_lastused = true,
      mappings = {
        i = {
          ['<c-x>'] = actions.delete_buffer,
        },
        n = {
          ['dd'] = actions.delete_buffer,
        },
      },
    },
    -- extensions = {
    --   ['ui-select'] = { require('telescope.themes').get_dropdown() },
    -- },
  },
})
ts.load_extension('menufacture')
-- ts.load_extension('ui-select')

map('n', '<c-p>', require('telescope').extensions.menufacture.find_files)
map('n', '<bs>', require('telescope.builtin').buffers)
map('n', '<leader>g', require('telescope').extensions.menufacture.live_grep)
map('n', '<leader>.', require('telescope.builtin').resume)
map('n', 'z=', require('telescope.builtin').spell_suggest)
map('n', '<leader>h', '<cmd>Telescope help_tags<cr>')
map('n', '<leader>o', '<cmd>Telescope oldfiles<cr>')
local opts = { noremap = true, silent = true }
map('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
map('n', 'gD', vim.lsp.buf.declaration, opts)
map('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
map('n', 'gy', '<cmd>Telescope lsp_implementations<CR>', opts)
map('n', 'gT', '<cmd>Telescope lsp_type_definitions<CR>', opts)
map('n', '<leader>d', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)
