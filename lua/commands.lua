-- ========================================
-- Minivim Custom Commands
-- ========================================

local M = {}

function M.setup()
  -- Open central config file for editing
  vim.api.nvim_create_user_command("Config", function()
    vim.cmd("edit /etc/minivim/init.lua")
  end, { desc = "Edit Minivim configuration" })

  -- Jump to error from log files (format: file:line or file:line:col)
  vim.api.nvim_create_user_command("JumpToError", function()
    local line = vim.fn.getline(".")
    local match = vim.fn.matchlist(line, [[\v([^:]+):(\d+):?(\d*)]])
    if #match > 0 then
      local file, lnum, col = match[2], tonumber(match[3]), tonumber(match[4]) or 1
      vim.cmd("edit " .. file)
      vim.fn.cursor(lnum, col)
    else
      print("No error pattern found on current line")
    end
  end, { desc = "Jump to file:line:col under cursor" })

  -- Which Key helper - show available keybindings
  local function show_keymaps()
    local maps = vim.api.nvim_get_keymap('n')
    local leader_maps = {}

    for _, map in ipairs(maps) do
      if map.lhs:match('^<Leader>') or map.lhs:match('^ ') then
        local desc = map.desc or map.rhs or ''
        table.insert(leader_maps, string.format("  %s -> %s", map.lhs:gsub('<Leader>', 'SPC'), desc))
      end
    end

    if #leader_maps > 0 then
      vim.notify("Available Leader Keybindings:\n" .. table.concat(leader_maps, "\n"), vim.log.levels.INFO)
    end
  end

  vim.api.nvim_create_user_command("WhichKey", show_keymaps, { desc = "Show leader keybindings" })
  vim.keymap.set("n", "<leader>?", show_keymaps, { desc = "Show keybindings" })
end

return M
