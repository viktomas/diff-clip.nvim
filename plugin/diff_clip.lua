vim.api.nvim_create_user_command("Diffclip", require("diff_clip").diff, { range = true })
