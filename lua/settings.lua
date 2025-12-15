-- ========================================
-- Minivim Basic Settings
-- ========================================

local M = {}

function M.setup()
  -- Basic settings
  vim.opt.number = true                    -- Line numbers (absolute)
  vim.opt.relativenumber = false           -- Disable relative line numbers
  vim.opt.expandtab = true                 -- Use spaces instead of tabs
  vim.opt.shiftwidth = 4                   -- Indent with 4 spaces
  vim.opt.tabstop = 4                      -- Tab = 4 spaces
  vim.opt.smartindent = true               -- Smart auto-indentation
  vim.opt.wrap = false                     -- Don't wrap long lines
  vim.opt.swapfile = false                 -- Disable swap files
  vim.opt.backup = false                   -- Disable backups
  vim.opt.undofile = true                  -- Enable persistent undo
  vim.opt.hlsearch = true                  -- Highlight search results
  vim.opt.incsearch = true                 -- Incremental search
  vim.opt.ignorecase = true                -- Ignore case in search
  vim.opt.smartcase = true                 -- Case-sensitive if uppercase present
  vim.opt.termguicolors = true             -- True colors
  vim.opt.scrolloff = 8                    -- Keep 8 lines when scrolling
  vim.opt.sidescrolloff = 8                -- Keep 8 columns when scrolling
  vim.opt.signcolumn = "yes"               -- Always show sign column
  vim.opt.updatetime = 50                  -- Fast update time
  vim.opt.colorcolumn = "120"              -- Guide line at 80 characters
  vim.opt.cursorline = true                -- Highlight current line
  vim.opt.mouse = "a"                      -- Enable mouse
  vim.opt.clipboard = "unnamedplus"        -- Use system clipboard
  vim.opt.splitright = true                -- Vertical split to the right
  vim.opt.splitbelow = true                -- Horizontal split below
  vim.opt.helpheight = 20                  -- Help window height (prevents freezing)
  vim.opt.showmode = false                 -- Don't show mode (we have statusline)
  vim.opt.laststatus = 2                   -- Always show statusline
  vim.opt.ruler = true                     -- Show cursor position
  vim.opt.showcmd = true                   -- Show partial commands

  -- Performance improvements
  vim.opt.lazyredraw = true                -- Don't redraw during macros
  vim.opt.synmaxcol = 240                  -- Limit syntax highlighting column

  -- Completion settings
  vim.opt.completeopt = "menu,menuone,noselect"  -- Better completion experience
  vim.opt.pumheight = 10                   -- Popup menu height

  -- Diff mode improvements
  vim.opt.diffopt = "internal,filler,closeoff,vertical,linematch:60"

  -- Set leader key
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  -- Netrw (native file explorer) configuration - VSCode-like sidebar
  vim.g.netrw_banner = 0           -- Disable banner
  vim.g.netrw_liststyle = 3        -- Tree view
  vim.g.netrw_browse_split = 4     -- Open in previous window
  vim.g.netrw_altv = 1             -- Open splits to the right
  vim.g.netrw_winsize = 25         -- 25% width
  vim.g.netrw_keepdir = 0          -- Keep current directory synced
end

return M
