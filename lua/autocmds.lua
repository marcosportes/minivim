-- ========================================
-- Minivim Autocommands
-- ========================================

local M = {}

function M.setup()
  local augroup = vim.api.nvim_create_augroup
  local autocmd = vim.api.nvim_create_autocmd

  -- Netrw: Keep explorer open when opening files (VSCode-like behavior)
  autocmd("FileType", {
    group = augroup("NetrwKeepOpen", { clear = true }),
    pattern = "netrw",
    callback = function()
      -- Map Enter to open file and keep focus on it
      vim.keymap.set("n", "<CR>", function()
        -- If it's a directory, use default behavior
        local line = vim.fn.getline(".")
        if line:match("/$") then
          vim.cmd("normal! \r")
        else
          -- Open file in previous window and move cursor there
          vim.cmd("normal! \r")
          vim.cmd("wincmd p")
        end
      end, { buffer = true, silent = true })
    end,
  })

  -- Clear save feedback when user starts editing again
  autocmd({ "InsertEnter", "TextChanged", "TextChangedI" }, {
    group = augroup("ClearSaveFlag", { clear = true }),
    callback = function()
      if _G.minivim_saved then
        _G.minivim_saved = false
        vim.cmd("redraw")
      end
    end,
  })

  -- Highlight on yank
  autocmd("TextYankPost", {
    group = augroup("HighlightYank", { clear = true }),
    pattern = "*",
    callback = function()
      vim.highlight.on_yank({ timeout = 200 })
    end,
  })

  -- Remove trailing whitespace on save
  autocmd("BufWritePre", {
    group = augroup("TrimWhitespace", { clear = true }),
    pattern = "*",
    command = [[%s/\s\+$//e]],
  })

  -- Return to last position when opening file
  autocmd("BufReadPost", {
    group = augroup("LastPosition", { clear = true }),
    pattern = "*",
    callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  })

  -- Optimize help window to prevent freezing
  autocmd("FileType", {
    group = augroup("HelpWindow", { clear = true }),
    pattern = "help",
    callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn = "no"
      vim.opt_local.cursorline = false
      vim.opt_local.colorcolumn = ""
      vim.cmd("wincmd L")  -- Move help to vertical split on right
    end,
  })

  -- Auto-readonly for common log files and system paths
  autocmd("BufRead", {
    group = augroup("AutoReadonly", { clear = true }),
    pattern = {
      "/var/log/*",
      "/etc/*",
      "*.log",
      "/sys/*",
      "/proc/*"
    },
    callback = function()
      -- Skip netrw buffers
      if vim.bo.filetype == "netrw" then
        return
      end

      -- Skip if running as root (UID 0)
      local uid = vim.fn.system("id -u"):gsub("%s+", "")
      if uid == "0" then
        return
      end

      -- Only set readonly if file is not writable by current user
      local filepath = vim.fn.expand("%:p")
      if filepath ~= "" and vim.fn.filewritable(filepath) == 0 then
        vim.bo.readonly = true
        vim.bo.modifiable = false
      end
    end,
  })

  -- Filetype-specific settings
  local filetype_group = augroup("FileTypeSettings", { clear = true })

  autocmd("FileType", {
    group = filetype_group,
    pattern = "python",
    callback = function()
      vim.bo.expandtab = true
      vim.bo.shiftwidth = 4
      vim.bo.tabstop = 4
    end,
  })

  autocmd("FileType", {
    group = filetype_group,
    pattern = { "javascript", "typescript", "json", "yaml", "html", "css" },
    callback = function()
      vim.bo.expandtab = true
      vim.bo.shiftwidth = 2
      vim.bo.tabstop = 2
    end,
  })

  autocmd("FileType", {
    group = filetype_group,
    pattern = "go",
    callback = function()
      vim.bo.expandtab = false
      vim.bo.shiftwidth = 4
      vim.bo.tabstop = 4
    end,
  })

  autocmd("FileType", {
    group = filetype_group,
    pattern = "markdown",
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })

  -- Auto-trigger word completion while typing
  autocmd("TextChangedI", {
    group = augroup("AutoComplete", { clear = true }),
    callback = function()
      -- Get current line and column
      local line = vim.api.nvim_get_current_line()
      local col = vim.api.nvim_win_get_cursor(0)[2]

      -- Only trigger after typing 2+ consecutive alphanumeric characters
      if col > 1 then
        local char = line:sub(col, col)
        local prev_char = line:sub(col-1, col-1)

        -- Check if we're typing a word (2+ alphanumeric chars in a row)
        if char:match('[%w_]') and prev_char:match('[%w_]') then
          -- Small delay to avoid triggering too often
          vim.defer_fn(function()
            if vim.fn.pumvisible() == 0 then
              -- Use word completion
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-x><C-n>', true, false, true), 'n')
            end
          end, 100)
        end
      end
    end,
  })
end

return M
