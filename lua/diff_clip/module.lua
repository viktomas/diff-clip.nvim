-- module represents a lua module for the plugin
local M = {}

M.my_first_function = function()
  print("hello world! printed 2")
  return "hello world!"
end

M.open_empty_buffer = function()
  local bufnr = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_set_current_buf(bufnr)
end

M.test_buffer_new_line = function()
  local bufnr = vim.api.nvim_get_current_buf()
  print(vim.inspect(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)))
end

M.diff_buffer_with_register = function(buffer1, register)
  -- Get the content of the first buffer
  local lines1 = vim.api.nvim_buf_get_lines(buffer1, 0, -1, false)

  print("lines1", vim.inspect(lines1))

  local register_content = vim.fn.getreg(register)

  -- Perform the diff
  local diff_result = vim.diff(table.concat(lines1, "\n"), register_content)

  -- Create a new empty buffer for the diff
  local diff_bufnr = vim.api.nvim_create_buf(false, true)

  -- Set the diff buffer as the current buffer
  vim.api.nvim_set_current_buf(diff_bufnr)

  -- Append the diff lines to the diff buffer
  for diff_line in diff_result:gmatch("[^\n]+") do
    vim.api.nvim_buf_set_lines(diff_bufnr, -1, -1, false, { diff_line })
  end

  -- Set the filetype of the diff buffer (optional)
  vim.api.nvim_buf_set_option(diff_bufnr, "filetype", "diff")

  -- TODO: what's the difference between these two
  -- Disable modification in the diff buffer
  -- Set the diff buffer as read-only
  vim.api.nvim_buf_set_option(diff_bufnr, "readonly", true)
  vim.api.nvim_buf_set_option(diff_bufnr, "modifiable", false)
end

return M
