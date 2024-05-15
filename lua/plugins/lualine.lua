return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
  },
  opts = {
    options = {
      theme = 'onedark',
      globalstatus = false,
      component_separators = {},
      -- section_separators = {},
      section_separators = { left = '', right = '' },
      extensions = { 'fugitive', 'quickfix' },
    },
    sections = {
      lualine_a = {
        {
          function()
            return vim.fn.mode()
          end,
        },
      },
      lualine_b = {
        { 'filename', path = 1 },
        {
          function()
            if vim.bo.modified then
              return ''
            elseif vim.bo.modifiable == false or vim.bo.readonly == true then
              return '-'
            end
            return ''
          end,
          color = { fg = '#db525e' },
        },
      },
      lualine_c = {},
      lualine_x = {
        'diagnostics',
        {
          function()
            local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
            local buf_client_names = {}
            for _, client in pairs(buf_clients) do
              table.insert(buf_client_names, client.name)
            end

            local base = table.concat(buf_client_names, ',')
            return '󰌘 ' .. base
          end,
        },
      },
      lualine_y = {
        'filetype',
      },
      lualine_z = { '%4c:%l/%L' },
    },
    inactive_sections = {
      lualine_b = {
        { 'filename', path = 1 },
      },
      lualine_x = { '%{&filetype}' },
    },
  },
}
