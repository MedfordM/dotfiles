return {
  {
      'nvim-treesitter/nvim-treesitter',
      version = false,
      build = ":TSUpdate",
      event = { 'BufReadPre', 'BufNewFile' },
      init = function(plugin)
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
      end,
      opts = function()
        return {

          sync_install = false,
          auto_install = true,
          ensure_installed = {
            "java",
            "javascript",
            "typescript",
            "lua",
            "rust",
            "vim",
            "regex",
            "bash",
            "sql",
            "terraform"
          },
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            disable = function(lang, buf)
              -- if (lang == 'markdown') then
              --   return true
              -- end
              local max_filesize = 100 * 1024 -- 100 KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                  return true
              end
            end,
          },

        }
      end,
      config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
        vim.cmd('TSEnable highlight')
        vim.api.nvim_set_hl(0, 'Folded', {})
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        -- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
        -- parser_config.sql = {
        --   install_info = {
        --     url = "https://github.com/MedfordM/tree-sitter-sql", -- local path or git repo
        --     files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
        --     -- optional entries:
        --     branch = "main", -- default branch in case of git repo if different from master
        --     generate_requires_npm = false, -- if stand-alone parser without npm dependencies
        --     requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
        --   },
        --   filetype = "zu", -- if filetype does not match the parser name
        -- }
      end
  },
  {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
    opts = {},
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = { 'BufReadPost' },
    opts = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['ob'] = { query = "@block.outer", desc = "Select outer part of a block" },
          ['oca'] = { query = "@call.outer", desc = "Select outer part of a call" },
          ['ica'] = { query = "@call.inner", desc = "Select inner part of a call" },
          ['ocl'] = { query = "@class.outer", desc = "Select outer part of a class" },
          ['icl'] = { query = "@class.inner", desc = "Select inner part of a class" },
          ['of'] = { query = "@function.outer", desc = "Select outer part of a function" },
          ['if'] = { query = "@function.inner", desc = "Select inner part of a function" },
          ['oco'] = { query = "@conditional.outer", desc = "Select outer part of a condition" },
          ['ico'] = { query = "@conditional.inner", desc = "Select inner part of a condition" },
          ['ol'] = { query = "@loop.outer", desc = "Select outer part of a loop" },
          ['il'] = { query = "@loop.inner", desc = "Select inner part of a loop" },
          ['op'] = { query = "@parameter.outer", desc = "Select outer part of a parameter" },
          ['ip'] = { query = "@parameter.inner", desc = "Select inner part of a parameter" },
        }
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>csp"] = { query = "@parameter.inner", desc = "Swap with next parameter" },
          ["<leader>csf"] = { query = "@function.outer", desc = "Swap with next function" },
        },
        swap_previous = {
          ["<leader>csP"] = { query = "@parameter.inner", desc = "Swap with prev parameter" },
          ["<leader>csF"] = { query = "@function.outer", desc = "Swap with prev function" },
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]b"] = { query = "@block.outer", desc = "Next block start" },
          ["]f"] = { query = "@function.outer", desc = "Next function start" },
          ["]c"] = { query = "@class.outer", desc = "Next class start" },
          ["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
          ["]pt"] = { query = "@parameter.left", desc = "Next parameter type" },
          ["]pn"] = { query = "@parameter.right", desc = "Next parameter name" },
          ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
          ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
        },
        goto_previous_start = {
          ["[b"] = { query = "@block.outer", desc = "Prev block start" },
          ["[f"] = { query = "@function.outer", desc = "Prev function start" },
          ["[c"] = { query = "@class.outer", desc = "Prev class start" },
          ["[p"] = { query = "@parameter.inner", desc = "Prev parameter" },
          ["[pt"] = { query = "@parameter.left", desc = "Prev parameter type" },
          ["[pn"] = { query = "@parameter.right", desc = "Prev parameter name" },
          ["[s"] = { query = "@local.scope", query_group = "locals", desc = "Prev scope" },
          ["[z"] = { query = "@fold", query_group = "folds", desc = "Prev fold" },
        }
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup({
        textobjects = opts
      })
      local tsRepeat = require 'nvim-treesitter.textobjects.repeatable_move' 
      -- Repeat movement with ; and ,
      -- ensure ; goes forward and , goes backward regardless of the last direction
      vim.keymap.set({ "n", "x", "o" }, ";", tsRepeat.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, ",", tsRepeat.repeat_last_move_previous)

      vim.keymap.set({'n'}, '<C-d>', function()
          local bufnr = vim.api.nvim_get_current_buf()
          local parser = vim.treesitter.get_parser(bufnr, 'java')
          if not parser then
            vim.notify('go treesitter parser not found for ' .. vim.fn.bufname(), vim.log.levels.WARN)
            return log('no ts parser found')
          end
          local root = require('nvim-treesitter.ts_utils').get_root_for_position(0, 0)
          local query = vim.treesitter.query.parse('java',
            [[(class_declaration name: (identifier) @name)]]
          )
          for id, node in query:iter_captures(root, bufnr, 0, -1) do
            return vim.treesitter.get_node_text(node, bufnr)
          end
      end)

      local nextDiagnosticRepeat, prevDiagnosticRepeat = tsRepeat.make_repeatable_move_pair(function() vim.diagnostic.jump({count = 1, float=false}) end, function() vim.diagnostic.jump({count = -1, float=true}) end)
      vim.keymap.set({ "n", "x", "o" }, "]d", nextDiagnosticRepeat)
      vim.keymap.set({ "n", "x", "o" }, "[d", prevDiagnosticRepeat)
    end
  },
}
