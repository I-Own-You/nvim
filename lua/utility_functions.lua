local M = {}
function M.goto_defintion()
	local current_buffer = vim.api.nvim_get_current_buf()
	local absolute_path = vim.fn.expand("#" .. current_buffer .. ":p")
	vim.lsp.buf.definition({
		reuse_win = false,
		on_list = function(def_list)
			for _, item in ipairs(def_list["items"]) do
				if item["filename"] == absolute_path then
					vim.lsp.buf.definition()
          break
				else
					vim.cmd("tab split | lua vim.lsp.buf.definition()")
          break
				end
			end
		end,
	})
end
return M
