#!/bin/bash

# Exit on error
set -e

# Variables
NVIM_VERSION="v0.11.1"
NVIM_APPIMAGE_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.appimage"
NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
KICKSTART_URL="https://raw.githubusercontent.com/nvim-lua/kickstart.nvim/master/init.lua"
BACKUP_DIR="$HOME/.config/nvim-backup-$(date +%F_%H-%M-%S)"

# Step 1: Install dependencies for kickstart.nvim plugins
echo "Installing dependencies (make, gcc, ripgrep, unzip, git, curl)..."
sudo apt update
sudo apt install -y make gcc ripgrep unzip git curl

# Step 2: Install Neovim 0.11.1 via AppImage
echo "Installing Neovim ${NVIM_VERSION}..."
curl -LO "${NVIM_APPIMAGE_URL}"
chmod +x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
# Verify Neovim version
if nvim --version | grep -q "${NVIM_VERSION}"; then
    echo "Neovim ${NVIM_VERSION} installed successfully."
else
    echo "Failed to install Neovim ${NVIM_VERSION}. Exiting."
    exit 1
fi

# Step 3: Backup existing Neovim configuration
if [ -d "$NVIM_CONFIG_DIR" ]; then
    echo "Backing up existing Neovim configuration to $BACKUP_DIR..."
    mkdir -p "$BACKUP_DIR"
    cp -r "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
    rm -rf "$NVIM_CONFIG_DIR"
fi

# Step 4: Create Neovim config directory and download kickstart.nvim
echo "Setting up kickstart.nvim..."
mkdir -p "$NVIM_CONFIG_DIR"
curl -o "$NVIM_CONFIG_DIR/init.lua" "$KICKSTART_URL"

# Step 5: Initialize Neovim to install plugins
echo "Initializing Neovim to install plugins..."
nvim --headless -c 'Lazy sync' -c 'qa'

# Step 6: Verify installation
echo "Verifying kickstart.nvim installation..."
if [ -f "$NVIM_CONFIG_DIR/init.lua" ]; then
    echo "kickstart.nvim installed successfully at $NVIM_CONFIG_DIR/init.lua"
    echo "Run 'nvim' to start Neovim with kickstart.nvim."
else
    echo "Failed to install kickstart.nvim. Check the script and try again."
    exit 1
fi

##!/bin/bash

#sudo apt remove neovim
#wget https://github.com/neovim/neovim/releases/download/v0.11.1/nvim-linux-x86_64.appimage
#chmod +x nvim-linux-x86_64.appimage
#sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
#nvim --version
