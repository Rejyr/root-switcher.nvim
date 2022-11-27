local M = {}

M.defaults = {
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

M.options = {}

function M.setup(opts)
    M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
