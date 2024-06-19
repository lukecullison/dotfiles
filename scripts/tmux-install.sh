#!/bin/bash

# Exit script on any error
set -e

# Function to install dependencies on Arch
install_dependencies_arch() {
  sudo pacman -S --noconfirm tmux
}

# Function to install dependencies on Ubuntu
install_dependencies_ubuntu() {
  sudo apt-get update
  sudo apt-get install tmux
}

# Function to install dependencies on Red Hat-based systems
install_dependencies_redhat() {
  sudo yum groupinstall -y 'Development Tools'
  sudo yum install -y tmux
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
  arch)
    install_dependencies_arch
    ;;
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

# Setup tmux config
cd ../
/usr/bin/stow tmux

echo "Tmux configuration complete!"
