local harpoonMark = require("harpoon.mark")
local harpoonUi = require("harpoon.ui")
local wk = require("which-key")

wk.register({
  ["<leader>h"] = {
    name = "Harpoon",
    a = { harpoonMark.add_file, "Add file to Harpoon" },
    h = { harpoonUi.toggle_quick_menu, "Show Harpoon" },
    ["1"] = { function() harpoonUi.nav_file(1) end, "Goto file 1" },
    ["2"] = { function() harpoonUi.nav_file(1) end, "Goto file 2" },
    ["3"] = { function() harpoonUi.nav_file(1) end, "Goto file 3" },
    ["4"] = { function() harpoonUi.nav_file(1) end, "Goto file 4" },
  }
})
