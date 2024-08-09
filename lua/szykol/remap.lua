vim.keymap.set('n', '<leader>dl', function()
  require('dap').step_into()
end, { desc = '[D]ebug step into [l]' })
vim.keymap.set('n', '<leader>dj', function()
  require('dap').step_over()
end, { desc = '[D]ebug step over [j]' })
vim.keymap.set('n', '<leader>dk', function()
  require('dap').step_out()
end, { desc = '[D]ebug step out [k]' })
vim.keymap.set('n', '<leader>dg', function()
  require('dap').continue()
end, { desc = '[D]ebug continue. [g]o' })
vim.keymap.set('n', '<leader>db', function()
  require('dap').toggle_breakpoint()
end, { desc = '[D]ebug toggle [b]reakpoint' })
vim.keymap.set('n', '<leader>dt', function()
  require('dapui').toggle()
end, { desc = '[D]ebug [t]oggle dapui' })
vim.keymap.set('n', '<leader>dn', function()
  require('neotest').run.run()
end, { desc = '[D]ebug test [n]earest' })
vim.keymap.set('n', '<leader>dN', function()
  require('neotest').run.run { strategy = 'dap' }
end, { desc = '[D]ebug [N]earest test. Strategy=dap' })
vim.keymap.set('n', '<leader>do', function()
  require('neotest').output_panel.open()
end, { desc = '[D]ebug [o]utput panel' })

local function git_options()
  local options = {
    { name = 'Status', cmd = 'Git' },
    { name = 'Fetch', cmd = 'Git fetch' },
    { name = 'Pull', cmd = 'Git pull' },
    { name = 'Pull (rebase)', cmd = 'Git pull --force --rebase' },
    { name = 'Push', cmd = 'Git push' },
    { name = 'Push (set upstream)', cmd = 'Git push -u origin @' },
    { name = 'Push (force-with-lease)', cmd = 'Git push --force-with-lease' },
    {
      name = 'Branch create',
      cmd = function()
        vim.ui.input({ prompt = 'Branch name: ' }, function(input)
          if input == nil or input == '' then
            return
          end
          vim.cmd('Git checkout -b ' .. input)
        end)
      end,
    },
    { name = 'Rebase', cmd = 'Git rebase origin/main' },
    { name = 'Diff', cmd = 'DiffviewOpen' },
    { name = 'Diff merge-base', cmd = 'DiffviewOpen origin/main...' },
    { name = 'Diff origin/main', cmd = 'DiffviewOpen origin/main' },
    { name = 'Diff close', cmd = 'DiffviewClose' },
    { name = 'Blame', cmd = 'Git blame' },
    { name = 'Branches', cmd = 'Telescope git_branches' },
    { name = 'Log', cmd = 'Git log' },
    { name = 'Stash', cmd = 'Git stash' },
    { name = 'Stash apply', cmd = 'Git stash apply' },
  }

  vim.ui.select(options, {
    prompt = 'Choose your poison',
    format_item = function(item)
      return item.name
    end,
  }, function(choice)
    -- Ignore empty choices
    if choice == nil or choice == '' then
      return
    end

    if type(choice.cmd) == 'string' then
      vim.cmd(choice.cmd)
    else
      choice.cmd()
    end
  end)
end

vim.keymap.set('n', '<leader>g', git_options, { desc = '[G]it operations' })
