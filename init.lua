-- ========================================
-- Minivim - Minimalist Neovim + Gruvbox
-- No external plugins - 100% native
-- Compatible with Neovim 0.8+
-- ========================================

-- Basic settings
vim.opt.number = true                    -- Line numbers
vim.opt.relativenumber = true            -- Relative line numbers
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
vim.opt.colorcolumn = "80"               -- Guide line at 80 characters
vim.opt.cursorline = true                -- Highlight current line
vim.opt.mouse = "a"                      -- Enable mouse
vim.opt.clipboard = "unnamedplus"        -- Use system clipboard
vim.opt.splitright = true                -- Vertical split to the right
vim.opt.splitbelow = true                -- Horizontal split below
vim.opt.showmode = false                 -- Don't show mode (we have statusline)
vim.opt.laststatus = 2                   -- Always show statusline
vim.opt.ruler = true                     -- Show cursor position
vim.opt.showcmd = true                   -- Show partial commands

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Gruvbox theme (built-in colors - no plugin required)
vim.cmd([[
  " Gruvbox color scheme (built-in implementation)
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
  set background=dark
  let g:colors_name = "gruvbox"

  " Gruvbox palette
  let s:bg0 = '#282828'
  let s:bg1 = '#3c3836'
  let s:bg2 = '#504945'
  let s:bg3 = '#665c54'
  let s:fg0 = '#fbf1c7'
  let s:fg1 = '#ebdbb2'
  let s:fg2 = '#d5c4a1'
  let s:fg3 = '#bdae93'
  let s:red = '#fb4934'
  let s:green = '#b8bb26'
  let s:yellow = '#fabd2f'
  let s:blue = '#83a598'
  let s:purple = '#d3869b'
  let s:aqua = '#8ec07c'
  let s:orange = '#fe8019'
  let s:gray = '#928374'

  " Editor colors
  exe 'hi Normal guifg=' . s:fg1 . ' guibg=' . s:bg0
  exe 'hi CursorLine guibg=' . s:bg1
  exe 'hi CursorLineNr guifg=' . s:yellow . ' guibg=' . s:bg1 . ' gui=bold'
  exe 'hi LineNr guifg=' . s:bg3
  exe 'hi SignColumn guibg=' . s:bg0
  exe 'hi ColorColumn guibg=' . s:bg1
  exe 'hi Visual guibg=' . s:bg2
  exe 'hi Search guifg=' . s:bg0 . ' guibg=' . s:yellow
  exe 'hi IncSearch guifg=' . s:bg0 . ' guibg=' . s:orange
  exe 'hi StatusLine guifg=' . s:fg1 . ' guibg=' . s:bg2 . ' gui=bold'
  exe 'hi StatusLineNC guifg=' . s:fg3 . ' guibg=' . s:bg1
  exe 'hi VertSplit guifg=' . s:bg2 . ' guibg=' . s:bg0
  exe 'hi Pmenu guifg=' . s:fg1 . ' guibg=' . s:bg2
  exe 'hi PmenuSel guifg=' . s:bg0 . ' guibg=' . s:blue . ' gui=bold'
  exe 'hi TabLine guifg=' . s:fg3 . ' guibg=' . s:bg1
  exe 'hi TabLineFill guibg=' . s:bg1
  exe 'hi TabLineSel guifg=' . s:fg1 . ' guibg=' . s:bg2 . ' gui=bold'

  " Syntax highlighting
  exe 'hi Comment guifg=' . s:gray . ' gui=italic'
  exe 'hi Constant guifg=' . s:purple
  exe 'hi String guifg=' . s:green
  exe 'hi Character guifg=' . s:green
  exe 'hi Number guifg=' . s:purple
  exe 'hi Boolean guifg=' . s:purple
  exe 'hi Float guifg=' . s:purple
  exe 'hi Identifier guifg=' . s:blue
  exe 'hi Function guifg=' . s:aqua . ' gui=bold'
  exe 'hi Statement guifg=' . s:red
  exe 'hi Conditional guifg=' . s:red
  exe 'hi Repeat guifg=' . s:red
  exe 'hi Label guifg=' . s:red
  exe 'hi Operator guifg=' . s:orange
  exe 'hi Keyword guifg=' . s:red
  exe 'hi Exception guifg=' . s:red
  exe 'hi PreProc guifg=' . s:aqua
  exe 'hi Include guifg=' . s:aqua
  exe 'hi Define guifg=' . s:aqua
  exe 'hi Macro guifg=' . s:aqua
  exe 'hi PreCondit guifg=' . s:aqua
  exe 'hi Type guifg=' . s:yellow
  exe 'hi StorageClass guifg=' . s:orange
  exe 'hi Structure guifg=' . s:aqua
  exe 'hi Typedef guifg=' . s:yellow
  exe 'hi Special guifg=' . s:orange
  exe 'hi SpecialChar guifg=' . s:orange
  exe 'hi Tag guifg=' . s:aqua
  exe 'hi Delimiter guifg=' . s:orange
  exe 'hi SpecialComment guifg=' . s:gray . ' gui=italic'
  exe 'hi Debug guifg=' . s:red
  exe 'hi Underlined gui=underline'
  exe 'hi Error guifg=' . s:red . ' guibg=' . s:bg0 . ' gui=bold'
  exe 'hi Todo guifg=' . s:bg0 . ' guibg=' . s:yellow . ' gui=bold'
  exe 'hi Directory guifg=' . s:blue . ' gui=bold'
  exe 'hi Title guifg=' . s:green . ' gui=bold'
]])

-- Custom statusline with readonly indicator
vim.opt.statusline = [[%#StatusLine# %f %m %{&readonly?'[READONLY]':''}%=%y  %l:%c  %p%% ]]

-- Winbar (top bar) for readonly indicator
vim.opt.winbar = [[%{&readonly?'[READONLY - Press :q! to quit without saving]':''}]]

-- Highlight for readonly indicator (statusline and winbar)
vim.cmd([[
  hi StatusLineRO guifg=#fb4934 guibg=#3c3836 gui=bold
  hi WinBarRO guifg=#282828 guibg=#fb4934 gui=bold
  au BufEnter * if &readonly | hi StatusLine guifg=#fb4934 guibg=#3c3836 gui=bold | hi WinBar guifg=#282828 guibg=#fb4934 gui=bold | else | hi StatusLine guifg=#ebdbb2 guibg=#504945 gui=bold | hi WinBar guifg=#ebdbb2 guibg=#282828 | endif
]])

-- Essential keymaps
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

-- Keep centered when searching
keymap("n", "n", "nzzzv", { desc = "Next result" })
keymap("n", "N", "Nzzzv", { desc = "Previous result" })

-- Clear search highlight
keymap("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear highlight" })

-- Save and quit
keymap("n", "<leader>w", ":w<CR>", { desc = "Save" })
keymap("n", "<leader>s", ":wq!<CR>", { desc = "Save and quit (force)" })
keymap("n", "<leader>q", ":q!<CR>", { desc = "Quit without saving (force)" })
keymap("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all without saving (force)" })

-- Split
keymap("n", "<leader>v", ":vsplit<CR>", { desc = "Vertical split" })
keymap("n", "<leader>h", ":split<CR>", { desc = "Horizontal split" })

-- Native file explorer
keymap("n", "<leader>e", ":Explore<CR>", { desc = "File explorer" })

-- Integrated terminal
keymap("n", "<leader>t", ":terminal<CR>", { desc = "Open terminal" })
keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Custom commands
-- Open central config file for editing
vim.api.nvim_create_user_command("Config", function()
  vim.cmd("edit /etc/minivim/init.lua")
end, { desc = "Edit Minivim configuration" })

-- Useful autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

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

print("✓ Minivim loaded successfully!")
