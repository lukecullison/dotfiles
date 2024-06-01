#!/bin/bash

# Exit script on any error
set -e

# Function to install dependencies on Ubuntu
install_dependencies_ubuntu() {
  sudo apt-get update
  sudo apt-get install -y git zsh ripgrep tmux stow
}

# Function to install dependencies on Red Hat-based systems
install_dependencies_redhat() {
  sudo yum groupinstall -y 'Development Tools'
  sudo yum install -y git zsh ripgrep tmux stow
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

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Clone the Neovim configuration repository
if [ -f $HOME/.zshrc ]; then
  mv -f $HOME/.zshrc $HOME/.zshrc.bak
fi

# Determine the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Construct the directory of the executable
EXECUTABLE_DIR="${SCRIPT_DIR}/.."

# Change to the executable's directory
cd "$EXECUTABLE_DIR" || exit

# Run stow command
if [ -f /usr/bin/stow ]; then
    /usr/bin/stow zsh
else
    echo "stow executable missing!"
    exit 1
fi

echo "zsh configuration complete!"
