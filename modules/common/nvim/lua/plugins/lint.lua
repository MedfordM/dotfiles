return {
  'mfussenegger/nvim-lint',
  ft = 'java',
  config = function(_, _)
    local lint = require('lint')
    lint.linters.infer = {
      cmd = 'infer',
      stdin = false, 
      append_fname = false,
      -- args = {
      --   'run',
      --   '--reactive',
      --   '--continue',
      --   '--java-version',
      --   '21',
      --   '--',
      --   'mvn',
      --   'package',
      --   '-DskipTests'
      -- }
    }
  end
}
