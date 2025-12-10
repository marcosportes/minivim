#!/bin/bash

# Minivim - Minimalist Neovim installation script for servers
# No external plugins - native configuration only + built-in Gruvbox theme
# Compatible with Debian, Ubuntu, Arch, Fedora, openSUSE, and other major distributions

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Minivim Installation ===${NC}\n"
NVIM_VERSION="v0.11.5"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run as root or with sudo${NC}"
    exit 1
fi

# Check required dependencies
echo -e "${GREEN}Checking dependencies...${NC}"
MISSING_DEPS=()

if ! command -v curl &> /dev/null; then
    MISSING_DEPS+=("curl")
fi

if ! command -v git &> /dev/null; then
    MISSING_DEPS+=("git")
fi

if [ ${#MISSING_DEPS[@]} -ne 0 ]; then
    echo -e "${RED}Error: Missing required dependencies: ${MISSING_DEPS[*]}${NC}"
    echo -e "${YELLOW}Please install them first using your package manager.${NC}"
    echo -e "${YELLOW}Examples:${NC}"
    echo -e "  Debian/Ubuntu: ${YELLOW}sudo apt install -y ${MISSING_DEPS[*]}${NC}"
    echo -e "  Arch Linux:    ${YELLOW}sudo pacman -S ${MISSING_DEPS[*]}${NC}"
    echo -e "  Fedora/RHEL:   ${YELLOW}sudo dnf install -y ${MISSING_DEPS[*]}${NC}"
    echo -e "  openSUSE:      ${YELLOW}sudo zypper install -y ${MISSING_DEPS[*]}${NC}"
    exit 1
fi

echo -e "${GREEN}All dependencies found!${NC}\n"

# Get the directory where the script is located (BEFORE changing to /tmp)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGINAL_DIR="$(pwd)"

# Remove old Neovim versions
echo -e "${GREEN}Removing old Neovim versions...${NC}"
rm -f /usr/bin/nvim /usr/local/bin/nvim 2>/dev/null || true

# Install Neovim (latest stable version)
echo -e "\n${GREEN}Installing Neovim...${NC}"
cd /tmp

# Download Neovim
NVIM_ARCHIVE="nvim-linux-x86_64.tar.gz"
DOWNLOAD_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${NVIM_ARCHIVE}"

curl -fLO "${DOWNLOAD_URL}"

# Extract and install
tar xzf "${NVIM_ARCHIVE}"
rm -rf /opt/nvim
mv nvim-linux-x86_64 /opt/nvim
ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
rm -f "${NVIM_ARCHIVE}"

# Verify Neovim installation
if ! command -v nvim &> /dev/null; then
    echo -e "${RED}Neovim installation failed${NC}"
    exit 1
fi

echo -e "${GREEN}Neovim installed successfully!${NC}"
nvim --version | head -n 1

# Central configuration location
CENTRAL_CONFIG="/etc/minivim/init.lua"

# Install central configuration
install_central_config() {
    echo -e "${GREEN}Installing central configuration...${NC}"

    mkdir -p /etc/minivim

    # Try multiple locations for init.lua
    local init_lua_paths=(
        "$SCRIPT_DIR/init.lua"
        "$ORIGINAL_DIR/init.lua"
    )

    local found=0
    for path in "${init_lua_paths[@]}"; do
        if [ -f "$path" ]; then
            cp "$path" "$CENTRAL_CONFIG"
            chmod 644 "$CENTRAL_CONFIG"
            echo -e "${GREEN}Central configuration installed from: $path${NC}"
            found=1
            break
        fi
    done

    if [ $found -eq 0 ]; then
        echo -e "${RED}Error: init.lua not found in any of these locations:${NC}"
        for path in "${init_lua_paths[@]}"; do
            echo -e "${YELLOW}  - $path${NC}"
        done
        echo -e "${YELLOW}Please ensure init.lua is in the same directory as install.sh${NC}"
        exit 1
    fi
}

# Create symlink to central configuration
create_config_symlink() {
    local config_dir=$1

    mkdir -p "$config_dir"

    # Remove old init.lua if it exists and is a regular file
    if [ -f "$config_dir/init.lua" ] && [ ! -L "$config_dir/init.lua" ]; then
        mv "$config_dir/init.lua" "$config_dir/init.lua.backup.$(date +%Y%m%d_%H%M%S)" 2>/dev/null || true
        echo -e "${YELLOW}Backed up existing init.lua${NC}"
    fi

    # Create symlink
    ln -sf "$CENTRAL_CONFIG" "$config_dir/init.lua"
    echo -e "${GREEN}Symlink created: $config_dir/init.lua -> $CENTRAL_CONFIG${NC}"
}

# Function to install configuration for a user
install_config_for_user() {
    local username=$1
    local user_home=$2

    echo -e "\n${YELLOW}Configuring Neovim for: $username${NC}"

    local config_dir="$user_home/.config/nvim"
    local bashrc="$user_home/.bashrc"

    # Backup existing configuration
    if [ -d "$config_dir" ]; then
        echo -e "${YELLOW}Backing up existing configuration...${NC}"
        sudo -u $username mv "$config_dir" "$config_dir.backup.$(date +%Y%m%d_%H%M%S)" 2>/dev/null || true
    fi

    # Create configuration symlink
    sudo -u $username mkdir -p "$config_dir"
    create_config_symlink "$config_dir"

    # Adjust permissions
    chown -R $username:$(id -gn $username) "$config_dir"

    # Add vim alias to bashrc if not already present
    if [ -f "$bashrc" ]; then
        if ! grep -q "alias vim='nvim'" "$bashrc"; then
            echo "" >> "$bashrc"
            echo "# Minivim - Use Neovim as default vim" >> "$bashrc"
            echo "alias vim='nvim'" >> "$bashrc"
            echo -e "${GREEN}Added vim alias to $bashrc${NC}"
        else
            echo -e "${YELLOW}vim alias already exists in $bashrc${NC}"
        fi
    else
        # Create bashrc if it doesn't exist
        sudo -u $username touch "$bashrc"
        echo "# Minivim - Use Neovim as default vim" >> "$bashrc"
        echo "alias vim='nvim'" >> "$bashrc"
        chown $username:$(id -gn $username) "$bashrc"
        echo -e "${GREEN}Created $bashrc with vim alias${NC}"
    fi

    echo -e "${GREEN}Neovim configured for $username!${NC}"
}

# Install central configuration first
install_central_config

# Install for root
echo -e "\n${GREEN}=== Configuring for ROOT ===${NC}"
install_config_for_user "root" "/root"

# Install for all regular users (UID >= 1000)
echo -e "\n${GREEN}=== Configuring for regular users ===${NC}"
while IFS=: read -r username _ uid _ _ home _; do
    if [ "$uid" -ge 1000 ] && [ -d "$home" ] && [ "$home" != "/root" ]; then
        # Check if user has a valid shell
        user_shell=$(getent passwd "$username" | cut -d: -f7)
        if [[ "$user_shell" != *"nologin"* ]] && [[ "$user_shell" != *"false"* ]]; then
            install_config_for_user "$username" "$home"
        fi
    fi
done < /etc/passwd

echo -e "\n${GREEN}========================================${NC}"
echo -e "${GREEN}Installation completed successfully!${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "\n${YELLOW}Installed version:${NC}"
/usr/local/bin/nvim --version | head -n 1
echo -e "\n${YELLOW}Central configuration:${NC}"
echo -e "  Location: ${GREEN}$CENTRAL_CONFIG${NC}"
echo -e "  Quick edit: ${GREEN}sudo nvim${NC} then ${GREEN}:Config${NC}"
echo -e "  Changes affect ALL users automatically"
echo -e "\n${YELLOW}Main shortcuts (Leader = Space):${NC}"
echo -e "  <Space>w     - Save file"
echo -e "  <Space>s     - Save and quit (force)"
echo -e "  <Space>q     - Quit without saving (force)"
echo -e "  <Space>Q     - Quit all without saving (force)"
echo -e "  <Space>e     - File explorer"
echo -e "  <Space>t     - Terminal"
echo -e "  <Space>v     - Vertical split"
echo -e "  <Space>h     - Horizontal split"
echo -e "  <Space>x     - Close buffer"
echo -e "  Shift+H/L    - Navigate between buffers"
echo -e "  Ctrl+H/J/K/L - Navigate between windows"
echo -e "  Esc          - Clear search highlight"
echo -e "\n${YELLOW}Features:${NC}"
echo -e "  ✓ Line numbers (absolute and relative)"
echo -e "  ✓ Gruvbox theme (dark)"
echo -e "  ✓ Syntax highlighting"
echo -e "  ✓ Auto-indentation"
echo -e "  ✓ Read-only indicator (red banner top & bottom)"
echo -e "  ✓ Smart search"
echo -e "  ✓ Persistent undo"
echo -e "  ✓ Mouse enabled"
echo -e "  ✓ System clipboard"
echo -e "  ✓ 100% native - no external plugins\n"
