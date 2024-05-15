return {
  'nvim-pack/nvim-spectre',
  cmd = 'Spectre',
  opts = {
    default = {
      find = {
        -- pick one of item in find_engine [ fd, rg ]
        cmd = 'fd',
        options = {},
      },
      replace = {
        -- pick one of item in [ sed, oxi ]
        cmd = 'sed',
      },
    },
    is_insert_mode = true, -- start open panel on is_insert_mode
    is_block_ui_break = true, -- prevent the UI from breaking
    mapping = {
      ['toggle_line'] = {
        map = 'd',
        cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
        desc = 'toggle item.',
      },
      ['enter_file'] = {
        map = '<cr>',
        cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
        desc = 'open file.',
      },
      ['send_to_qf'] = {
        map = 'sqf',
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
        desc = 'send all items to quickfix.',
      },
      ['replace_cmd'] = {
        map = 'src',
        cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
        desc = 'replace command.',
      },
      ['show_option_menu'] = {
        map = 'so',
        cmd = "<cmd>lua require('spectre').show_options()<CR>",
        desc = 'show options.',
      },
      ['run_current_replace'] = {
        map = 'c',
        cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
        desc = 'confirm item.',
      },
      ['run_replace'] = {
        map = 'R',
        cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
        desc = 'replace all.',
      },
      ['change_view_mode'] = {
        map = 'sv',
        cmd = "<cmd>lua require('spectre').change_view()<CR>",
        desc = 'results view mode.',
      },
      ['change_replace_sed'] = {
        map = 'srs',
        cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
        desc = 'use sed to replace.',
      },
      ['change_replace_oxi'] = {
        map = 'sro',
        cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
        desc = 'use oxi to replace.',
      },
      ['toggle_live_update'] = {
        map = 'sar',
        cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
        desc = 'auto refresh changes when nvim writes a file.',
      },
      ['resume_last_search'] = {
        map = 'sl',
        cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
        desc = 'repeat last search.',
      },
      ['insert_qwerty'] = {
        map = 'i',
        cmd = '<cmd>startinsert<CR>',
        desc = 'insert (qwerty).',
      },
      ['insert_colemak'] = {
        map = 'o',
        cmd = '<cmd>startinsert<CR>',
        desc = 'insert (colemak).',
      },
      ['quit'] = {
        map = 'q',
        cmd = "<cmd>lua require('spectre').close()<CR>",
        desc = 'quit.',
      },
    },
  },
}
