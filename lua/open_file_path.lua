local M = {}
function M.OpenCurrentFolder()
  local buffer_name = vim.fn.bufname("%")
  local cmd = "silent! !open " .. vim.fn.fnamemodify(buffer_name, ":h")
  vim.api.nvim_command(cmd)
end
return M
