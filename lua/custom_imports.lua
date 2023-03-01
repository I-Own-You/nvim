local M = {}

local function fileExists(path)
  local ok, err, code = os.rename(path, path)
  if not ok and code == 13 then
    -- Code 13 means "permission denied", but the file exists
    return true
  end
  return ok, err
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
        django = "/home/mkc/.config/nvim/django_imports.txt",
        djangorest = "",
        -- add more name-value pairs here
    }

    vim.ui.select({
        'player_market',
        'django',
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
            else
                vim.o.expandtab = false
            end
        end)

    -- if string.find(path, 'project_auto_imports.txt') then
    if fileExists(path) and not string.find(path, '.config/nvim')  then
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
        -- add more name-value pairs here
    }

    vim.ui.select({
        'player_market',
        'django',
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
            else
                vim.o.expandtab = false
            end
        end)

    -- if string.find(path, 'project_auto_imports.txt') then
    if fileExists(path) and not string.find(path, '.config/nvim')  then
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
    vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', string.format('yy:q<cr>:normal! gg0"0P<CR><C-o>', buf), { noremap = true})


    vim.api.nvim_feedkeys("jk", "n", true)
end

return M
