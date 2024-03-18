return {
  {
    'kevinhwang91/nvim-bqf',
    opts = {
      auto_resize_height = true,
      preview = {
        auto_preview = false,
        winblend = 1,
      },
    },
  },

  {
    'yorickpeterse/nvim-pqf',
    event = 'VeryLazy',
    opts = {
      show_multiple_lines = true,
      max_filename_length = 40,
    },
  },
}
