return {
  'hrsh7th/nvim-anydent',
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        if not vim.tbl_contains({ 'html', 'yaml', 'markdown' }, vim.bo.filetype) then
          require('anydent').attach()
        end
      end,
    })
  end,
}
