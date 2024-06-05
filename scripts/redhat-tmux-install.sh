#!/bin/bash

cd $HOME
wget https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz
tar -xzvf tmux-3.3a.tar.gz
cd tmux-3.3a
./configure
make
sudo make install
tmux -V
