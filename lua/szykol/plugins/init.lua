return {
  {
    'tpope/vim-fugitive',
    lazy = true,
    event = 'VeryLazy',
  },

  {
    'sindrets/diffview.nvim',
    event = 'VeryLazy',
    config = function()
      require('diffview').setup {
        view = {
          merge_tool = {
            layout = 'diff3_mixed',
          },
        },
      }
    end,
  },

  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    config = function()
      local dap_python = require 'dap-python'
      dap_python.setup '~/.virtualenvs/debugpy/bin/python'
      dap_python.test_runner = 'pytest'

      -- local configurations = require"dap".configurations.python
      -- for _, configuration in pairs(configurations) do
      --   configuration.justMyCode = false
      -- end
    end,
  },

  {
    'leoluz/nvim-dap-go',
    config = function()
      require('dap-go').setup {
        dap_configurations = {
          {
            type = 'go',
            name = 'Attach remote',
            mode = 'remote',
            request = 'attach',
          },
        },
        delve = {
          path = 'dlv',
          initialize_timeout_sec = 20,
          port = '${port}',
          args = {},
          -- the build flags that are passed to delve.
          -- defaults to empty string, but can be used to provide flags
          -- such as "-tags=unit" to make sure the test suite is
          -- compiled during debugging, for example.
          -- passing build flags using args is ineffective, as those are
          -- ignored by delve in dap mode.
          build_flags = '',
        },
      }
    end,
    ft = 'go',
  },

  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-go',
      'nvim-neotest/neotest-python',
      'jfpedroza/neotest-elixir',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-go',
          require 'neotest-python' {
            runner = 'pytest',
            dap = { justMyCode = false },
            python = function()
              return vim.fn.getcwd() .. '/.venv/bin/python'
            end,
          },
          require 'rustaceanvim.neotest',
          require 'neotest-elixir',
        },
      }
    end,
    lazy = true,
  },

  {
    'nvim-tree/nvim-tree.lua',
    version = '*',

    keys = {
      { '<leader>nt', '<cmd>NvimTreeToggle<cr>', desc = '[N]eoTree [t]oggle' },
    },

    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {}
    end,
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    config = function()
      require('dap').configurations.rust = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
          runInTerminal = false,
        },
      }
    end,
  },

  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  {
    'mhinz/vim-rfc',
    cmd = 'RFC',
    lazy = true,
  },

  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    config = true,
  },

  {
    'OXY2DEV/markview.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- Used by the code bloxks
    },

    config = function()
      require('markview').setup()
    end,
  },

  {
    'oysandvik94/curl.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('curl').setup {}
    end,
  },

  -- {
  --   'mfussenegger/nvim-lint',
  --
  --   config = function()
  --     local lint = require 'lint'
  --     lint.linters_by_ft = {
  --       elixir = { 'credo' },
  --     }
  --
  --     local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
  --
  --     vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  --       group = lint_augroup,
  --       callback = function()
  --         lint.try_lint()
  --       end,
  --     })
  --   end,
  -- },

  -- {
  --   'kelly-lin/ranger.nvim',
  --   config = function()
  --     require('ranger-nvim').setup { replace_netrw = true }
  --     vim.api.nvim_set_keymap('n', '<leader>ef', '', {
  --       noremap = true,
  --       callback = function()
  --         require('ranger-nvim').open(true)
  --       end,
  --     })
  --   end,
  -- },

  -- {
  --   'Exafunction/codeium.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'hrsh7th/nvim-cmp',
  --   },
  --   config = function()
  --     require('codeium').setup {}
  --   end,
  -- },
}
