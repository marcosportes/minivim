# Minivim

Minimalist Neovim configuration for servers

## Features

### Core
- 100% native - no plugins required
- Built-in Gruvbox theme
- Space-based keybindings
- Centralized configuration for all users
- Works on any Linux distribution

### Enhanced
- Native LSP support with autocomplete
- Snippet expansion (Neovim 0.10+)
- WhichKey helper (`<Space>?`)
- File breadcrumbs in winbar
- Auto-readonly for logs and system files
- Jump to error from logs (`:JumpToError`)
- Filetype-specific indentation
- Better diagnostics display
- Improved diff mode

## Installation

```bash
git clone https://github.com/marcosportes/minivim.git
cd minivim
sudo bash install.sh
```

What it does:
- Install Neovim v0.11.5
- Create centralized config at `/etc/minivim/init.lua`
- Configure all system users automatically
- Add `vim` alias to bashrc

## Keyboard Shortcuts

**Leader key**: `Space`

### File Operations
- `<Space>w` - Save
- `<Space>s` - Save with feedback (green banner)
- `<Space>q` - Quit without saving
- `<Space>Q` - Quit all without saving

### Navigation
- `Ctrl+h/j/k/l` - Navigate between windows
- `Shift+h/l` - Navigate between buffers
- `<Space>e` - File explorer

### Window Management
- `<Space>v` - Vertical split
- `<Space>h` - Horizontal split
- `<Space>x` - Close buffer

### Editing
- `Alt+j/k` - Move line up/down
- `>` / `<` (visual mode) - Indent
- `Esc` - Clear search highlight

### Terminal
- `<Space>t` - Open terminal
- `Esc` - Exit terminal mode

## Advanced Features

### Native Completion
- `Ctrl+n` - Word completion
- `Ctrl+f` - File path completion
- `Ctrl+l` - Line completion

### LSP (if language server installed)
- `gd` - Go to definition
- `K` - Hover documentation
- `<Space>rn` - Rename
- `<Space>ca` - Code action
- `gr` - Find references

### Snippets (Neovim 0.10+)
- `Tab` - Expand/jump forward
- `Shift+Tab` - Jump backward

### Utilities
- `<Space>?` - Show all keybindings
- `:JumpToError` - Jump to file:line from logs
- `:WhichKey` - List available shortcuts

### Auto-readonly Files
Logs and system files automatically open as readonly:
- `/var/log/*`
- `/etc/*`
- `*.log`
- `/sys/*`, `/proc/*`

## Configuration

Edit config with `:Config` command (requires root):

```bash
sudo nvim
:Config
```

Central config: `/etc/minivim/init.lua`

Users can override by creating their own `~/.config/nvim/init.lua`

## Uninstall

```bash
sudo rm -rf /opt/nvim /usr/local/bin/nvim /etc/minivim
rm -rf ~/.config/nvim
```

## License

MIT
