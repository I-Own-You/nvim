local UC = {}

UC.MyTabLine = function()
	local s = ""
	local tabpages = vim.api.nvim_list_tabpages()
	local current_tab = vim.api.nvim_get_current_tabpage()

	for i, tab_handle in ipairs(tabpages) do
		if tab_handle == current_tab then
			s = s .. "%#TabLineSel#"
		else
			s = s .. "%#TabLine#"
		end

		s = s .. "%" .. i .. "T"

		local has_custom_name, custom_name = pcall(vim.api.nvim_tabpage_get_var, tab_handle, "tab_title")

		if has_custom_name then
			s = s .. " " .. custom_name .. " "
		else
			local win = vim.api.nvim_tabpage_get_win(tab_handle)
			local buf = vim.api.nvim_win_get_buf(win)
			local bufname = vim.api.nvim_buf_get_name(buf)
			local filename = vim.fn.fnamemodify(bufname, ":t")
			if filename == "" then
				filename = "[No Name]"
			end
			s = s .. " " .. filename .. " "
		end
	end
	s = s .. "%#TabLineFill#%T"
	return s
end

return UC
