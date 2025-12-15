-- ========================================
-- Minivim Welcome Screen
-- ========================================

local M = {}

function M.setup()
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      -- Only show on startup with no files
      if vim.fn.argc() == 0 and vim.fn.line2byte('$') == -1 then
        -- Get Neovim version
        local version = vim.version()
        local nvim_version = string.format("NVIM v%d.%d.%d", version.major, version.minor, version.patch)

        local lines = {
          "███╗   ███╗██╗███╗   ██╗██╗██╗   ██╗██╗███╗   ███╗",
          "████╗ ████║██║████╗  ██║██║██║   ██║██║████╗ ████║",
          "██╔████╔██║██║██╔██╗ ██║██║██║   ██║██║██╔████╔██║",
          "██║╚██╔╝██║██║██║╚██╗██║██║╚██╗ ██╔╝██║██║╚██╔╝██║",
          "██║ ╚═╝ ██║██║██║ ╚████║██║ ╚████╔╝ ██║██║ ╚═╝ ██║",
          "╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
          "",
          "       Minimalist Neovim - 100% Native",
          "                " .. nvim_version,
          "",
          "          Developed by Marcos Portes",
          "           with Claude AI (Anthropic)",
          "        github.com/marcosportes/minivim",
          "",
          "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
          "",
          "Quick Start:",
          "  :e <file>           Open file",
          "  :Config             Edit configuration",
          "",
          "Essential Shortcuts:",
          "  Space + e           Toggle sidebar explorer",
          "  Space + t           Terminal",
          "  Space + s           Save file",
          "  Space + q           Quit",
          "  Space + ?           Show all shortcuts",
          "",
          "Navigation:",
          "  Ctrl + h/j/k/l      Move between windows",
          "  :<number>           Jump to line",
          "",
          "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
          "",
          "Type :help nvim for full documentation",
          "",
        }

        -- Calculate padding for centering
        local height = vim.api.nvim_win_get_height(0)
        local width = vim.api.nvim_win_get_width(0)
        local content_height = #lines
        local v_padding = math.max(0, math.floor((height - content_height) / 2))

        -- Find the width of the logo (first non-empty line)
        local logo_width = vim.fn.strdisplaywidth(lines[1])
        local logo_left_padding = math.floor((width - logo_width) / 2)

        -- Add vertical padding and align all text to the left edge of the logo
        local padded_lines = {}
        for _ = 1, v_padding do
          table.insert(padded_lines, "")
        end

        for _, line in ipairs(lines) do
          if line == "" then
            table.insert(padded_lines, "")
          else
            -- All lines use the same left padding as the logo
            table.insert(padded_lines, string.rep(" ", logo_left_padding) .. line)
          end
        end

        vim.api.nvim_buf_set_lines(0, 0, -1, false, padded_lines)
        vim.bo.modifiable = false
        vim.bo.buftype = "nofile"
        vim.bo.bufhidden = "wipe"
        vim.bo.buflisted = false
        vim.bo.swapfile = false
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.cursorline = false
        vim.opt_local.colorcolumn = ""
        vim.opt_local.signcolumn = "no"
        vim.opt_local.statusline = " "
        vim.opt_local.winbar = ""

        -- Force solid background (disable syntax and set proper background)
        vim.cmd("syntax off")
        vim.cmd("setlocal winhighlight=Normal:Normal,EndOfBuffer:Normal")

        -- Apply background color to entire window
        vim.api.nvim_set_hl(0, "Normal", { bg = "#282828", fg = "#ebdbb2" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#282828", fg = "#282828" })
      end
    end,
  })

  -- Success message
  vim.notify("✓ Minivim loaded successfully!", vim.log.levels.INFO)
end

return M
