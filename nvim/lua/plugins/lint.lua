return {
  'mfussenegger/nvim-lint',
  ft = {'java', 'lua'},
  config = function()
    require('lint').linters.javac = {
      cmd = './lint.sh',
      -- cwd = vim.fn.getcwd(),
      stdin = false,
      append_fname = false,
      -- args = {'clean', 'compile', '-DskipTests', '|', 'rg', '"WARNING"'},
      stream = 'stdout',
      ignore_exitcode = false,
      env = nil,
      parser = require('lint.parser').from_pattern('^%[(WARNING)%]%s([%w/.]+):%[(%d+),(%d+)%]%s%[%w+%]%s(.*)$', {'severity', 'file', 'lnum', 'col', 'message'})
    }
  end
}
