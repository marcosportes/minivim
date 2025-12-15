-- ========================================
-- Minivim Theme - Gruvbox (Native)
-- ========================================

local M = {}

function M.setup()
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

  -- Winbar with breadcrumbs and readonly indicator
  _G.minivim_saved = false

  _G.minivim_get_winbar = function()
    if _G.minivim_saved then
      return '%#DiffAdd# ✓ FILE SAVED - Press <Space>q to quit %*'
    elseif vim.bo.readonly then
      return '%#WinBarRO# [READONLY - Press :q! to quit without saving] %*'
    else
      local filepath = vim.fn.expand('%:~:.')
      if filepath == '' then filepath = '[No Name]' end
      return '%#WinBar# ' .. filepath .. ' %*'
    end
  end

  vim.opt.winbar = '%{%v:lua.minivim_get_winbar()%}'

  -- Highlight for readonly indicator (statusline and winbar)
  vim.cmd([[
    hi StatusLineRO guifg=#fb4934 guibg=#3c3836 gui=bold
    hi WinBarRO guifg=#282828 guibg=#fb4934 gui=bold
    hi WinBarRODim guifg=#282828 guibg=#cc241d gui=bold
    hi WinBar guifg=#ebdbb2 guibg=#282828
    hi DiffAdd guifg=#282828 guibg=#b8bb26 gui=bold
    au BufEnter,WinEnter * if &readonly | hi StatusLine guifg=#fb4934 guibg=#3c3836 gui=bold | hi WinBar guifg=#282828 guibg=#fb4934 gui=bold | else | hi StatusLine guifg=#ebdbb2 guibg=#504945 gui=bold | hi WinBar guifg=#ebdbb2 guibg=#282828 | endif
  ]])

  -- Blinking effect for readonly winbar
  _G.minivim_readonly_blink = false
  local readonly_timer = vim.loop.new_timer()
  readonly_timer:start(0, 500, vim.schedule_wrap(function()
    -- Only blink if current buffer is readonly
    if vim.bo.readonly then
      _G.minivim_readonly_blink = not _G.minivim_readonly_blink
      if _G.minivim_readonly_blink then
        vim.cmd("hi WinBarRO guifg=#282828 guibg=#cc241d gui=bold")
      else
        vim.cmd("hi WinBarRO guifg=#282828 guibg=#fb4934 gui=bold")
      end
      vim.cmd("redraw")
    end
  end))
end

return M
