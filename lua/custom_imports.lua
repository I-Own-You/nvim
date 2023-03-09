local M = {}

local function fileExists(path)
  local ok, err, code = os.rename(path, path)
  if not ok and code == 13 then
    -- Code 13 means "permission denied", but the file exists
    return true
  end
  return ok, err
end

function better_import()
    local imported = vim.fn.getreg('') --copy content that you yy from nvim

    -- Get the buffer ID of the current buffer
    local current_buf = vim.api.nvim_get_current_buf()

    -- Get the path of the file associated with the buffer
    local buf_name = vim.api.nvim_buf_get_name(current_buf)

    for line_num = 1, vim.api.nvim_buf_line_count(current_buf) do
        -- Get the current line
        local line = vim.api.nvim_buf_get_lines(current_buf, line_num - 1, line_num, false)[1]

        -- Check if the line starts with "form", "import", or a space
        if string.match(line, "^from") or string.match(line, "^import") or string.match(line, "^%s*$") then
            if string.match(line, "^from") then
                local line_from_imported = {}
                local original_line = {}

                for word in imported:gmatch("%S+") do
                    table.insert(line_from_imported, word)
                end
                for word in line:gmatch("%S+") do
                    table.insert(original_line, word)
                end

                if line_from_imported[2] == original_line[2] then
                    vim.api.nvim_buf_set_lines(current_buf, line_num - 1, line_num, false, {line .. ", " .. line_from_imported[4]})
                    break
                end
            end
        else
            vim.api.nvim_command("execute 'normal! gg0\"0P<CR><C-o>'")
            -- Abort if the line does not match any of the conditions
            break
        end
    end
end


function filter(buf, word)
    local contents = {}
    local auim_script = '/home/mkc/zsh_custom_scripts/create_django_auto_imports.py'

    -- local name = vim.fn.input("From which package: ")
    -- local path = names[name]
    -- if not path then
    --     print("Invalid name")
    --     return
    -- end


    local names = {
        player_market = "/home/mkc/Documents/projects/home/player_market/project_auto_imports.txt",
        python_std_lib = "/home/mkc/.config/nvim/py_stdlib.txt",
        django = "/home/mkc/.config/nvim/django_imports.txt",
        djangorest = "",
        -- add more name-value pairs here
    }
.
    vim.ui.select({
        'player_market',
        'django',
        'python_std_lib'
    }, {
        prompt = '',
        format_item = function(item)
            return  item
        end,
    }, function(choice)
            if choice == 'player_market' then
                path = names[choice]
                vim.o.expandtab = true
            elseif choice == 'django' then
                path = names[choice]
                vim.o.expandtab = true
            elseif choice == 'python_std_lib' then
                path = names[choice]
                vim.o.expandtab = true
            else
                vim.o.expandtab = false
            end
        end)

    -- if string.find(path, 'project_auto_imports.txt') then
    if fileExists(path) and string.find(path, 'project_auto_imports')  then
        os.execute("rm " .. path)
        os.execute("python3.11 " .. auim_script .. " " .. path)
    end
    if not fileExists(path) then -- dont create again files from .config/nvim/
    -- if not fileExists(path) then
        os.execute("python3.11 " .. auim_script .. " " .. path)
    end
    -- end

  local file = io.open(path, 'r')
  if file then
    for line in file:lines() do
      -- if vim.fn.match(line, word) >= 0 then
        if string.find(line:lower(), word:lower()) then
            table.insert(contents, line)
            if #contents >= 1000 then
                break
            end
      end
    end
    file:close()
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, contents)
end

function M.centered_window()
  local width = vim.o.columns
  local height = vim.o.lines
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = math.floor(width * 0.8),
    height = math.floor(height * 0.8),
    row = math.floor((height - height * 0.8) / 2),
    col = math.floor((width - width * 0.8) / 2),
    focusable = true,
    style = 'minimal',
    border = {
      {"╭", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╮", "FloatBorder"},
      {"│", "FloatBorder"},
      {"╯", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╰", "FloatBorder"},
      {"│", "FloatBorder"},
    },
  })
  vim.api.nvim_buf_set_option(buf, "filetype", "lua")


---------------------------
    local contents = {}
    local auim_script = '/home/mkc/zsh_custom_scripts/create_django_auto_imports.py'
    local names = {
        player_market = "/home/mkc/Documents/projects/home/player_market/project_auto_imports.txt",
        django = "/home/mkc/.config/nvim/django_imports.txt",
        djangorest = "",
        python_std_lib = "/home/mkc/.config/nvim/py_stdlib.txt",
        -- add more name-value pairs here
    }

    vim.ui.select({
        'player_market',
        'django',
        'python_std_lib',
    }, {
        prompt = '',
        format_item = function(item)
            return  item
        end,
    }, function(choice)
            if choice == 'player_market' then
                path = names[choice]
                vim.o.expandtab = true
            elseif choice == 'django' then
                path = names[choice]
                vim.o.expandtab = true
            elseif choice == 'python_std_lib' then
                path = names[choice]
                vim.o.expandtab = true
            else
                vim.o.expandtab = false
            end
        end)

    -- if string.find(path, 'project_auto_imports.txt') then
    if fileExists(path) and string.find(path, 'project_auto_imports')  then
        os.execute("rm " .. path)
        os.execute("python3.11 " .. auim_script .. " " .. path)
    end
    if not fileExists(path) then -- dont create again files from .config/nvim/
    -- if not fileExists(path) then
        os.execute("python3.11 " .. auim_script .. " " .. path)
    end
    -- end

    local word = vim.fn.getreg('"') -- get the word i yanked in keymaps.lua for <leader>ii
  local file = io.open(path, 'r')
  if file then
    for line in file:lines() do
      -- if vim.fn.match(line, word) >= 0 then
        if string.find(line:lower(), word:lower()) then
            table.insert(contents, line)
            if #contents >= 1000 then
                break
            end
      end
    end
    file:close()
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, contents)

---------------------------

  -- Set key mapping for filtering
    vim.api.nvim_buf_set_keymap(buf, 'n', 'f', string.format(':lua filter(%d, vim.fn.input("Word to import: "))<CR>', buf), { noremap = true })
    -- vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', string.format('yy:q<cr>:normal! gg0"0P<CR><C-o>', buf), { noremap = true})
    vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', string.format('yy:q<cr>:lua better_import()<cr>', buf), { noremap = true})


    vim.api.nvim_feedkeys("jk", "n", true)
end

return M
