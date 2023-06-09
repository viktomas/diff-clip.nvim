-- module represents a lua module for the plugin
local M = {}

M.my_first_function = function()
  print("hello world! printed")
  return "hello world!"
end

return M
