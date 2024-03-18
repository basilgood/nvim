return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
  },
  opts = {
    options = {
      theme = 'iceberg_dark',
      globalstatus = false,
      component_separators = {},
      section_separators = {},
    },
    sections = {
      lualine_a = { { 'branch', icon = '' } },
      lualine_b = {
        { '%t' },
        {
          function()
            if vim.bo.modified then
              return ''
            elseif vim.bo.modifiable == false or vim.bo.readonly == true then
              return '-'
            end
            return ''
          end,
          color = { fg = '#db525e' },
        },
      },
      lualine_c = {},
      lualine_x = { 'diagnostics' },
      lualine_y = { 'filetype' },
      lualine_z = { '%4c:%l/%L' },
    },
    inactive_sections = {
      lualine_x = { '%{&filetype}' },
    },
  },
}
