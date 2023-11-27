local isStartedInProjects = function()
  local curdir = vim.fn.expand("%:p:h")
  return curdir:match("/Projects") ~= nil
end

return isStartedInProjects
