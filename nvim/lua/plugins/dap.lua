return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      {'<F5>', function() require('dap').continue() end, desc = 'Start Dap'},
      {'<M-right>', function() require('dap').step_into() end, desc = 'Step into'},
      {'<M-up>', function() require('dap').step_out() end, desc = 'Step out'},
      {'<M-x>', function() require('dap').toggle_breakpoint() end, desc = 'Toggle breakpoint'},
      {'<F2>', function() require('dap').set_breakpoint(vim.fn.input('Condition: '), nil, nil) end, desc = 'Conditional Breakpoint'},
      {'<M-q>', function() require('dap').terminate() end, desc = 'Terminate Dap'},
    },
    opts = function()
      return {
        configurations = {
          java = {
            {
              projectName = "assortment-api",
              javaExec = "/home/mike/.sdkman/candidates/java/current/bin/java",
              mainClass = "com.darwin.web.Main",
              vmArgs = '-Dconfig.file=/home/mike/Source/darwin/localFiles/local.conf',
              name = "assortment-api",
              request = "launch",
              type = "java",
              cwd = vim.fn.getcwd()
            },
            {
              projectName = "assortment-planner",
              javaExec = "/home/mike/.sdkman/candidates/java/current/bin/java",
              mainClass = "com.darwin.service.planningService.Main",
              vmArgs = '-Dconfig.file=/home/mike/Source/darwin/localFiles/local.conf',
              name = "assortment-planner",
              request = "launch",
              type = "java",
              cwd = vim.fn.getcwd()
            },
            {
              projectName = "mfp-api",
              javaExec = "/home/mike/.sdkman/candidates/java/current/bin/java",
              mainClass = "com.s5stratos.mfp.api.Main",
              -- vmArgs = '-Dconfig.file=/home/mike/Source/mfp-server/localFiles/local.conf',
              name = "mfp-api",
              request = "launch",
              type = "java",
              cwd = vim.fn.getcwd()
            },
            {
              projectName = "mfp-maintenance",
              javaExec = "/home/mike/.sdkman/candidates/java/current/bin/java",
              mainClass = "com.s5stratos.mfp.maintenance.Main",
              vmArgs = '-Dexec.args="db migrate"',
              name = "mfp-maintenance",
              request = "launch",
              type = "java",
              cwd = vim.fn.getcwd()
            }
          }
        }
      }
    end,
    config = function(_, opts)
      local dap = require("dap")
      dap.configurations = opts.configurations
    end
  }
}
