local M = {}

function M.my_tab_line()
	local tabpages = vim.api.nvim_list_tabpages()
	local current_tab = vim.api.nvim_get_current_tabpage()
	local total = #tabpages
	local cur = 1
	local labels, widths = {}, {}

	for i, tab_handle in ipairs(tabpages) do
		if tab_handle == current_tab then
			cur = i
		end

		local has_custom_name, name = pcall(vim.api.nvim_tabpage_get_var, tab_handle, "tab_title")
		if not has_custom_name or name == "" then
			local win = vim.api.nvim_tabpage_get_win(tab_handle)
			local buf = vim.api.nvim_win_get_buf(win)
			name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
			if name == "" then
				name = "[No Name]"
			end
		end

		local label = " " .. name .. " "
		widths[i] = vim.api.nvim_strwidth(label)
		labels[i] = (label:gsub("%%", "%%%%"))
	end

	local max_width = vim.o.columns - 4
	local first, last = cur, cur
	local used = widths[cur]
	while true do
		local grew = false
		if first > 1 and used + widths[first - 1] <= max_width then
			first = first - 1
			used = used + widths[first]
			grew = true
		end
		if last < total and used + widths[last + 1] <= max_width then
			last = last + 1
			used = used + widths[last]
			grew = true
		end
		if not grew then
			break
		end
	end

	local s = ""
	if first > 1 then
		s = s .. "%#TabLineFill#< "
	end
	for i = first, last do
		s = s .. (i == cur and "%#TabLineSel#" or "%#TabLine#") .. "%" .. i .. "T" .. labels[i]
	end
	s = s .. "%#TabLineFill#%T"
	if last < total then
		s = s .. " >"
	end
	return s
end

function M.env_picker()
	local env = vim.fn.environ()
	local entries = {}

	local ansi = require("fzf-lua").utils.ansi_codes

	for key, value in pairs(env) do
		entries[#entries + 1] = ansi.yellow(key) .. "=" .. ansi.green(value)
	end

	table.sort(entries)

	local function copy(selected, field)
		if not selected or not selected[1] then
			return
		end

		local plain = selected[1]:gsub("\27%[[%d;]*m", "")
		local key, value = plain:match("^([^=]*)=(.*)$")

		if not key then
			return
		end

		local result = field == "key" and key or field == "value" and value or plain

		vim.fn.setreg("+", result)
		vim.notify("Copied: " .. result)
	end

	require("fzf-lua").fzf_exec(entries, {
		prompt = "Environment Variables> ",
		header = ":: Enter: copy key   |   Ctrl-Y: copy value   |   Ctrl-A: copy KEY=value\n ",
		fzf_opts = {
			["--ansi"] = true,
		},
		actions = {
			["default"] = function(selected)
				copy(selected, "key")
			end,
			["ctrl-y"] = function(selected)
				copy(selected, "value")
			end,
			["ctrl-a"] = function(selected)
				copy(selected, "both")
			end,
		},
	})
end

return M
