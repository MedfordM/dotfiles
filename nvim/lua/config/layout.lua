local getLayout = function()
  if vim.env.LAYOUT ~= nil then
    return vim.env.LAYOUT
  end
  if vim.env.SSH_CLIENT ~= nil then
    return 'QWERTY'
  else
    return 'COLEMAK'
  end
end

local insert = {
  QWERTY = 'i',
  COLEMAK = 'I'
}

local movement = {
  QWERTY  = {
    LEFT  = 'h',
    DOWN  = 'j',
    UP    = 'k',
    RIGHT = 'l',
    END_WORD = 'e',
  },
  COLEMAK = {
    LEFT  = 'h',
    DOWN  = 'n',
    UP    = 'e',
    RIGHT = 'i',
    END_WORD = 'j',
  }
}

local buffers = {
  QWERTY  = {
    '<leader>1',
    '<leader>2',
    '<leader>3',
    '<leader>4'
  },
  COLEMAK = {
    '<leader>a',
    '<leader>r',
    '<leader>s',
    '<leader>t'
  }
}

local search = {
  QWERTY  = {
    NEXT = 'n',
    PREVIOUS = 'N'
  },
  COLEMAK = {
    NEXT = 'l',
    PREVIOUS = 'L'
  }
}

return {
  layout = getLayout(),
  insert = insert[getLayout()],
  movement = movement[getLayout()],
  buffers = buffers[getLayout()],
  search = search[getLayout()]
}
