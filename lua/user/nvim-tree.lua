local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {

  disable_netrw = true,
  hijack_netrw = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    root_folder_modifier = ":t",
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
    width = 30,
    side = "right",
    mappings = {
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
      },
    },
  },
}



-- h - close node
-- l - edit
-- C-] - cd dir
-- W - collapse all nodes
-- c - copy
-- y - copy name
-- gy - copy absolute path
-- Y - copy relative path
-- a - create
-- x - cut
-- - - dir up
-- E - expand all
-- K - first sibling
-- J - last sibling
-- C-r - full rename
-- ]e - next diagnostic item
-- ]c - next git item
-- P - parent node
-- p - paste
-- [e -prev diagnostic item
-- [c - prev git item
-- TAB - preview file
-- R - refresh
-- d - remove permanent
-- D - trash
-- r - rename
-- e - rename basename
-- . - run file command
-- S - search node
-- C-x - split horizontal
-- C-v - split vertical
-- s - system open file
-- H - toggle dot files
-- C-k - toggle file info
-- C - toggle git clean
-- I - toggle git ignore
