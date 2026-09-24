local fn = vim.fn

local M = {}

--- Check if an executable exists
--- @param name string An executable name/path
--- @return boolean
function M.executable(name)
  return fn.executable(name) > 0
end

return M
