return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  config = function()
    -- disable netrw (recommended by nvim-tree docs)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require('nvim-tree').setup {
      sort = {
        sorter = 'case_sensitive',
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false, -- show dotfiles
      },
      git = {
        enable = true,
        ignore = false,
      },
      actions = {
        open_file = {
          quit_on_open = false,
        },
      },
    }

    -- Keymap to toggle NvimTree
    vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })

    -- Auto-open tree when starting in a directory
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function(data)
        -- buffer is a directory
        local directory = vim.fn.isdirectory(data.file) == 1
        if directory then
          vim.cmd.cd(data.file)
          require('nvim-tree.api').tree.open()
        end
      end,
    })
  end,
}
