-- ========================================
-- Minivim Keymaps
-- ========================================

local M = {}

function M.setup()
  local keymap = vim.keymap.set

  -- Navigate between windows
  keymap("n", "<C-h>", "<C-w>h", { desc = "Window left" })
  keymap("n", "<C-j>", "<C-w>j", { desc = "Window down" })
  keymap("n", "<C-k>", "<C-w>k", { desc = "Window up" })
  keymap("n", "<C-l>", "<C-w>l", { desc = "Window right" })

  -- Resize windows
  keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase height" })
  keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease height" })
  keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })
  keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase width" })

  -- Buffer navigation
  keymap("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
  keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
  keymap("n", "<leader>x", ":bdelete<CR>", { desc = "Close buffer" })

  -- Move lines
  keymap("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
  keymap("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
  keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
  keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

  -- Visual indentation
  keymap("v", "<", "<gv", { desc = "Indent left" })
  keymap("v", ">", ">gv", { desc = "Indent right" })

  -- Clipboard operations (works via SSH with OSC52)
  keymap("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
  keymap("v", "<C-x>", '"+d', { desc = "Cut to system clipboard" })
  -- Use 'p' in normal mode or '"+p' to paste from system clipboard

  -- Keep centered when searching
  keymap("n", "n", "nzzzv", { desc = "Next result" })
  keymap("n", "N", "Nzzzv", { desc = "Previous result" })

  -- Clear search highlight
  keymap("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear highlight" })

  -- Save and quit
  keymap("n", "<leader>w", ":w<CR>", { desc = "Save" })

  -- Smart save with persistent visual feedback
  keymap("n", "<leader>s", function()
    if vim.bo.readonly then
      vim.notify("✗ File is readonly! Use :q! to quit", vim.log.levels.WARN)
      return
    end
    vim.cmd("write")
    _G.minivim_saved = true
    vim.cmd("redraw")
  end, { desc = "Save with feedback" })

  keymap("n", "<leader>q", ":q!<CR>", { desc = "Quit without saving (force)" })
  keymap("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all without saving (force)" })

  -- Split
  keymap("n", "<leader>v", ":vsplit<CR>", { desc = "Vertical split" })
  keymap("n", "<leader>h", ":split<CR>", { desc = "Horizontal split" })

  -- Native file explorer (VSCode-like sidebar)
  keymap("n", "<leader>e", ":Lexplore<CR>", { desc = "Toggle file explorer sidebar" })
  keymap("n", "<leader>E", ":Explore<CR>", { desc = "File explorer in current window" })

  -- Integrated terminal
  keymap("n", "<leader>t", ":terminal<CR>", { desc = "Open terminal" })
  keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

  -- Native completion keybindings (insert mode)
  keymap("i", "<C-n>", "<C-x><C-n>", { desc = "Word completion" })
  keymap("i", "<C-f>", "<C-x><C-f>", { desc = "File completion" })
  keymap("i", "<C-l>", "<C-x><C-l>", { desc = "Line completion" })
  keymap("i", "<C-Space>", "<C-x><C-n>", { desc = "Trigger word completion" })

  -- Snippet keybindings (if available in Neovim 0.10+)
  if vim.snippet then
    keymap({ "i", "s" }, "<Tab>", function()
      if vim.snippet.active({ direction = 1 }) then
        return "<cmd>lua vim.snippet.jump(1)<CR>"
      else
        return "<Tab>"
      end
    end, { expr = true })

    keymap({ "i", "s" }, "<S-Tab>", function()
      if vim.snippet.active({ direction = -1 }) then
        return "<cmd>lua vim.snippet.jump(-1)<CR>"
      else
        return "<S-Tab>"
      end
    end, { expr = true })
  end
end

return M
