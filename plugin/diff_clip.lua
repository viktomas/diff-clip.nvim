vim.api.nvim_create_user_command("MyFirstFunction", require("diff_clip").hello, {})
vim.api.nvim_create_user_command("XX", require("diff_clip").diff, {})
