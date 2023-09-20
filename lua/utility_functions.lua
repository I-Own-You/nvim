local M = {}
function M.goto_defintion()
	local current_buffer = vim.api.nvim_get_current_buf()
	local absolute_path = vim.fn.expand("#" .. current_buffer .. ":p")
	vim.lsp.buf.definition({
		reuse_win = false,
		on_list = function(def_list)
			local counter = 0
			for _, item in ipairs(def_list["items"]) do
				if item["filename"] == absolute_path then
					vim.lsp.buf.definition()
					return
				else
					counter = counter + 1
					-- vim.cmd("tab split | lua vim.lsp.buf.definition()")
				end
			end
			-- for cases where definiton > 1
			if counter > 1 then
				vim.cmd("lua vim.lsp.buf.definition()")
			else
				vim.cmd("tab split | lua vim.lsp.buf.definition()")
			end
		end,
	})
end
return M
