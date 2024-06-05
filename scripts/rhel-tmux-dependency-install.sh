#!/bin/bash

# sudo yum install --enablerepo="*" epel-release --nobest
# sudo yum install tmux
sudo dnf groupinstall "Development Tools" -y
sudo dnf install ncurses-devel libevent libevent-devel ncurses-devel gcc make bison pkg-config -y

cd $HOME
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure && make
sudo make install
tmux -V
