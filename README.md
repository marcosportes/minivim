# Minivim

**Minimalist Neovim configuration for servers**

A lightweight, plugin-free Neovim setup with built-in Gruvbox theme. Perfect for server environments where you need a powerful editor without the overhead of plugin managers and external dependencies.

## Features

- **100% Native** - No plugins, no package managers, zero dependencies
- **Built-in Gruvbox Theme** - Beautiful dark color scheme included
- **Essential Keybindings** - Productive shortcuts with Space as leader key
- **Smart Defaults** - Line numbers, syntax highlighting, smart search, and more
- **Auto-installation** - Configures Neovim for all system users automatically
- **Persistent Undo** - Never lose your work
- **System Clipboard Integration** - Seamless copy/paste
- **Modern Features** - Native file explorer, integrated terminal, auto-indentation

## Compatibility

- **Neovim**: 0.8+
- **Supported Linux Distributions**:
  - Debian-based: Ubuntu, Debian, Linux Mint, Pop!_OS, etc.
  - Arch-based: Arch Linux, Manjaro, EndeavourOS, etc.
  - RHEL-based: Fedora, CentOS, Rocky Linux, AlmaLinux, etc.
  - openSUSE and derivatives
  - Any distribution with: `apt`, `pacman`, `dnf`, `yum`, or `zypper` package manager

## Quick Start

### Installation

Run as root or with sudo:

```bash
curl -fsSL https://raw.githubusercontent.com/yourusername/minivim/main/install.sh | sudo bash
```

Or clone and run locally:

```bash
git clone https://github.com/yourusername/minivim.git
cd minivim
sudo bash install.sh
```

### What it does

1. Removes old Neovim installations
2. Installs Neovim v0.10.2 from official releases
3. Creates configuration for all system users
4. Backs up existing configurations automatically

## Keyboard Shortcuts

**Leader key**: `Space`

### File Operations
- `<Space>w` - Save file
- `<Space>s` - Save and quit (force)
- `<Space>q` - Quit without saving (force)
- `<Space>Q` - Quit all without saving (force)
- **Note**: Read-only files show `[READONLY]` in red banner (top and bottom)

### Navigation
- `Ctrl+h/j/k/l` - Navigate between windows (left/down/up/right)
- `Shift+h/l` - Navigate between buffers (previous/next)
- `<Space>e` - Open file explorer (Netrw)

### Window Management
- `<Space>v` - Vertical split
- `<Space>h` - Horizontal split
- `<Space>x` - Close current buffer
- `Ctrl+Up/Down/Left/Right` - Resize windows

### Editing
- `Alt+j/k` - Move line or selection up/down
- `>` / `<` (in visual mode) - Indent right/left (keeps selection)
- `Esc` - Clear search highlight

### Terminal
- `<Space>t` - Open integrated terminal
- `Esc` (in terminal) - Exit terminal mode

## Configuration

The configuration file is located at `/etc/minivim/init.lua` (centralized for all users). Each user's config at `~/.config/nvim/init.lua` is a symlink to this central file.

### Quick Edit Configuration

The easiest way to edit the configuration is using the built-in command:

```vim
:Config
```

This command opens the central configuration file (`/etc/minivim/init.lua`) directly in Neovim.

**For read-only files**: The statusline shows `[READONLY]` in red. To edit system files like `/etc/minivim/init.lua`, open Neovim as root:

```bash
sudo nvim
:Config
```

### Customization

Edit the central config file to customize:

- Change leader key (default: Space)
- Adjust indentation settings (default: 4 spaces)
- Modify color scheme variables
- Add custom keybindings
- Configure file-type specific settings

**Note:** Changes to `/etc/minivim/init.lua` affect all system users. Individual users can override by removing their symlink and creating their own `~/.config/nvim/init.lua`.

### Manual Installation

If you prefer to manually install just the configuration:

```bash
mkdir -p ~/.config/nvim
curl -fsSL https://raw.githubusercontent.com/yourusername/minivim/main/init.lua -o ~/.config/nvim/init.lua
```

## Default Settings

```lua
number = true                  -- Line numbers
relativenumber = true          -- Relative line numbers
expandtab = true               -- Spaces instead of tabs
shiftwidth = 4                 -- 4 space indentation
tabstop = 4                    -- Tab = 4 spaces
smartindent = true             -- Smart auto-indentation
wrap = false                   -- No line wrapping
swapfile = false               -- No swap files
backup = false                 -- No backup files
undofile = true                -- Persistent undo
hlsearch = true                -- Highlight search results
ignorecase = true              -- Case insensitive search
smartcase = true               -- Case sensitive if uppercase
termguicolors = true           -- True color support
cursorline = true              -- Highlight current line
mouse = "a"                    -- Mouse support
clipboard = "unnamedplus"      -- System clipboard
```

## Autocommands

Minivim includes useful automatic behaviors:

- **Highlight on yank** - Visual feedback when copying text
- **Trim whitespace** - Automatically removes trailing spaces on save
- **Last position** - Returns to last cursor position when reopening files

## File Explorer (Netrw)

Press `<Space>e` to open the native file explorer.

**Netrw shortcuts**:
- `Enter` - Open file/directory
- `-` - Go up one directory
- `%` - Create new file
- `d` - Create new directory
- `D` - Delete file/directory
- `R` - Rename file/directory

## Philosophy

Minivim follows these principles:

1. **Simplicity** - One file configuration, no plugin management
2. **Speed** - Instant startup, no plugin loading time
3. **Reliability** - Native features only, no breaking updates
4. **Portability** - Works anywhere Neovim runs
5. **Maintainability** - Easy to understand and modify

## Uninstallation

To remove Neovim:

```bash
sudo rm -rf /opt/nvim
sudo rm /usr/local/bin/nvim
```

To remove configurations (for current user):

```bash
rm -rf ~/.config/nvim
```

## FAQ

**Q: Why no plugins?**
A: For server environments, simplicity and reliability trump extensive features. Neovim's native capabilities are powerful enough for most editing tasks.

**Q: Can I add plugins later?**
A: Yes! This is a starting point. You can add lazy.nvim or packer.nvim if you need plugins later.

**Q: Why Gruvbox?**
A: It's easy on the eyes, works well in terminals, and the palette is simple to implement natively.

**Q: Which distributions are supported?**
A: The script automatically detects your package manager and works on Debian/Ubuntu (apt), Arch (pacman), Fedora/RHEL (dnf/yum), and openSUSE (zypper). It should work on any major Linux distribution.

**Q: Can I use this on macOS?**
A: The `init.lua` file works on macOS, but the install script is Linux-specific. Install Neovim via Homebrew and copy the init.lua manually:
```bash
brew install neovim
mkdir -p ~/.config/nvim
curl -fsSL https://raw.githubusercontent.com/yourusername/minivim/main/init.lua -o ~/.config/nvim/init.lua
```

**Q: How do I update Neovim?**
A: Edit the `NVIM_VERSION` variable in `install.sh` and run it again.

## Contributing

Contributions are welcome! Please:

1. Keep it simple - no plugins
2. Follow existing code style
3. Test on Ubuntu/Debian
4. Update documentation

## License

MIT License - use freely, modify as needed.

## Credits

- **Neovim** - [neovim.org](https://neovim.org)
- **Gruvbox** - Color scheme by [@morhetz](https://github.com/morhetz/gruvbox)

---

**Made with ❤️ for minimalist server admins**
