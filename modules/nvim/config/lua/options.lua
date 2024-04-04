require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
--

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local first_argument = vim.fn.argv(0)
    if vim.fn.isdirectory(first_argument) ~= 0 then
      vim.api.nvim_command(":cd " .. first_argument)
      require("telescope.builtin").find_files()
    end
  end,
})
