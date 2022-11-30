local config = require("root-switcher.config")

-- mode types
local FILE = "file"
local PROJECT = "project"

-- current mode: FILE | PROJECT
Mode = config.defaults.starting_mode
-- project root
ProjectRoot = config.defaults.project_root

local M = {}

function M.setup(opts)
  config.setup(opts)
  Mode = config.options.starting_mode

  if type(config.options.project_root) == "string" then
    ProjectRoot = config.options.project_root
  else
    local group = vim.api.nvim_create_augroup("RootSwitcher", { clear = true })
    -- apply mode on every BufEnter
    vim.api.nvim_create_autocmd("BufEnter", {
      group = group,
      callback = function()
        M.apply_mode({ notify = false, warn = false })
      end,
    })
    -- set ProjectRoot with function on every DirChanged
    vim.api.nvim_create_autocmd("DirChanged", {
      group = group,
      callback = function()
        ProjectRoot = config.options.project_root()
      end,
    })
  end
end

function M.change_project_root(root)
  ProjectRoot = root
  M.apply_mode()
end

function M.file_mode()
  Mode = FILE
  M.apply_mode()
end

function M.project_mode()
  Mode = PROJECT
  M.apply_mode()
end

function M.apply_mode(options)
  -- defaults options
  local defaults = { notify = true, warn = true }
  options = vim.tbl_deep_extend("force", defaults, options or {})

  -- check for excluded filetype
  if config.options.exclude_filetypes[vim.bo.filetype] ~= nil then
    if options.warn then
      vim.notify("Cannot switch root mode in filetype " .. vim.bo.filetype, vim.log.levels.WARN)
    end
    return
  end

  -- cd to directory for given mode
  if Mode == PROJECT then
    vim.api.nvim_set_current_dir(ProjectRoot)
  else -- Mode == FILE then
    vim.api.nvim_set_current_dir(vim.fn.expand("%:p:h"))
  end

  -- optionally notify
  if options.notify then
    vim.notify(vim.fn.getcwd() .. " (cwd = " .. (Mode == FILE and "file" or "project") .. ")", vim.log.levels.INFO)
  end
end

function M.toggle()
  if Mode == PROJECT then
    Mode = FILE
  else -- Mode == FILE then
    Mode = PROJECT
  end
  M.apply_mode()
end

return M
