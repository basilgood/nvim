return {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && npm install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },
  {
    'blackhat-7/vellum.nvim',
    ft = 'markdown',
    keys = { { '<leader>mp', '<cmd>Vellum<cr>', desc = 'Markdown preview' } },
    opts = {},
  },
}
