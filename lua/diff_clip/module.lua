-- module represents a lua module for the plugin
local M = {}

local function create_new_buffer_with_visual(fist_line, last_line)
  local visual_lines = vim.api.nvim_buf_get_text(0, fist_line, 1, last_line, -1, {})
  local visual_buffer = vim.api.nvim_create_buf(false, true)

  for _, visual_line in ipairs(visual_lines) do
    vim.api.nvim_buf_set_lines(visual_buffer, -1, -1, false, { visual_line })
  end
  vim.api.nvim_buf_set_option(visual_buffer, "modifiable", false)
  vim.api.nvim_set_current_buf(visual_buffer)
end

local function open_register_in_split(register)
  vim.cmd.vsplit()
  local register_content = vim.fn.getreg(register)

  local register_buffer = vim.api.nvim_create_buf(false, true)

  -- sigh, it shouldn't be this hard to split string based on new lines
  for register_line in (register_content .. "\n"):gmatch("(.-)\n") do
    vim.api.nvim_buf_set_lines(register_buffer, -1, -1, false, { register_line })
  end
  vim.api.nvim_buf_set_option(register_buffer, "modifiable", false)

  vim.api.nvim_set_current_buf(register_buffer)
end

M.diff_with_clip = function(opts, register)
  if opts.range ~= 0 then
    create_new_buffer_with_visual(opts.line1, opts.line2)
  end

  vim.cmd.diffthis()

  open_register_in_split(register)

  vim.cmd.diffthis()
end

return M
