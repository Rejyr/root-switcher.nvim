# root-switcher
Simple plugin to switch between project and file directory

# Features
- Simple (~70 loc)
- No dependencies

# Installation
With [packer](https://github.com/wbthomason/packer.nvim):
```lua
-- lua
use({
  "Rejyr/root-switcher.nvim",
  config = function()
    require("root-switcher").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    })
  end,
})
```

# Configuration
**root-switcher** comes with the following defaults:
```lua
{
  starting_mode = "project", -- starting mode: 'project' | 'file'
  project_root = vim.fn.getcwd(), -- file path of project_root: function | string
  exclude_filetypes = { -- filetypes (vim.bo.filetype) to exclude
    [""] = true,
    ["help"] = true,
    ["nofile"] = true,
    ["NvimTree"] = true,
    ["dashboard"] = true,
    ["TelescopePrompt"] = true,
  },
}
```

# Usage
You can use the following functions in your keybindings:
```lua
-- apply current mode
require("root-switcher").apply_mode()

-- apply 'file' mode
require("root-switcher").file_mode()

-- apply 'project' mode
require("root-switcher").project_mode()

-- toggle between 'file' and 'project' mode
require("root-switcher").toggle()

-- change project root
require("root-switcher").change_project_root("path/to/project/root")
```

Example keybindings:
```lua
-- Lua
vim.keymap.set("n", "<leader>ra", function()
  require("root-switcher").apply_mode()
end, { silent = true })

vim.keymap.set("n", "<leader>rf", function()
  require("root-switcher").file_mode()
end, { silent = true })

vim.keymap.set("n", "<leader>rf", function()
  require("root-switcher").project_mode()
end, { silent = true })

vim.keymap.set("n", "<leader>rr", function()
  require("root-switcher").toggle()
end, { silent = true })
```

# Recipes
You can set the project root with [nvim-rooter](https://github.com/notjedi/nvim-rooter.lua):
```lua
use({
  "Rejyr/root-switcher.nvim",
  requires = { "notjedi/nvim-rooter.lua" },
  config = function()
    require("root-switcher").setup({
      starting_mode = "project",
      project_root = require("nvim-rooter").get_root,
    })
  end,
})
```

# Inspired by
- [NeoRoot](https://github.com/nyngwang/NeoRoot.lua)
