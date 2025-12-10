# Minivim

Minimalist Neovim configuration for servers

## Features

- 100% native - no plugins required
- Built-in Gruvbox theme
- Space-based keybindings
- Centralized configuration for all users
- Read-only file indicator
- Works on any Linux distribution

## Installation

```bash
git clone https://github.com/marcosportes/minivim.git
cd minivim
sudo bash install.sh
```

The script will:
- Install Neovim v0.11.5
- Create centralized config at `/etc/minivim/init.lua`
- Configure all system users automatically
- Add `vim` alias to bashrc

## Keyboard Shortcuts

**Leader key**: `Space`

### File Operations
- `<Space>w` - Save
- `<Space>s` - Save and quit
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
