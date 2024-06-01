#!/bin/bash

# Exit script on any error
set -e

# Function to install dependencies on Ubuntu
install_dependencies_ubuntu() {
  sudo apt-get update
  sudo apt-get install -y git build-essential libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl clang ripgrep tmux
}

# Function to install dependencies on Red Hat-based systems
install_dependencies_redhat() {
  sudo yum groupinstall -y 'Development Tools'
  sudo yum install -y git libtool autoconf automake cmake gcc-c++ make pkgconfig unzip curl clang clang-tools-extra ripgrep tmux
}

# Function to install Neovim in the home directory, handle existing neovim directory, and clean up
install_neovim() {
  # Set the home directory
  HOME_DIR="$HOME"
  
  # Set the Neovim directory path
  NVIM_DIR="$HOME_DIR/neovim"
  
  # Check if the Neovim directory already exists
  if [ -d "$NVIM_DIR" ]; then
    # Rename the existing Neovim directory to neovim.bak
    mv "$NVIM_DIR" "$NVIM_DIR.bak"
    echo "Existing neovim directory moved to neovim.bak"
  fi
  
  # Change to the home directory
  cd "$HOME_DIR" || { echo "Failed to change to home directory"; exit 1; }
  
  # Clone the Neovim repository
  git clone https://github.com/neovim/neovim.git
  
  # Change to the Neovim directory
  cd neovim || { echo "Failed to change to Neovim directory"; exit 1; }
  
  # Checkout the desired version
  git checkout v0.9.5
  
  # Build and install Neovim
  make CMAKE_BUILD_TYPE=Release
  sudo make install
  
  # Change back to the home directory
  cd "$HOME_DIR" || { echo "Failed to change back to the home directory"; exit 1; }
  
  # Clean up: remove the Neovim directory
  sudo rm -rf "$NVIM_DIR"
  
  echo "Neovim installed and temporary files cleaned up."
}

# Function to install packer.nvim
install_packer() {
  local install_path="${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim"
  if [ ! -d "$install_path" ]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$install_path"
  fi
}

# Detect the operating system
if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS=$ID
else
  echo "Cannot detect the operating system."
  exit 1
fi

# Install dependencies based on the operating system
case $OS in
  ubuntu)
    install_dependencies_ubuntu
    ;;
  centos | rhel | fedora)
    install_dependencies_redhat
    ;;
  *)
    echo "Unsupported operating system: $OS"
    exit 1
    ;;
esac


# Check if Neovim is installed
if command -v nvim &> /dev/null; then
    echo "Neovim is already installed"
    nvim --version
else
    # Install Neovim
    install_neovim
fi

# Clone the Neovim configuration repository
if [ -d $HOME/.config/nvim ]; then
  rm -rf $HOME/.config/nvim.bak
  mv $HOME/.config/nvim $HOME/.config/nvim.bak
fi
git clone https://github.com/lukecullison/neovim-config.git ~/.config/nvim

# Install packer.nvim
install_packer

# Install plugins
nvim --headless +PackerInstall +qall

echo "Neovim configuration setup complete!"
#echo "Neovim v0.9.5 and configuration setup complete!"
